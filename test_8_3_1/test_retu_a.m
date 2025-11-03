% 计算并绘制三维离散混沌系统李雅普诺夫指数热图
clear; clc; close all;

% 设置参数范围
b_min = 0.1;
b_max = 10.0;
c_min = 0.1;
c_max = 10.0;
b_steps = 100;  % b参数的分辨率
c_steps = 100;  % c参数的分辨率
a_fixed = 10;    % 固定参数a的值

% 创建参数网格
b_values = linspace(b_min, b_max, b_steps);
c_values = linspace(c_min, c_max, c_steps);
[B, C] = meshgrid(b_values, c_values);

% 初始化李雅普诺夫指数矩阵
lyap_exp = zeros(size(B));

% 设置迭代参数
transient = 2000;  % 瞬态迭代次数（排除初始 transient）
iterations = 5000; % 用于计算李雅普诺夫指数的迭代次数

% 循环计算每个参数点的李雅普诺夫指数
fprintf('计算进度: 0.0%%');
for i = 1:size(B, 1)
    for j = 1:size(B, 2)
        b = B(i, j);
        c = C(i, j);
        a = a_fixed;
        
        try
            % 初始化系统状态
            x = 1;
            y = 1;
            z = 1;
            
            % 先迭代 transient 次，排除初始 transient
            for k = 1:transient
                x_new = cos(a*z + 2*pi*(c*x*(1-x^2)));
                y_new = sin(b*x_new - 2*pi*(b - y^2));
                
                % 处理可能的除零错误
                if abs(z) < 1e-10
                    z_new = cos(c*y_new + 2*pi*(sin(a/1e-10)));
                else
                    z_new = cos(c*y_new + 2*pi*(sin(a/z)));
                end
                
                x = x_new;
                y = y_new;
                z = z_new;
            end
            
            % 初始化雅可比矩阵和Lyapunov指数计算变量
            J = eye(3);  % 初始雅可比矩阵为单位矩阵
            total_lyap = zeros(3, 1);
            
            % 计算Lyapunov指数
            for k = 1:iterations
                % 计算当前点的雅可比矩阵
                % 对于 x(n+1) = cos(a*z(n) + 2*pi*(c*x(n)*(1-x(n)^2)))
                df1_dx = -sin(a*z + 2*pi*(c*x*(1-x^2))) * 2*pi*c*(1 - 3*x^2);
                df1_dy = 0;
                df1_dz = -sin(a*z + 2*pi*(c*x*(1-x^2))) * a;
                
                % 对于 y(n+1) = sin(b*x(n+1) - 2*pi*(b - y(n)^2))
                % 注意：这里需要用到链式法则，因为x(n+1)是x(n)和z(n)的函数
                df2_dx1 = cos(b*x_new - 2*pi*(b - y^2)) * b * df1_dx;
                df2_dy = cos(b*x_new - 2*pi*(b - y^2)) * (4*pi*y);
                df2_dz = cos(b*x_new - 2*pi*(b - y^2)) * b * df1_dz;
                
                % 对于 z(n+1) = cos(c*y(n+1) + 2*pi*(sin(a/z(n))))
                df3_dx = -sin(c*y_new + 2*pi*(sin(a/z))) * c * df2_dx1;
                df3_dy = -sin(c*y_new + 2*pi*(sin(a/z))) * c * df2_dy;
                
                % 处理可能的除零错误
                if abs(z) < 1e-10
                    df3_dz = -sin(c*y_new + 2*pi*(sin(a/1e-10))) * (-2*pi*cos(a/1e-10)*a/(1e-10^2));
                else
                    df3_dz = -sin(c*y_new + 2*pi*(sin(a/z))) * (-2*pi*cos(a/z)*a/(z^2));
                end
                
                % 构建雅可比矩阵
                J_current = [df1_dx, df1_dy, df1_dz;
                             df2_dx1, df2_dy, df2_dz;
                             df3_dx, df3_dy, df3_dz];
                
                % 更新雅可比矩阵乘积
                J = J_current * J;
                
                % 定期进行QR分解以避免数值不稳定
                if mod(k, 50) == 0
                    [Q, R] = qr(J);
                    J = Q;
                    total_lyap = total_lyap + log(abs(diag(R)));
                end
                
                % 更新系统状态
                x_new = cos(a*z + 2*pi*(c*x*(1-x^2)));
                y_new = sin(b*x_new - 2*pi*(b - y^2));
                
                % 处理可能的除零错误
                if abs(z) < 1e-10
                    z_new = cos(c*y_new + 2*pi*(sin(a/1e-10)));
                else
                    z_new = cos(c*y_new + 2*pi*(sin(a/z)));
                end
                
                x = x_new;
                y = y_new;
                z = z_new;
            end
            
            % 最终QR分解
            [~, R] = qr(J);
            total_lyap = total_lyap + log(abs(diag(R)));
            
            % 计算平均Lyapunov指数（取最大值）
            lyap_exp(i, j) = max(total_lyap / iterations);
        catch
            % 如果计算中出现错误（如数值不稳定），将该点的Lyapunov指数设为NaN
            lyap_exp(i, j) = NaN;
        end
    end
    fprintf('\b\b\b\b\b%5.1f%%', i/size(B, 1)*100);
end
fprintf('\n');

% 绘制热图
figure('Position', [100, 100, 800, 600]);
imagesc(b_values, c_values, lyap_exp);
set(gca, 'YDir', 'normal');  % 确保y轴方向正确
colormap('jet');
colorbar;
clim([-1, 5]);  % 设置颜色范围，可根据实际情况调整

% 设置标签和标题
xlabel('\bf \it b', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('\bf \it c', 'FontSize', 12, 'FontName', 'Times New Roman');
title(sprintf('3D-CQIM (a = %.1f)', a_fixed), ...
      'FontSize', 14, 'FontName', 'Times New Roman');

% 设置坐标轴字体
set(gca, 'FontName', 'Times New Roman');

% 保存图像（可选）
% saveas(gcf, '3d_lyapunov_exponent_heatmap_bc.png');