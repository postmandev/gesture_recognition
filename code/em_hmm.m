function [ lambda ] = em_hmm( lambda, obs )
% Expectation Maximization on Hidden Markov Model 
prevLogP = -Inf;
logP = -1e+20;

iters = 0;
while (iters < 100)
    iters = iters + 1;
    
    if logP > prevLogP, % && ~isnan(logP) && ~isinf(logP)
        prevLogP = logP;
    
        [alpha, lambda, logP] = alpha_pass( lambda, obs );
        
        fprintf('iteration = %d  log probability: %f\n', iters, logP);
        
        beta  = beta_pass( lambda, obs );
        [epsilon, gamma] = compute_gamma( lambda, obs, alpha, beta );
        lambda = reestimate( lambda, gamma, epsilon, obs );
    else
        break;
    end
end

end

