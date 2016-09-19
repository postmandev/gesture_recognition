function [ q ] = vec2quat( vec )
%VEC2QUAT Summary of this function goes here
%   Detailed explanation goes here

theta = sqrt(sum(vec(1:3,:).*vec(1:3,:),1));

qv = bsxfun(@rdivide, vec(1:3,:), theta);
qv(isnan(qv)) = 0;

q = [cos(theta/2); bsxfun(@times, qv, sin(theta/2))];

end

