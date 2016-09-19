function [ R ] = rotY( y )
%ROTX Summary of this function goes here
%   Detailed explanation goes here

R = [cos(y) 0 sin(y); 0 1 0; -sin(y) 0 cos(y)];

end

