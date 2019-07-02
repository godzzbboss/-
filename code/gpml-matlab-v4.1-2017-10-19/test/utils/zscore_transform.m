function [ normed_data ] = zscore_transform( data, mu, sigma )
%  ʹ�����еľ�ֵ�ͱ�׼���data��׼��
[n, d] = size(data);
normed_data = zeros(n, d);
for i = 1:1:d
    normed_data(:,i) = (data(:,i) - mu(i)) ./ sigma(i);
end
end

