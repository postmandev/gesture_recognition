function [ R ] = accel2rot( acc ) %, bias, scale_factor ) %acc, R_hat )
%ACCEL2ROT convert accelerometer data to a rotation matrix


% r = sqrt(sum(acc.^2));
% phi = acos(acc(1)/r);
% theta = acos(acc(2)/r);
% psi = acos(acc(3)/r);
% 
% alt = [0 0 -1; 0 1 0; 1 0 0];
% R = alt*rotZ(psi)*rotY(theta)*rotX(phi);


% acc = bsxfun(@minus, raw, bias);
% acc = bsxfun(@times, scale_factor, acc);
% acc(1:2,:) = -acc(1:2,:);
d = sqrt(sum(power(acc,2)));
acc = bsxfun(@rdivide, acc, d);

R = zeros(3,3,size(acc,2));
acc(1:2,:) = -acc(1:2,:);

s_roll = -acc(2,:);
c_roll = sqrt(1 - s_roll.*s_roll);
s_pitch = -acc(1,:) ./ c_roll;
c_pitch = acc(3,:) ./ c_roll;

R(1,1,:) = c_pitch;
R(1,2,:) = s_roll .* s_pitch;
R(1,3,:) = -acc(1,:);
R(2,2,:) = c_roll;
R(2,3,:) = s_roll;
R(3,1,:) = s_pitch;
R(3,2,:) = -c_pitch .* s_roll;
R(3,3,:) = acc(3,:);

%R = R * R_hat;

end

