function [ gestures ] = load_gestures(dirname, gtype, merge_data, y_print)

if nargin < 4
    y_print = false;
end

if nargin < 3
    merge_data = false;
end

dirstruct = dir([dirname, gtype, '*.txt']);
N = length(dirstruct);
if N < 1
    gestures = [];
    return;
end

gestures = {[]};
last = '';
g = 0;
for i = 1:N,
    f = dirstruct(i).name;
    if y_print
        fprintf('current file: %s \n', f);
    end

    data = importdata([dirname,f]);
    str = strsplit(f,'.');
    s1 = str{1};
    fidx = isstrprop(s1, 'alpha');
    category_ = s1(fidx);

    if strcmp(category_, 'beat') || strcmp(category_, 'test')
        n_lts = length(category_);
        category = [category_, s1(n_lts+1)];
    else
        category = category_;
    end
    
    if merge_data
        if ~strcmp(category,last)
            last = category;
            gesture = [];
            gesture.name = category;
            gesture.dur = [];
            gesture.imu = [];
            g = g+1;
        end
    else
        gesture = [];
        gesture.name = category;
        gesture.dur = [];
        gesture.imu = [];
        g = g+1;
    end
    
    gesture.dur = [gesture.dur; data(:,1)];
    
    processed = data(:,2:7);
    %gesture.imu = [gesture.imu; data(:,2:7)];
    %processed = sum((data(:,2:4) + data(:,5:7)), 2)./12;
    %gesture.imu = processed;
    %gesture.imu = data(:,2:7);
    gesture.imu = [gesture.imu; processed];
    
    gestures{g} = gesture;

end

end

