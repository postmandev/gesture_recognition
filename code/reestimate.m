function [ lambda ] = reestimate( lambda, gamma, epsilon, Obs )

N = lambda.N;       % number of states
M = lambda.M;       % number of symbol observations
T = length(Obs);       
Pi = lambda.Pi;
B = lambda.B;
A = lambda.A;

% re-estimte Pi
for i = 1:N,
    Pi(i) = gamma(i,1);
end

% re-estimte A
for i = 1:N,
    for j = 1:N,
        n = 0;
        d = 0;
        for t = 1:T-1,
            n = n + epsilon(i,j,t);
            d = d + gamma(i,t);
        end
        A(i,j) = n / d;
    end
end

% re-estimate B
for i = 1:N,
    for j = 1:M,
        n = 0;
        d = 0;
        for t = 1:T,
            if Obs(t) == j,
                n = n + gamma(i,t);
            end
            d = d + gamma(i,t);
        end
        B(i,j) = n / d;
    end
end

correction = 1e-7;

A(A < correction) = correction;
B(B < correction) = correction;

lambda.Pi = Pi;
lambda.B = B;
lambda.A = A;

        
end

