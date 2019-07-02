function [ result ] = RMSE( x1, x2 )
%RMSE 返回两个向量的均方根误差
%   此处显示详细说明
result = sqrt(sum((x1-x2).^2))/length(x1);

end

