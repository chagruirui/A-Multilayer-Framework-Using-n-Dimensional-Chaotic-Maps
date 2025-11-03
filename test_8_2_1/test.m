% 二维离散混沌系统显著性图绘制程序
% 功能：通过分析初始条件敏感性，生成并可视化混沌系统的显著性图
% 显著性图反映系统对不同初始条件的敏感程度，颜色越深表示敏感性越高
% 以二维Logistic映射为例，可替换为其他二维离散混沌系统

% 清空工作区变量、命令窗口和关闭所有图形窗口
clear; clc; close all;

%% 1. 定义二维离散混沌系统（扩展Logistic映射）
% 系统数学表达式：
% x(n+1) = r1*x(n)*(1 - x(n)) + a*x(n)*y(n)
% y(n+1) = r2*y(n)*(1 - y(n)) + b*x(n)*y(n)
% 其中：r1, r2为系统参数，a, b为耦合系数
r1 = 3.9;    % 控制x方向混沌行为的参数（接近4时表现强混沌特性）
r2 = 3.8;    % 控制y方向混沌行为的参数
a = 0.1;     % x与y之间的耦合系数（影响系统相互作用强度）
b = 0.1;     % y与x之间的耦合系数

% 定义混沌映射迭代函数
% 输入：当前状态(state = [x; y])和系统参数
% 输出：下一时间步的状态
function state = chaotic_map(state, r1, r2, a, b)
    x = state(1);  % 当前x状态
    y = state(2);  % 当前y状态
    
    % 计算下一时间步的状态
    x_next = r1 * x * (1 - x) + a * x * y;  % x方向迭代公式
    y_next = r2 * y * (1 - y) + b * x * y;  % y方向迭代公式
    
    % 边界处理：确保状态变量在[0,1]范围内（避免数值溢出）
    x_next = max(0, min(1, x_next));
    y_next = max(0, min(1, y_next));
    
    state = [x_next; y_next];  % 返回新状态
end

%% 2. 仿真参数设置
N = 100;               % 迭代总步数（足够大以观察混沌系统的长期行为）
grid_size = 50;        % 网格尺寸（决定显著性图的分辨率，值越大越精细）
epsilon = 1e-6;        % 初始条件的微小扰动幅度（接近机器精度的小值）
x_range = 0.05:0.01:0.95;  % x方向初始值范围（避开边界以避免奇异点）
y_range = 0.05:0.01:0.95;  % y方向初始值范围

% 创建初始条件网格（覆盖整个初始状态空间）
[X0, Y0] = meshgrid(x_range, y_range);
saliency = zeros(size(X0));  % 初始化显著性图矩阵（存储每个网格点的敏感性值）

%% 3. 计算初始条件敏感性（核心计算部分）
% 遍历所有初始条件网格点
for i = 1:grid_size
    for j = 1:grid_size
        % 获取当前网格点的初始条件
        state0 = [X0(i,j); Y0(i,j)];
        
        % 对初始条件施加微小扰动（添加高斯噪声）
        state0_perturbed = state0 + epsilon * randn(2,1);
        % 确保扰动后的初始条件仍在有效范围内
        state0_perturbed = max(0, min(1, state0_perturbed));
        
        % 初始化状态变量
        state = state0;               % 原始状态
        state_perturbed = state0_perturbed;  % 扰动后状态
        
        % 迭代混沌系统
        for k = 1:N
            state = chaotic_map(state, r1, r2, a, b);
            state_perturbed = chaotic_map(state_perturbed, r1, r2, a, b);
        end
        
        % 计算最终状态差异（欧氏距离）
        final_diff = norm(state - state_perturbed);
        % 归一化敏感性：差异除以扰动幅度，得到单位扰动引起的状态变化
        saliency(i,j) = final_diff / epsilon;
    end
    % 显示计算进度（方便监控长耗时计算）
    fprintf('计算进度: %.1f%%\n', (i/grid_size)*100);
end

