function [ n ] = vec2norm( x, dim )
%VEC2NORM calculates 2-norm along dim 
%   Detailed explanation goes here

n = sqrt(sum(x.^2, dim));

end

