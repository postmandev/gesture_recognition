function [ n ] = quatmultiply( q, r )
% input
% n*4 and n*4 quat
% output
% n*4 quat

n(:,1) = r(:,1).*q(:,1) - r(:,2).*q(:,2) - r(:,3).*q(:,3) - r(:,4).*q(:,4);
n(:,2) = r(:,1).*q(:,2) + r(:,2).*q(:,1) - r(:,3).*q(:,4) + r(:,4).*q(:,3);
n(:,3) = r(:,1).*q(:,3) + r(:,2).*q(:,4) + r(:,3).*q(:,1) - r(:,4).*q(:,2);
n(:,4) = r(:,1).*q(:,4) - r(:,2).*q(:,3) + r(:,3).*q(:,2) + r(:,4).*q(:,1);

   
% vec = [q(:,1).*r(:,2) q(:,1).*r(:,3) q(:,1).*r(:,4)] + ...
%          [r(:,1).*q(:,2) r(:,1).*q(:,3) r(:,1).*q(:,4)]+...
%          [ q(:,3).*r(:,4)-q(:,4).*r(:,3) ...
%            q(:,4).*r(:,2)-q(:,2).*r(:,4) ...
%            q(:,2).*r(:,3)-q(:,3).*r(:,2)];
% 

% Calculate scalar portion of quaternion product
% scalar = s1*s2 - dot(v1,v2)
% scalar = q(:,1).*r(:,1) - q(:,2).*r(:,2) - ...
%          q(:,3).*r(:,3) - q(:,4).*r(:,4);
    
% Q = [scalar  vec];

% enforce unit length
% mag= Q(1)* Q(1) +  Q(2)* Q(2) +  Q(3)* Q(3) +  Q(4)* Q(4);
% 
% if abs(mag-1.0) >= 0.0001
%     mag=1.0/sqrt( mag);
%     Q(1)=Q(1)* mag;
%     Q(2)=Q(2)* mag;
%     Q(3)=Q(3)* mag;
%     Q(4)=Q(4)* mag;
% end

end

