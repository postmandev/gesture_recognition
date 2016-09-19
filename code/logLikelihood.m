function [ logP ] = logLikelihood( c )

C = length(c);

logP = 0;
for i = 1:C,
    logP = logP + log(c(i));
end
logP = -logP;

end

