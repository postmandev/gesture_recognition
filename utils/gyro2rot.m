function [ q, R ] = gyro2rot( gyro, dt, q )

a_delta = norm(gyro) .* dt;
e_delta = gyro / norm(gyro);
q_d = [cos(a_delta/2); e_delta * sin(a_delta/2)];

q = quatmultiply(q', q_d')';
R = quat2dcm(q')';
    
end

