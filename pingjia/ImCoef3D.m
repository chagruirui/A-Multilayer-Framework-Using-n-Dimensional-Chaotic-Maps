%% 相关系数计算四个方向一张三维图
function r = ImCoef3D(A,N)

A = double(A); [m,n] = size(A); r = zeros(1,4);
x1 = mod(floor(rand(1,N) * 10 ^ 10),m - 1) + 1;
x2 = mod(floor(rand(1,N) * 10 ^ 10),m) + 1;
x3 = mod(floor(rand(1,N) * 10 ^ 10),m - 1) + 2;
y1 = mod(floor(rand(1,N) * 10 ^ 10),n - 1) + 1;
y2 = mod(floor(rand(1,N) * 10 ^ 10),n) + 1;

u1 = zeros(1,N); u2 = zeros(1,N); u3 = zeros(1,N); u4 = zeros(1,N);
v1 = zeros(1,N); v2 = zeros(1,N); v3 = zeros(1,N); v4 = zeros(1,N);

for i = 1:N
    u1(i) = A(x1(i),y2(i)); v1(i) = A(x1(i) + 1,y2(i));
    u2(i) = A(x2(i),y1(i)); v2(i) = A(x2(i),y1(i) + 1);
    u3(i) = A(x1(i),y1(i)); v3(i) = A(x1(i) + 1,y1(i) + 1);
    u4(i) = A(x3(i),y1(i)); v4(i) = A(x3(i) - 1,y1(i) + 1);
end
% r1,r2,r3,r4分别保存水平、垂直、正对角和反对角方向上的相关系数
r(1) = mean((u1 - mean(u1)) .* (v1 - mean(v1))) / (std(u1,1) * std(v1,1));
r(2) = mean((u2 - mean(u2)) .* (v2 - mean(v2))) / (std(u2,1) * std(v2,1));
r(3) = mean((u3 - mean(u3)) .* (v3 - mean(v3))) / (std(u3,1) * std(v3,1));
r(4) = mean((u4 - mean(u4)) .* (v4 - mean(v4))) / (std(u4,1) * std(v4,1));
% 密文相关系数
figure;
plot3(1 * ones(1,N),0,0,'w.','linewidth',3,'markersize',5);
%  hold on ;
%  grid on;
plot3(2 * ones(1,N),u1,v1,'b.','linewidth',3,'markersize',5);
hold on ;
grid on;
plot3(3 * ones(1,N),u2,v2,'g.','linewidth',3,'markersize',5);
hold on ;
grid on;
plot3(4 * ones(1,N),u3,v3,'m.','linewidth',3,'markersize',5);
hold on ;
grid on;
plot3(5 * ones(1,N),u4,v4,'c.','linewidth',3,'markersize',5);
hold on ;
grid on;
plot3(6 * ones(1,N),0,0,'w.','linewidth',3,'markersize',5);
set(gca,'YTick',0:50:250,'ZTick',0:50:250,'fontsize',13,'fontname','times new roman');
xticks([1 2 3 4 5 6 ]);
xticklabels({' ','\bf \itHorizontal','\bf \itVertical','\bf \itDiagonal','\bf \itNegative',' '});
yticks([0 50 100 150 200 250]);
zticks([0 50 100 150 200 250]);
grid off;
% 设置坐标轴的可见性为 'off'，完全隐藏坐标轴
%axis off;
hold off;
end