function plot3_kmeans( nom, data, dur, cidx, ctrs, oneD )

if nargin < 6
    oneD = false;
end

K = length(ctrs);
h = figure(1);
clf(h);
title(nom);
C = {'ro','bo','co','mo','go','yo','ko','rx','bx','cx','mx'};
C = {'r.','b.','c.','m.','g.','y.','k.','r+','b+','c+','m+'};
%C = {'r','b','c','m','g','y','k','r','b','c','m'};
if oneD
    ts = 1:length(data);
    ts = ts + dur'; 
    hold on;
    for k = 1:K,
        c = mod(k,11)+1;
        plot(ts(cidx==k), data(cidx==k)', C{c});
    end
    hold off;
else

    hold on;
    for k = 1:K,
        c = mod(k,11)+1;
       plot3(data(cidx==k,1),data(cidx==k,2),data(cidx==k,3), C{c});
    end
    %plot3(ctrs(:,1),ctrs(:,2),ctrs(:,3), 'g*', 'LineWidth', 7);
    set(gca, 'Box', 'On');
    hold off;
    grid on;
    axis tight;
end

end

