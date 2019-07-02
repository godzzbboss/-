function [ xx, yy, zz ] = plotLikelihood( data_train_x, data_train_y,  mean, cov, lik, inf, hyp)
% SEard�ˣ�һ��6������������Ȼ������ͼ�񣬳�������������������Ӧ�Ĵ���֮�⣬�����ĳ��������̶�
% hyp_cov = exp(hyp_cov);
% l_aoa = hyp_cov(1);
% l_ma = hyp_cov(2);
% l_speed = hyp_cov(3);
% l_area = hyp_cov(4);
% sf = hyp_cov(5);
[n,d] = size(data_train_x);
l_ma = linspace(0.01,10,300);
l_an = linspace(1,5,200);
[xx,yy] = meshgrid(l_ma,l_an);
[n1,d1] = size(xx);
% log�߼���Ȼ����ֵ
f = @gp;
for ii=1:1:n1 % ������
    for jj=1:1:d1 % ������
        disp(['�� ',num2str(ii*jj),' ��ѭ����'])
        tic
        hyp.cov(2) = log(xx(ii,jj)); % l_ma
%         exp(hyp_cov)
        hyp.lik = log(yy(ii,jj)); % an
        zz(ii,jj) = -f(hyp, inf, mean, cov, lik, data_train_x, data_train_y);
%         [K,dk] = feval(covFunc{:},hyp_cov,data_train_x); % ����K
%         [n2,d2] = size(K);
%         K_ = K+an^2*eye(n);
%         inv_K_ = pinv(K_);
%         det_K_ = det(K_);
% %         det_K_
%         zz(ii,jj) = -1/2*data_train_y'*inv_K_*data_train_y - 1/2*log(det_K_) - n/2*log(2*pi)
        toc
    end
end
end

