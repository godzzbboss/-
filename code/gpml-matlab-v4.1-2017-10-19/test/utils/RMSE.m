function [ result ] = RMSE( x1, x2 )
%RMSE �������������ľ��������
%   �˴���ʾ��ϸ˵��
result = sqrt(sum((x1-x2).^2))/length(x1);

end

