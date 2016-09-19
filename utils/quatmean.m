function [ qm ] = quatmean( q )
%QUATMEAN Summary of this function goes here
%   Detailed explanation goes here

N = size(q,2);
qm = zeros(4,4);
for i = 1:N,
   qm = qm + (q(:,i) * q(:,i)');  
end

qm = qm / N;

qm = quatnormalize(qm);

qm(isnan(qm)) = 0;
qm(isinf(qm)) = 0;

[V,D] = eigs(qm);

qm = V(:,1);

% (1/n)*(q1*q1' + q2*q2' + q3*q3' .. + qn*q'); 
% Q*Q' principle eigenvector 4x4 
end