%% 4. 绘制显著性图（可视化结果）
figure('Position', [100 100 800 600]);  % 创建图形窗口并设置位置大小
% 绘制填充轮廓图（热力图形式展示显著性分布）
contourf(X0, Y0, saliency, 30, 'LineColor', 'none');  % 30表示颜色分级数
colormap('parula');  % 使用parula颜色映射（适合科学可视化）
colorbar;  % 添加颜色条（指示显著性值大小）
title('二维离散混沌系统初始条件敏感性显著性图', 'FontSize', 14);
xlabel('初始值 x_0', 'FontSize', 12);
ylabel('初始值 y_0', 'FontSize', 12);
axis equal tight;  % 等比例显示并紧凑布局
box on;  % 显示坐标轴边框

%% 5. 典型轨迹对比（验证显著性图的合理性）
figure('Position', [900 100 800 600]);  % 创建第二个图形窗口

% 寻找高显著性区域的初始点
high_saliency_idx = find(saliency == max(saliency(:)), 1);  % 找到最大值索引
[i_high, j_high] = ind2sub(size(saliency), high_saliency_idx);  % 转换为行列索引
x0_high = X0(i_high, j_high);  % 高显著性点x初始值
y0_high = Y0(i_high, j_high);  % 高显著性点y初始值

% 寻找低显著性区域的初始点
low_saliency_idx = find(saliency == min(saliency(:)), 1);  % 找到最小值索引
[i_low, j_low] = ind2sub(size(saliency), low_saliency_idx);  % 转换为行列索引
x0_low = X0(i_low, j_low);  % 低显著性点x初始值
y0_low = Y0(i_low, j_low);  % 低显著性点y初始值

% 初始化轨迹存储矩阵（2行N列，分别存储x和y的轨迹）
traj_high = zeros(2, N);          % 高显著性区域原始轨迹
traj_high_perturbed = zeros(2, N); % 高显著性区域扰动轨迹
traj_low = zeros(2, N);           % 低显著性区域原始轨迹
traj_low_perturbed = zeros(2, N);  % 低显著性区域扰动轨迹

% 计算轨迹
for k = 1:N
    % 高显著性区域迭代
    state_high = chaotic_map([x0_high; y0_high], r1, r2, a, b);
    state_high_perturbed = chaotic_map([x0_high; y0_high] + epsilon*[1;1], r1, r2, a, b);
    traj_high(:,k) = state_high;
    traj_high_perturbed(:,k) = state_high_perturbed;
    
    % 低显著性区域迭代
    state_low = chaotic_map([x0_low; y0_low], r1, r2, a, b);
    state_low_perturbed = chaotic_map([x0_low; y0_low] + epsilon*[1;1], r1, r2, a, b);
    traj_low(:,k) = state_low;
    traj_low_perturbed(:,k) = state_low_perturbed;
    
    % 更新初始值用于下一次迭代
    x0_high = state_high(1);
    y0_high = state_high(2);
    x0_low = state_low(1);
    y0_low = state_low(2);
end

% 绘制高显著性区域轨迹对比
subplot(2,1,1);  % 第一个子图
plot(traj_high(1,:), traj_high(2,:), 'b', ...  % 原始轨迹（蓝色实线）
     traj_high_perturbed(1,:), traj_high_perturbed(2,:), 'r--');  % 扰动轨迹（红色虚线）
title('高显著性区域：初始扰动导致轨迹显著分离', 'FontSize', 12);
xlabel('x(n)'); ylabel('y(n)'); 
legend('原始轨迹', '扰动轨迹', 'Location', 'best');  % 添加图例
axis equal;  % 等比例显示

% 绘制低显著性区域轨迹对比
subplot(2,1,2);  % 第二个子图
plot(traj_low(1,:), traj_low(2,:), 'b', ...  % 原始轨迹（蓝色实线）
     traj_low_perturbed(1,:), traj_low_perturbed(2,:), 'r--');  % 扰动轨迹（红色虚线）
title('低显著性区域：初始扰动对轨迹影响较小', 'FontSize', 12);
xlabel('x(n)'); ylabel('y(n)'); 
legend('原始轨迹', '扰动轨迹', 'Location', 'best');
axis equal;


