function [ qstar ] = quatconj( q )
%Q_CONJUGATE Summary of this function goes here
%   Detailed explanation goes here

qstar = [q(:,1) -q(:,2:4)];

end

