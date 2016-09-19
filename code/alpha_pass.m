function [ alpha, lambda, likelihood ] = alpha_pass( lambda, Obs )

if ~isstruct(lambda),
    alpha = [];
    lambda = NaN;
    likelihood = -Inf;
    return;
end

N = lambda.N;
T = length(Obs);
Pi = lambda.Pi;
B = lambda.B;
A = lambda.A;
c = lambda.c;

alpha = zeros(N,T);

% compute alpha(1)
for i = 1:N,
    alpha(i,1) = Pi(i)*B(i,Obs(1));
    c(1) = c(1) + alpha(i,1);
end

% scale alpha(1)
c(1) = 1/c(1);
for i = 1:N
    alpha(i,1) = c(1)*alpha(i,1);
end

% compute alpha(t)
for t = 2:T
    c(t) = 0;
    for i = 1:N
        alpha(i,t) = 0;
        for j = 1:N
            alpha(i,t) = alpha(i,t) + alpha(j,t-1)*A(j,i);
        end
        alpha(i,t) = alpha(i,t)*B(i,Obs(t));
        c(t) = c(t) + alpha(i,t);
    end
    c(t) = 1/c(t);
    for i = 1:N
        alpha(i,t) = c(t)*alpha(i,t);
    end
end

% save scale factor for use in beta_pass
lambda.c = c;

likelihood = logLikelihood( c );

end
