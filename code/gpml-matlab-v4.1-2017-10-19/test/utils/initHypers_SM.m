% Initialisation script for SM kernel.  
% Andrew Gordon Wilson, 11 Oct 2013

% Example hyper initialisation for spectral mixture kernel.
% One can improve this initialisation scheme by sampling from (or
% projecting) the empirical spectral density.  

% This is not an all purpose initialisation script.  Common sense is 
% still required when initialising the SM kernel in new situations. 



function hypinit = initSMhypers(Q,x,y)
% n个样本，D维
[n,D] = size(x);

% create hypers
% w是一个行向量,为每个组件的权重
w = zeros(1,Q);
m = zeros(D,Q);
s = zeros(D,Q);

% create initialisation vector of all hypers
hypinit = zeros(Q+2*D*Q,1); % hypinit是一个列向量

% 给权重赋值,假设每个组分的权重都一样
w(1,:) = std(y)./Q;

% Simple initialisation
for i=1:D
    % sq_dist计算列向量之间的距离
    d2 = sqrt(sq_dist(x(:,i)'));   % get distances for each input dimension
    % 如果样本数大于1
%     if (n>1)
%       d2(d2 == 0) = d2(1,3);
%     else
    d2(d2 == 0) = 1;
    
    % min(d2),返回d2每一行最小的数，min(min(d2))返回矩阵中最小的数
    minshift = min(min(d2));
    nyquist = 0.5/minshift; 
    m(i,:) = nyquist*rand(1,Q);    % draw frequencies from Uniform(0,Nyquist)
    % for non-evenly spaced data, we approximate this as 1/minimum spacing 
    % between two points.  This factor 'nyquist' is *critical* for
    % achieving a good initialisation, and should be adjusted to the
    % problem at hand.
    
    maxshift = max(max(d2));
    s(i,:) = 1./abs(maxshift*randn(1,Q));  % length-scales have a truncated 
                                           % Gaussian distribution
                                           % with mean proportional to the max
                                           % range of the data.
end

hypinit(1:Q) = log(w);   
hypinit(Q+(1:Q*D)) = log(m(:));
hypinit(Q+Q*D+(1:Q*D)) = log(s(:));
