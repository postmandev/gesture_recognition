function [ vec ] = quat2vec( q )
%QUAT2VEC Summary of this function goes here
%   Detailed explanation goes here

vec = bsxfun(@rdivide, q(2:4,:), sqrt(1-q(1,:).*q(1,:)));
vec(isnan(vec)) = 0;

a = 2*acos(q(1,:));

vec = bsxfun(@times, vec, a);

end

