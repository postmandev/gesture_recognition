function [ lambda ] = initialize_lambda( data, N, M )

lambda = [];

A = zeros(N,N);         % transition matrix
B = ones(N,M) * 1/M;    % emissions matrix
T = length(data);        % T observations

opt = 0; % must be 0, others don't work

if opt == 1,
    % Basic Ergodic A matrix
    Pi = ones(1,N) * (1/N); % initial state vector
    %Pi = rand(N,1);
    for s = 1:N,
        for r = 1:N,
            A(s,r) = 1/N;
        end
    end
elseif opt == 2
    % Left-Right initialization
    Pi = zeros(1,N); Pi(1) = 1;   % initial state vector

    for s = 1:N-1,
        for r = 1:N,
            if s == r
                A(s,r) = 1 - 1/(T/N);
                A(s+1,r) = 1 - A(s,r);
            end
        end
    end

    A(N,N) = 1;
else
    
    % This is the only option that works
    Pi = ones(1,N) * 1/N; 
    Pi(1) = 0.5;   % initial state vector

    %A = ones(N,N) * (1 - (1 - 1/N));
    for s = 1:N,
        for r = 1:N,
            if s == r
                A(s,r) = 1 - 1/N;
            else
                A(s,r) = 1 - A(1,1);
            end
        end
    end
    
    %A = A ./ repmat(sum(A),7,1);
    %A(1,N) = 1 - A(1,1);
    
end

lambda.A = A;
lambda.B = B;
lambda.Pi = Pi;
lambda.N = N;
lambda.M = M;
lambda.T = T;
lambda.c = zeros(1,T);

end

