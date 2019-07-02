function [ normed_data ] = zscore_transform( data, mu, sigma )
%  使用已有的均值和标准差对data标准化
[n, d] = size(data);
normed_data = zeros(n, d);
for i = 1:1:d
    normed_data(:,i) = (data(:,i) - mu(i)) ./ sigma(i);
end
end

