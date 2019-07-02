function [ train_rmses, res , hyp2] = CrossValid( data, K, meanFunc, covFunc, likFunc, infFunc, numinit, shortrun, initHyper_f)
%K�۽�����֤
rng('default');
[n, d] = size(data);
index = crossvalind('Kfold', n, K);
res = struct('true',[],'pred',[], 's2',[]); % ����ÿ�۽�����֤������������ʵֵ��Ԥ��ֵ��Ԥ�ⷽ�
train_rmses = [];
for i=1:1:K
    test_ids = index == i;
    train_ids = ~test_ids;
    train_data = data(train_ids, :);
    test_data = data(test_ids, :);
    data_train_x = train_data(:, [1: d - 1]);
    data_train_y = train_data(:, d);
    data_test_x = test_data(:, [1: d - 1]);
    data_test_y = test_data(:, d);
    
    % ��ʼ������ѡ��
    [hyp_mean_init, hyp_cov_init, hyp_sn_init, nlmls] = maxMarginalLikelihood(data_train_x, data_train_y, meanFunc, covFunc, likFunc, infFunc, numinit, shortrun, initHyper_f);
    hyp.mean = hyp_mean_init;
    hyp.cov= hyp_cov_init;
    hyp.lik = hyp_sn_init;
    % [n,d] = size(data_train_x);
    [hyp2,fx,i] = minimize(hyp,@gp,-shortrun,infFunc,meanFunc,covFunc,likFunc,data_train_x,data_train_y);
    [y_mean_train,y_s2_train,f_mean_train,f_s2_train] = gp(hyp2, infFunc, meanFunc, covFunc, likFunc, data_train_x, data_train_y, data_train_x); % ѵ����Ԥ����
    [y_mean_test,y_s2_test,f_mean_test,f_s2_test] = gp(hyp2,infFunc, meanFunc, covFunc, likFunc, data_train_x, data_train_y, data_test_x); % ���Լ�Ԥ����
    
    train_rmse = RMSE(y_mean_train, data_train_y);
    train_rmses = [train_rmses; train_rmse];
    res.true = [res.true; data_test_y];
    res.pred = [res.pred; y_mean_test];
    res.s2 = [res.s2; y_s2_test];
end
end


