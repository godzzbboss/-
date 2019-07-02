function [ train_rmses, res , hyp2] = LOO( data,meanFunc, covFunc, likFunc, infFunc, numinit, shortrun, initHyper_f)
%LOO 留一交叉验证
%   leave one out 
[n, d] = size(data);
index = [1:n];
res = struct('true',[],'pred',[], 's2',[]); % 保存每折交叉验证测试样本的真实值、预测值和预测方差。
train_rmses = [];

for i=1:n
    test_idx = index == i;
    train_idx = ~test_idx;
    data_train = data(train_idx,:);
    data_test = data(test_idx,:);
    data_train_x = data_train(:, [1:d-1]);
    data_train_y = data_train(:, d);
    data_test_x = data_test(:, [1:d-1]);
    data_test_y = data_test(:, d);
   
    % 初始超参数选择
    [hyp_mean_init, hyp_cov_init, hyp_sn_init, nlmls] = maxMarginalLikelihood(data_train_x, data_train_y, meanFunc, covFunc, likFunc, infFunc, numinit, shortrun, initHyper_f);
    hyp.mean = hyp_mean_init;
    hyp.cov= hyp_cov_init;
    hyp.lik = hyp_sn_init;
    % [n,d] = size(data_train_x);
    [hyp2,fx,i] = minimize(hyp,@gp,-shortrun,infFunc,meanFunc,covFunc,likFunc,data_train_x,data_train_y);
    [y_mean_train,y_s2_train,f_mean_train,f_s2_train] = gp(hyp2, infFunc, meanFunc, covFunc, likFunc, data_train_x, data_train_y, data_train_x); % 训练集预测结果
    [y_mean_test,y_s2_test,f_mean_test,f_s2_test] = gp(hyp2,infFunc, meanFunc, covFunc, likFunc, data_train_x, data_train_y, data_test_x); % 测试集预测结果
    
    train_rmse = RMSE(y_mean_train, data_train_y);
    train_rmses = [train_rmses; train_rmse];
    res.true = [res.true; data_test_y];
    res.pred = [res.pred; y_mean_test];
    res.s2 = [res.s2; y_s2_test];
end

