function [ offset ] = sync_timestep( ts1, ts2 )
%SYNC_TIMESTEP 
%   

d1 = abs(ts1(1) - ts2);
[m1, idx1] = min(d1);

d2 = abs(ts2(1) - ts1);
[m2, idx2] = min(d2);

if m1 < m2
    offset = idx1;
else
    offset = idx2;
end

end

