function [ hyp_mean_init, hyp_cov_init, hyp_sn_init, nlmls ] = maxMarginalLikelihood( data_train_x, data_train_y, meanFunc, covFunc, likFunc, infFunc, numinit, shortrun, initHypers_f)
% 通过最大边际似然法选择超参数
% 均值使用一个高斯过程去预测，hyp_mean为均值函数的参数
disp('begin initial!!')
nlml = Inf;
nlmls = [];
Q = 3; % SM
for j=1:numinit
    disp(['the ',num2str(j),'times initial'])
    hyp_cov_try = initHypers_f(data_train_x);    % initialise SEiso hypers
%     hyp_cov_try = initHypers_f(Q, data_train_x, data_train_y);    % initialise SM hypers
    sn = rand(1,1); % sn 
    hyp.mean = [];
%     means = [means; hyp.mean];
    hyp.cov = hyp_cov_try;
    hyp.lik = log(sn);
    % short optimization run for each of these numinit initialisations
    % you may want to change shortrun to simply -1, and subsequently 
    % increase numinit.  play with the tradeoff between numinit and 
    % shortrun to see how it affects the (consistency of the) results.
%     shortrun = 500;
    tic
    hyp2 = minimize(hyp, @gp, -shortrun, infFunc, meanFunc, covFunc, likFunc, data_train_x, data_train_y);
    nlml_new = gp(hyp2, infFunc, meanFunc, covFunc, likFunc, data_train_x, data_train_y);
    toc
    if (nlml_new < nlml)
        hyp_cov_init = hyp_cov_try;
        hyp_sn_init = log(sn);
        hyp_mean_init = hyp.mean;
        nlml = nlml_new;
        nlmls = [nlmls;nlml];
    end
end
end

