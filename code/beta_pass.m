function [ beta ] = beta_pass( lambda, Obs )

N = lambda.N;       % number of states
T = length(Obs);
B = lambda.B;
A = lambda.A;
c = lambda.c;

beta = zeros(N,T);
for i = 1:N,
    beta(i,T) = c(T);
end

for t = T-1:-1:1,
    for i = 1:N
        beta(i,t) = 0;
        for j = 1:N
            beta(i,t) = beta(i,t) + A(i,j)*B(j,Obs(t+1))*beta(j,t+1);
        end
        beta(i,t) = c(t)*beta(i,t);
    end
end

end
