clear
clc
close all

% 参数设置
a = 100; % 将a设置为6
b_values = 1:1:100; % b的取值范围
num_b = length(b_values);

% 初始化存储变量
num_steps = 40000;
x = zeros(num_steps + 1, num_b);
y = zeros(num_steps + 1, num_b);

% 预分配内存
for k = 1:num_b
    x(1, k) = 1;
    y(1, k) = 1;
end

% 迭代计算
for k = 1:num_b
    b = b_values(k);
    for n = 1:num_steps
            x(n+1, k)=cos(a*(y(n, k))+2*pi*(4/b*(sin(pi*x(n, k)))));
	        y(n+1, k)=sin(b*(x(n+1, k))-2*pi*(a*y(n, k)*(1-y(n, k))));
    end
end

% 绘制三维相图
figure;
hold on;
for k = 1:num_b
    plot3(x(1000:end, k), b_values(k) * ones(length(x(1000:end, k)), 1), y(1000:end, k), ...
        'linestyle', 'none', 'marker', '.', 'markersize', 1);
end
hold off;

% 设置图形属性
xlabel('\bf \it x_i', 'FontName', 'Times New Roman', 'FontSize', 20);
ylabel('\bf \it b', 'FontName', 'Times New Roman', 'FontSize', 20);
zlabel('\bf \it y_i', 'FontName', 'Times New Roman', 'FontSize', 20);
%title('3D Phase Diagram of Coupled System', 'FontName', 'Times New Roman', 'FontSize', 20);
set(gca, 'FontSize', 15, 'FontName', 'Times New Roman');
grid on;

% 设置视角
view(3); % 使用默认的三维视角
axis tight; % 自动调整坐标轴范围以适应数据