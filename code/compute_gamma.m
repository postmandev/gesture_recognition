function [ epsilon, gamma ] = compute_gamma( lambda, Obs, alpha, beta )

N = lambda.N;
T = length(Obs);
B = lambda.B;
A = lambda.A;

gamma = zeros(N,T);
epsilon = zeros(N,N,T);

for t = 1:T-1,
    d = 0;
    for i = 1:N,
        for j = 1:N,
            d = d + alpha(i,t)*A(i,j)*B(j, Obs(t+1))*beta(j,t+1);
        end
    end
    for i = 1:N,
        gamma(i,t) = 0;
        for j = 1:N,
            epsilon(i,j,t) = (alpha(i,t)*A(i,j)*B(j,Obs(t+1))*beta(j,t+1))/d;
            gamma(i,t) = gamma(i,t) + epsilon(i,j,t);
        end
    end
end

d = 0;
for i = 1:N,
    d = d + alpha(i,T);
end
for i = 1:N
    gamma(i,T) = alpha(i,T)/d;
end


end

