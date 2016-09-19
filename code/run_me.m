%% First - Load training and test gesture data
% then I run kmeans to segment all the data
%
%  Make sure this file and training and testing sets can be loaded.

clear all;
clc;
addpath(genpath(pwd));

N = 7;             % number of states
M = 45;            % number of observation symbols

% load both training and test data
train = load_gestures('Proj3_train_set/', '', false, true);
%test = load_gestures('Proj3_train_set_additional/', '', false, true);
test = load_gestures('Proj3_test_set/', '', false, true);

bigdata = [];
for g = 1:length(train), bigdata = [bigdata; train{g}.imu]; end
for g = 1:length(test),  bigdata = [bigdata; test{g}.imu];  end

[obs, ctrs] = kmeans( bigdata, M );
%plot3_kmeans('all', bigdata, [], obs, ctrs, false);

%% Second - Training the HMM
% 
clc;
%train = load_gestures('Proj3_train_set/', '', false, false);

for g = 1:length(train),

    name = train{g}.name;
    if strcmp(name,''),  % instead of '' you can hold out one gesture e.g. 'beat3'
        train{g}.lambda = NaN;
        continue;
    end
    fprintf('\nTraining gesture: %s \n', name);
    imu = train{g}.imu;
    dur = train{g}.dur;
    lambda = initialize_lambda( imu, N, M );
    the_obs = get_obs(bigdata, obs, imu);
    
    % plot3_kmeans(train{g}.name, imu, dur, the_obs, ctrs, false);
    % pause;
    
    lambda = em_hmm( lambda, the_obs );
    
    % save lambda for testing
    train{g}.lambda = lambda;
    
end


%% Third - Testing the HMM 
% This section runs the alpha_pass to get maximum likelihood

%clc;
%test = load_gestures('Proj3_train_set_additional/', '', false, false);

for g = 1:length(test),

    fprintf('\nTesting gesture: %s \n', test{g}.name);
    imu = test{g}.imu;
    lambda = initialize_lambda( imu, N, M );
    the_obs = get_obs(bigdata, obs, imu);

    LL = zeros(1,length(train));
    for h = 1:length(train),
        [~, ~, LL(h)] = alpha_pass( train{h}.lambda, the_obs );
    end
    [y,idx] = sort(LL,'descend');
    for i = 1:3,
        fprintf('guess #%i: %s log-likelihood = %f\n',i, train{idx(i)}.name, y(i));
    end
    
end
