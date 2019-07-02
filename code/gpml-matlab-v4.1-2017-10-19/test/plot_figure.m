% 训练误差盒装图
% labels = {'poly2','poly3','poly4','se-iso','se-ard','sm','add-all','add-157910'};
% boxplot(final_train_rmses);
% set(gca, 'XTickLabels',labels, 'XTickLabelRotation', 60);

% 测试误差曲线
% labels = {'poly2','poly3','poly4','se-iso','se-ard','sm','add-1234','add-134', 'true'};
% N = 8;
% C = linspecer(N);
% sz = 30;
% hold on;
% for i=1:8
%     plot(final_test_res(:,i), 'LineWidth',2, 'Color', C(i,:), 'Marker','.', 'MarkerSize', 20);
%     %scatter([1:15], final_test_res(:,i),  sz, 'MarkerFaceColor', C(i,:), 'MarkerEdgeColor', C(i,:));
% end
% plot(test_y_true, 'LineWidth',3, 'Color', 'r', 'Marker', '.','MarkerSize', 25);
% %scatter([1:15], test_y_true,  45, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
% legend(labels);

% 7个核14个测试样本的绝对误差盒装图
% test_error = zeros(28, 7);
% for i=1:7
%     test_error(:,i) = abs(final_test_res(:,i) - true_test_y);
% end
% labels = {'poly2','poly3','poly4','se-iso','se-ard','sm','add-all'};
% boxplot(test_error);
% set(gca, 'XTickLabels',labels, 'XTickLabelRotation', 60);

% errorbar 
% hold on;
% plot(poly2_res.true, 'color','b');
% errorbar([1:28],poly2_res.pred,2*sqrt(poly2_res.s2));

% 可视化真实数据与生成的数据
% all_true = res.true;
% [n,d] = size(all_true);
% ids = []; % 所有生成的元素
% for i = 1:n
%     id = ismember(all_true(i),true_test_y);
%     if id == 0
%         ids = [ids,i];
%     end
% end
% generate_data = all_true(ids);
% hold on;
% scatter([1:16], generate_data, 20, 'filled');
% scatter([1:28], true_test_y, 20, 'filled');

% 过采样后的预测结果
% hold on;
% all_true = res.true;
% [n,d] = size(all_true);
% ids = []; % 所有生成的元素
% for i = 1:n
%     id = ismember(all_true(i),true_test_y);
%     if id == 1
%         ids = [ids;i];
%     end
% end
% origin_data_true = all_true(ids);
% origin_data_pred = res.pred(ids);
% pred_s2 = res.s2(ids);
% RMSE(origin_data_true, origin_data_pred)
% plot(origin_data_true);
% errorbar([1:28],origin_data_pred,2*sqrt(pred_s2));
    


    
    





