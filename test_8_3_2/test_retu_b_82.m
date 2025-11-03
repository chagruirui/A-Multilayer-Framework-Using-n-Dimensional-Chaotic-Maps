% 计算并绘制三维离散混沌系统李雅普诺夫指数热图
clear; clc; close all;

% 设置参数范围
a_min = 0.5;
a_max = 10.0;
c_min = 0.5;
c_max = 10.0;
a_steps = 100;  % a参数的分辨率
c_steps = 100;  % c参数的分辨率
b_fixed = 10;    % 固定参数b的值

% 创建参数网格
a_values = linspace(a_min, a_max, a_steps);
c_values = linspace(c_min, c_max, c_steps);
[A, C] = meshgrid(a_values, c_values);

% 初始化李雅普诺夫指数矩阵
lyap_exp = zeros(size(A));

% 设置迭代参数
transient = 2000;  % 瞬态迭代次数（排除初始 transient）
iterations = 5000; % 用于计算李雅普诺夫指数的迭代次数

% 循环计算每个参数点的李雅普诺夫指数
fprintf('计算进度: 0.0%%');
for i = 1:size(A, 1)
    for j = 1:size(A, 2)
        a = A(i, j);
        c = C(i, j);
        b = b_fixed;
        
        try
            % 初始化系统状态
            x = 0.5;
            y = 0.5;
            z = 0.5;
            
            % 先迭代 transient 次，排除初始 transient
            for k = 1:transient
                % 3D-SLCM 系统方程
                x_new = cos(a*z + 2*pi*(4/c*(sin(pi*x))));
                y_new = sin(b*x_new - 2*pi*(b*y*(1-y)));
                
                % 处理可能的定义域错误 (acos(z) 要求 |z| ≤ 1)
                if abs(z) > 1
                    z_new = cos(c*y_new + 2*pi*(a*acos(sign(z)))); % 使用 sign(z) 避免超出定义域
                else
                    z_new = cos(c*y_new + 2*pi*(a*acos(z)));
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
                % 对于 x(n+1) = cos(a*z(n) + 2*pi*(4/c*sin(pi*x(n))))
                df1_dx = -sin(a*z + 2*pi*(4/c*sin(pi*x))) * 2*pi*(4/c)*pi*cos(pi*x);
                df1_dy = 0;
                df1_dz = -sin(a*z + 2*pi*(4/c*sin(pi*x))) * a;
                
                % 对于 y(n+1) = sin(b*x(n+1) - 2*pi*(b*y(n)*(1-y(n))))
                % 注意：这里需要用到链式法则，因为x(n+1)是x(n)和z(n)的函数
                df2_dx1 = cos(b*x_new - 2*pi*(b*y*(1-y))) * b * df1_dx;
                df2_dy = cos(b*x_new - 2*pi*(b*y*(1-y))) * (-2*pi*b*(1 - 2*y));
                df2_dz = cos(b*x_new - 2*pi*(b*y*(1-y))) * b * df1_dz;
                
                % 对于 z(n+1) = cos(c*y(n+1) + 2*pi*(a*acos(z(n))))
                df3_dx = -sin(c*y_new + 2*pi*(a*acos(z))) * c * df2_dx1;
                df3_dy = -sin(c*y_new + 2*pi*(a*acos(z))) * c * df2_dy;
                
                % 处理可能的定义域错误 (acos(z) 的导数要求 |z| < 1)
                if abs(z) >= 1
                    df3_dz = 0; % 当 |z| >= 1 时，acos(z) 的导数未定义，设为0
                else
                    df3_dz = -sin(c*y_new + 2*pi*(a*acos(z))) * (-2*pi*a/sqrt(1-z^2));
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
                x_new = cos(a*z + 2*pi*(4/c*(sin(pi*x))));
                y_new = sin(b*x_new - 2*pi*(b*y*(1-y)));
                
                % 处理可能的定义域错误 (acos(z) 要求 |z| ≤ 1)
                if abs(z) > 1
                    z_new = cos(c*y_new + 2*pi*(a*acos(sign(z)))); % 使用 sign(z) 避免超出定义域
                else
                    z_new = cos(c*y_new + 2*pi*(a*acos(z)));
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
    fprintf('\b\b\b\b\b%5.1f%%', i/size(A, 1)*100);
end
fprintf('\n');

% 绘制热图
figure('Position', [100, 100, 800, 600]);
imagesc(a_values, c_values, lyap_exp);
set(gca, 'YDir', 'normal');  % 确保y轴方向正确
colormap('jet');
colorbar;
clim([-1, 5]);  % 设置颜色范围，可根据实际情况调整

% 设置标签和标题
xlabel('\bf \it a', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('\bf \it c', 'FontSize', 12, 'FontName', 'Times New Roman');
title(sprintf('3D-SLCM (b = %.1f)', b_fixed), ...
      'FontSize', 14, 'FontName', 'Times New Roman');

% 设置坐标轴字体
set(gca, 'FontName', 'Times New Roman');

% 保存图像（可选）
% saveas(gcf, '3d_lyapunov_exponent_heatmap_ac.png');