%% This file shouldn't be used, it's for experimentation and examining the 
%  data
clear all;
clc;

%gestures = load_gestures('Proj3_train_set/', '');
gestures = load_gestures('Proj3_train_set_additional/', '');

%%

g = gestures{20};

plot(g.dur, g.omega);
X = fft(g.omega);

X_mag = abs(X);
X_phase = angle(X);
N = length(g.omega);
fs = 10;
ts = 1/fs;
tmax = (N-1)*ts;

figure;
t = 0:ts:tmax;
plot(t,X_mag);

f = -fs/2:fs/(N-1):fs/2;
z = fftshift(X);
figure;
plot(f,abs(z));

% Fbins = ((0: 1/N: 1-1/N)*Fs).';
% 
% figure(1);
% hold on;
% plot3(X_mag(:,1),X_mag(:,2),X_mag(:,3), 'b*');
% plot3(X_phase(:,1),X_phase(:,2),X_phase(:,3), 'r*');
% hold off;
% 

% helperFFT(Fbins, X_mag, 'Magnitude Response');
% helperFFT(Fbins, X_phase, 'Frequency Response');

%spectrogram(g.omega);

%%

accel = gestures{1}.accel;
omega = gestures{1}.omega;
%imu_ts = gestures{1}.dur ./ 1000;

[ q_hist, R_hist ] = ukf_1( accel, omega );

%%

h = figure(1);

for gi = 1:30,
    
    omega = gestures{gi}.omega;
    accel = gestures{gi}.accel;
    nom = gestures{gi}.name;
    dur = gestures{gi}.dur * 0.001;
    ts = 1:length(omega);
    ts = ts + dur'; 
    
    processed = sum((omega(:,:) + accel(:,:)), 2)./12;
    Beta = 0.97;
    k = 1;
    preprocessed = [];
    t_s = [];
    for j = 2:1:length(processed),
        t_s(end+1) = ts(j);
        preprocessed(end+1) = processed(j)*Beta + processed(j-1)*(1-Beta);
    end
    clf;
    K = 100;
    [cidx, ctrs] = kmeans(preprocessed',K);
    C = {'ro','bo','co','mo','go','yo','ko','rx','bx','cx','mx'};
    %C = {'r','b','c','m','g','y','k','r','b','c','m'};
    hold on;
    for k = 1:K,
        c = mod(k,11)+1;
        plot(t_s(cidx==k), preprocessed(cidx==k), C{c}, 'LineWidth',3);
    end
    hold off;
    ylabels = {'roll', 'pitch', 'yaw'};
    
    for i = 1:1
%         subplot(3,1,i);
        hold on;
        plot(t_s, preprocessed, 'b', 'LineWidth', 1);
        
%         plot(ts(:), omega(:,i), 'b', 'LineWidth', 2);
%         plot(ts(:), accel(:,i), 'c', 'LineWidth', 2);
        if i == 1
            h = title(nom);
        end
        
        xlabel(ylabels(i));
        set(gca, 'Box', 'On');
        hold off;
        grid on;
        axis tight;
    end
    pause;
    
end

%%

close all;

C = {'ro','bo','co','mo','go','yo','ko','rx','bx','cx','mx'};

for g = 1:length(gestures),
%     accel = gestures{g}.accel;
%     omega = gestures{g}.omega;
    imu = gestures{g}.imu;
    name = gestures{g}.name;
    dur = gestures{g}.dur;
    
%     [cidx, ctrs] = kmeans(omega,150);
%     plot3_kmeans(name, omega, cidx, ctrs);
    [cidx, ctrs] = kmeans(imu(:,1:6),30);
    processed = sum((imu(:,1:3) + imu(:,4:6)), 2)./12;
%     processed = abs(fft(processed));
    plot3_kmeans(name, processed, dur, cidx, ctrs, true);
    
    pause;
end

% [cidx, ctrs] = kmeans(accel,9);
% plot3_kmeans(omega, cidx, ctrs);

%%

% for t = 1:length(Obs)-1,
%     for i = 1:N,
%         epsilon(i,:,t) = alpha(i,t)*(A(i,:).*B(Obs(t+1,:)).*beta(:,t+1)');
%     end
%     epsilon(:,:,t) = epsilon(:,:,t) / sum(sum(epsilon(:,:,t)));
% end
% %epsilon = epsilon + sum(epsilon,3);
% gamma(:,:) = (sum(epsilon,2));
% for i = 1:T,
%     gamma(:,i) = sum(gamma(:,(Obs==i)),2)';
% end
    

%LL = prob_ob_given_lambda(lambda.c);
