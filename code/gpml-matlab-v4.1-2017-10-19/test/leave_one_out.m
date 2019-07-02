clear all;
clc;
data_train = dlmread('./data/��������_��󼤲��߶�.csv',',', 1, 0);
% data_train = data_train(:,[1,2,3,4,5,6,7,8,12]);
% col_names = ['ͷ׶ֱ��','ǻ�����','�ŵ����','����ֱ��'];
% data_train = dlmread('./data/pca_3.csv',',', 0, 0);
% ��������
rng('default');
index1 = randperm(length(data_train));
data_train = data_train(index1,:);
% norm_data_train = data_train; 
% ��������
% cpv = data_train(:,3) ./ data_train(:,2); % ��λ����ŵ����
% touzhui_area = data_train(:,1).^2; % ͷ׶���
% chukou_area = data_train(:,4).^2; % �������
% new_cols = ['ͷ׶���', 'ǻ�����', '��λ�������','�������'];
% data_train = [data_train(:,1), data_train(:,2), cpv, data_train(:,[3:4]), data_train(:,5)];
% corr_mat = corr(data_train(:,[1:5]))
% ��׼��
 [n,d] = size(data_train);
[norm_data_x,mu,sigma] = zscore(data_train(:,[1:d-1]));
norm_data_train = [norm_data_x,data_train(:,d)];

% ���Ը�˹����ѵ��
infFunc = {@infGaussLik};
meanFunc = {@meanZero};
% covFunc = {@covADD,{[1,2,3,4,5,6,7,8,9,10,11],@covSEiso}};
covFunc = {@covSEard};
% covFunc = {@covPoly, 4};
% covFunc = {@covSM,3};
likFunc = @likGauss;
 
numinit = 10;
shortrun = 500;                                           
% ���߼���Ȼ��ѡ���ʼ������
f = @initHypers_SEard; % ��ʼ���˺���������
[train_rmses, res, hyp2] = LOO(norm_data_train, meanFunc, covFunc, likFunc, infFunc, numinit, shortrun, f);