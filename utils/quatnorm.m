function [ qout ] = quatnorm( q )
%QUATNORM Summary of this function goes here
%   Detailed explanation goes here

if any(~isreal(q(:)))
    error(message('aero:quatnorm:isNotReal'));
end

if (size(q,2) ~= 4)
    error(message('aero:quatnorm:wrongDimension'));
end

for i = size(q,1):-1:1
    qnorm(i,:) = norm(q(i,:),2);
end

qout = qnorm.*qnorm;

end

