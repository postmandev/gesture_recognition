function q = quatnormalize( q )
%QUATNORMALIZE enforce unit length

mag= q(1)* q(1) +  q(2)* q(2) +  q(3)* q(3) +  q(4)* q(4);

if abs(mag - 1.0) >= 0.0001
    mag = 1.0 / sqrt(mag);
    q(1) = q(1) * mag;
    q(2) = q(2) * mag;
    q(3) = q(3) * mag;
    q(4) = q(4) * mag;
end


end

