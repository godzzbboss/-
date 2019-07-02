% Initialisation script for composited kernel.  
function hypinit = initPolyhypers(data_x)
[n,d] = size(data_x);
% create initialisation vector of all hypers
hypinit = zeros(2,1); % hypinit???????????
% Simple initialisation
% rng(3);
hyp_cov1 = 2+rand(1,1);
hyp_cov2 = 2+rand(1,1);
% hyp_cov3 = randn(1,1);
% hyp_cov6 = abs(randn(1,1));
% hyp_cov7 = abs(randn(1,1));
% hyp_cov8 = abs(randn(1,1));
% hyp_cov9 = abs(randn(1,1));
% hyp_cov10 = abs(randn(1,1));
% hyp_cov11 = abs(randn(1,1));
% hyp_cov12 = abs(randn(1,1));

hypinit(1) = log(hyp_cov1);
hypinit(2) = log(hyp_cov2);
% hypinit(3) = log(hyp_cov3);
% hypinit(6) = log(hyp_cov6);
% hypinit(7) = log(hyp_cov7);
% hypinit(8) = log(hyp_cov8);
% hypinit(9) = log(hyp_cov9);
% hypinit(10) = log(hyp_cov10);
% hypinit(11) = log(hyp_cov11);
% hypinit(12) = log(hyp_cov12);
end
