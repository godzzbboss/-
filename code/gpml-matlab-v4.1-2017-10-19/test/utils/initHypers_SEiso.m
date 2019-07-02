% Initialisation script for composited kernel.  
function hypinit = initPolyhypers(data_x)
[n,d] = size(data_x);
% create initialisation vector of all hypers
hypinit = zeros(2,1); % hypinit???????????
% Simple initialisation
% rng(3);
hyp_cov1 = abs(randn(1,1));
hyp_cov2 = abs(randn(1,1));

hypinit(1) = log(hyp_cov1);
hypinit(2) = log(hyp_cov2);
end
