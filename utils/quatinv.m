function [ qinv ] = quatinv( q )
%QUATINV Summary of this function goes here
%   Detailed explanation goes here

%qinv = quatconj(q) ./ (quatnorm(q) * ones(1,4));
qinv = quatnormalize(quatconj(q));

end

