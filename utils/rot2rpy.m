function [ phi, theta, psi ] = rot2rpy( R )

% theta = asin(-R(3,1));
% phi = atan2(R(3,2),R(3,3));
% psi = atan2(R(1,1), R(2,1));

theta = atan2(-R(3,1), sqrt(R(1,1)^2 + R(2,1)^2));
psi = atan2(R(2,1), R(1,1));
phi = atan2(R(3,2), R(3,3));

end

