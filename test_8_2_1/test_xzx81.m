% 二维离散混沌系统显著性图绘制程序
% 功能：通过分析初始条件敏感性，生成并可视化混沌系统的显著性图
% 显著性图反映系统对不同初始条件的敏感程度，颜色越深表示敏感性越高

% 清空工作区变量、命令窗口和关闭所有图形窗口
clear; clc; close all;

%% 1. 定义二维离散混沌系统
% 系统数学表达式：
% x(n+1) = cos(a*y(n) + 2*pi*(4/b*sin(pi*x(n))))
% y(n+1) = sin(b*x(n+1) - 2*pi*(a*y(n)*(1-y(n))))
a = 100;    % 系统参数a
b = 100;    % 系统参数b

% 定义混沌映射迭代函数
% 输入：当前状态(state = [x; y])和系统参数
% 输出：下一时间步的状态
function state = chaotic_map(state, a, b)
    x = state(1);  % 当前x状态
    y = state(2);  % 当前y状态
    
    % 计算下一时间步的状态
    x_next = cos(a*y + 2*pi*(4/b*sin(pi*x)));
    y_next = sin(b*x_next - 2*pi*(a*y*(1-y)));
    
    state = [x_next; y_next];  % 返回新状态
end

%% 2. 仿真参数设置
N = 100;               % 迭代总步数
grid_size = 50;        % 网格尺寸
epsilon = 1e-6;        % 初始条件的微小扰动幅度
x_range = linspace(-1, 1, grid_size);  % x方向初始值范围
y_range = linspace(-1, 1, grid_size);  % y方向初始值范围

% 创建初始条件网格
[X0, Y0] = meshgrid(x_range, y_range);
saliency = zeros(size(X0));  % 初始化显著性图矩阵

%% 3. 计算初始条件敏感性
% 遍历所有初始条件网格点
for i = 1:grid_size
    for j = 1:grid_size
        % 获取当前网格点的初始条件
        state0 = [X0(i,j); Y0(i,j)];
        
        % 对初始条件施加微小扰动
        state0_perturbed = state0 + epsilon * randn(2,1);
        
        % 初始化状态变量
        state = state0;               % 原始状态
        state_perturbed = state0_perturbed;  % 扰动后状态
        
        % 迭代混沌系统
        for k = 1:N
            state = chaotic_map(state, a, b);
            state_perturbed = chaotic_map(state_perturbed, a, b);
        end
        
        % 计算最终状态差异（欧氏距离）
        final_diff = norm(state - state_perturbed);
        % 归一化敏感性
        saliency(i,j) = final_diff / epsilon;
    end
    % 显示计算进度
    fprintf('计算进度: %.1f%%\n', (i/grid_size)*100);
end

%% 4. 绘制显著性图
figure('Position', [100 100 800 600]);
% 绘制填充轮廓图
contourf(X0, Y0, saliency, 30, 'LineColor', 'none');
colormap('parula');
cbar = colorbar;

% 设置标题和坐标轴标签的字体为Times New Roman
title('2D-SLM Saliency map', 'FontSize', 14, 'FontName', 'Times New Roman');
xlabel('x_0', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('y_0', 'FontSize', 12, 'FontName', 'Times New Roman');

% 设置坐标轴刻度字体为Times New Roman
set(gca, 'FontName', 'Times New Roman');

% 设置颜色条字体为Times New Roman
set(cbar, 'FontName', 'Times New Roman');

axis equal tight;
box on;

%% 5. 典型轨迹对比
figure('Position', [900 100 800 600]);

% 寻找高显著性区域的初始点
high_saliency_idx = find(saliency == max(saliency(:)), 1);
[i_high, j_high] = ind2sub(size(saliency), high_saliency_idx);
x0_high = X0(i_high, j_high);
y0_high = Y0(i_high, j_high);

% 寻找低显著性区域的初始点
low_saliency_idx = find(saliency == min(saliency(:)), 1);
[i_low, j_low] = ind2sub(size(saliency), low_saliency_idx);
x0_low = X0(i_low, j_low);
y0_low = Y0(i_low, j_low);

% 初始化轨迹存储矩阵
traj_high = zeros(2, N);
traj_high_perturbed = zeros(2, N);
traj_low = zeros(2, N);
traj_low_perturbed = zeros(2, N);

% 计算轨迹
for k = 1:N
    % 高显著性区域迭代
    state_high = chaotic_map([x0_high; y0_high], a, b);
    state_high_perturbed = chaotic_map([x0_high; y0_high] + epsilon*[1;1], a, b);
    traj_high(:,k) = state_high;
    traj_high_perturbed(:,k) = state_high_perturbed;
    
    % 低显著性区域迭代
    state_low = chaotic_map([x0_low; y0_low], a, b);
    state_low_perturbed = chaotic_map([x0_low; y0_low] + epsilon*[1;1], a, b);
    traj_low(:,k) = state_low;
    traj_low_perturbed(:,k) = state_low_perturbed;
    
    % 更新初始值用于下一次迭代
    x0_high = state_high(1);
    y0_high = state_high(2);
    x0_low = state_low(1);
    y0_low = state_low(2);
end

% 绘制高显著性区域轨迹对比
subplot(2,1,1);
plot(traj_high(1,:), traj_high(2,:), 'b', ...
     traj_high_perturbed(1,:), traj_high_perturbed(2,:), 'r--');
title('高显著性区域：初始扰动导致轨迹显著分离', 'FontSize', 12);
xlabel('x(n)'); ylabel('y(n)'); 
legend('原始轨迹', '扰动轨迹', 'Location', 'best');
axis equal;

% 绘制低显著性区域轨迹对比
subplot(2,1,2);
plot(traj_low(1,:), traj_low(2,:), 'b', ...
     traj_low_perturbed(1,:), traj_low_perturbed(2,:), 'r--');
title('低显著性区域：初始扰动对轨迹影响较小', 'FontSize', 12);
xlabel('x(n)'); ylabel('y(n)'); 
legend('原始轨迹', '扰动轨迹', 'Location', 'best');
axis equal;