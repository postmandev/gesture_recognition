function [ eul ] = rots2rpy( R )

n = size(R,3);

eul = zeros(3, n);
for i = 1:n,
   
    [roll,pitch,yaw] = rot2rpy(R(:,:,i));

    eul(1,i) = roll;
    eul(2,i) = pitch;
    eul(3,i) = yaw;
    
end

end

