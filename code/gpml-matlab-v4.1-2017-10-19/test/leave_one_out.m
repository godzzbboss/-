clear all;
clc;
data_train = dlmread('./data/横向喷流_最大激波高度.csv',',', 1, 0);
% data_train = data_train(:,[1,2,3,4,5,6,7,8,12]);
% col_names = ['头锥直经','腔体体积','放电电容','出口直径'];
% data_train = dlmread('./data/pca_3.csv',',', 0, 0);
% 打乱数据
rng('default');
index1 = randperm(length(data_train));
data_train = data_train(index1,:);
% norm_data_train = data_train; 
% 特征工程
% cpv = data_train(:,3) ./ data_train(:,2); % 单位体积放电电容
% touzhui_area = data_train(:,1).^2; % 头锥面积
% chukou_area = data_train(:,4).^2; % 出口面积
% new_cols = ['头锥面积', '腔体体积', '单位体积电容','出口面积'];
% data_train = [data_train(:,1), data_train(:,2), cpv, data_train(:,[3:4]), data_train(:,5)];
% corr_mat = corr(data_train(:,[1:5]))
% 标准化
 [n,d] = size(data_train);
[norm_data_x,mu,sigma] = zscore(data_train(:,[1:d-1]));
norm_data_train = [norm_data_x,data_train(:,d)];

% 加性高斯过程训练
infFunc = {@infGaussLik};
meanFunc = {@meanZero};
% covFunc = {@covADD,{[1,2,3,4,5,6,7,8,9,10,11],@covSEiso}};
covFunc = {@covSEard};
% covFunc = {@covPoly, 4};
% covFunc = {@covSM,3};
likFunc = @likGauss;
 
numinit = 10;
shortrun = 500;                                           
% 最大边际似然法选择初始超参数
f = @initHypers_SEard; % 初始化核函数超参数
[train_rmses, res, hyp2] = LOO(norm_data_train, meanFunc, covFunc, likFunc, infFunc, numinit, shortrun, f);