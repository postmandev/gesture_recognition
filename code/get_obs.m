function [ state ] = get_obs( bigdata, obs, data )

idx = find(ismember(bigdata, data,'rows'));
state = obs(idx);

end

