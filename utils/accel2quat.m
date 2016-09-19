function [q, R] = accel2quat( raw, bias, scale_factor, q ) %acc, q )

acc = (raw-bias) * scale_factor;
acc(1:2) = -acc(1:2);

acc = normc(acc);
roll = atan2(acc(2), acc(3));
pitch = atan2(acc(1), sqrt(acc(2).*acc(2) + acc(3).*acc(3)));
q_d = angle2quat(0, pitch, roll);

q = quatmultiply(q', q_d)';
R = quat2dcm(q');


end

