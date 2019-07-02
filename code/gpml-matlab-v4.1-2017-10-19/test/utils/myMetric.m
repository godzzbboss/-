function [ rmse, nrmse, mll ] = myMetric( true_y, pred_y ,pred_s2)
% 返回均方根误差，标准化的均方根误差跟log loss
rmse = sqrt(mean((true_y - pred_y).^2));
nrmse = sqrt(mean((true_y - pred_y).^2)/var(true_y));
mll = mean(1/2*log(2*pi*sqrt(pred_s2))+(true_y-pred_y).^2./(2*pred_s2));

end

