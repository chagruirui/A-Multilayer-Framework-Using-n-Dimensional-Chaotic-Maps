% 计算并绘制二维离散混沌系统李雅普诺夫指数热图
clear; clc; close all;

% 设置参数范围
a_min = 0.5;
a_max = 1.5;
b_min = 0.1;
b_max = 0.5;
a_steps = 200;  % a参数的分辨率
b_steps = 200;  % b参数的分辨率

% 创建参数网格
a_values = linspace(a_min, a_max, a_steps);
b_values = linspace(b_min, b_max, b_steps);
[A, B] = meshgrid(a_values, b_values);

% 初始化李雅普诺夫指数矩阵
lyap_exp = zeros(size(A));

% 设置迭代参数
transient = 1000;  % 瞬态迭代次数（排除初始 transient）
iterations = 5000; % 用于计算李雅普诺夫指数的迭代次数

% 循环计算每个参数点的李雅普诺夫指数
fprintf('计算进度: 0.0%%');
for i = 1:size(A, 1)
    for j = 1:size(A, 2)
        a = A(i, j);
        b = B(i, j);
        
        % 初始化系统状态
        x = 0.1;
        y = 0.1;
        
        % 先迭代 transient 次，排除初始 transient
        for k = 1:transient
            x_new = 1 - a*x^2 + y;
            y_new = b*x;
            x = x_new;
            y = y_new;
        end
        
        % 初始化雅可比矩阵和Lyapunov指数计算变量
        J = eye(2);  % 初始雅可比矩阵为单位矩阵
        total_lyap = 0;
        
        % 计算Lyapunov指数
        for k = 1:iterations
            % 系统方程 (Hénon映射)
            x_new = 1 - a*x^2 + y;
            y_new = b*x;
            
            % 当前点的雅可比矩阵
            J_current = [-2*a*x, 1; 
                         b,      0];
            
            % 更新雅可比矩阵乘积
            J = J_current * J;
            
            % 定期进行QR分解以避免数值不稳定
            if mod(k, 50) == 0
                [Q, R] = qr(J);
                J = Q;
                total_lyap = total_lyap + log(abs(diag(R)));
            end
            
            % 更新系统状态
            x = x_new;
            y = y_new;
        end
        
        % 最终QR分解
        [~, R] = qr(J);
        total_lyap = total_lyap + log(abs(diag(R)));
        
        % 计算平均Lyapunov指数（取最大值）
        lyap_exp(i, j) = max(total_lyap / iterations);
    end
    fprintf('\b\b\b\b\b%5.1f%%', i/size(A, 1)*100);
end
fprintf('\n');

% 绘制热图
figure('Position', [100, 100, 800, 600]);
imagesc(a_values, b_values, lyap_exp);
set(gca, 'YDir', 'normal');  % 确保y轴方向正确
colormap('jet');
colorbar;
caxis([-2, 2]);  % 设置颜色范围，可根据实际情况调整

% 设置标签和标题
xlabel('参数 a', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('参数 b', 'FontSize', 12, 'FontName', 'Times New Roman');
title('Hénon映射最大李雅普诺夫指数热图', 'FontSize', 14, 'FontName', 'Times New Roman');

% 设置坐标轴字体
set(gca, 'FontName', 'Times New Roman');

% 保存图像（可选）
% saveas(gcf, 'lyapunov_exponent_heatmap.png');