close all;
%%colormap('cool')

%[X, Y] = meshgrid(1.05:0.05:10,1.05:0.05:10);
[X, Y] = meshgrid( 0.05:0.05:10, 0.05:0.05:10);
% Z = -4:6;
% LE1 = LE1';LE12 = LE2';
% 使用 mesh 函数创建网格图
mesh(X, Y, LE1)
colormap('cool')
set(gca,'FontSize',15,'FontName','Times New Roman');
%set(gca,'LooseInset',get(gca,'TightInset'));
% 调整 x, y, 和 z 坐标轴的刻度
 xticks([0:5:10]);
 yticks([0:5:10]);
 ylim([0,10]);
 xlim([0,10]);
zticks([-5:5:6])
zlim([-5,6]);
% 为 x, y, 和 z 坐标轴添加标签
% xlabel('\it{\mu}')
% ylabel('\it{a}')
% xlabel('\it{\alpha}')
% ylabel('\it{\beta}')
xlabel('\it{a}','FontName','Times New Roman','FontSize',30);
ylabel('\it{b}','FontName','Times New Roman','FontSize',30);
zlabel('\itLE_1','FontName','Times New Roman','FontSize',30);

% LE2
[X, Y] = meshgrid( 0.05:0.05:10, 0.05:0.05:10);
% Z = -13:6;
% zlim([-6,6])
% zticks([-6,0,6])
% 使用 mesh 函数创建网格图
figure;
mesh(X, Y, LE2)
colormap('cool')
set(gca,'FontSize',15,'FontName','Times New Roman');
% 调整 x, y, 和 z 坐标轴的刻度
 xticks([0:5:10]);
 yticks([0:5:10]);
% zticks([-1,3,6])
 ylim([0,10]);
 xlim([0,10]);

% zticks([-5,0,5])
% zlim([-5,5])
% zticks(-15:5:5)
% zlim([-15,5])
% zticks(0:2:8)
% zlim([0,8])
% 为 x, y, 和 z 坐标轴添加标签
% xlabel('\it{a}')
% ylabel('\it{b}')
% xlabel('\it{\alpha}')
% ylabel('\it{\beta}')
% xlabel('\it{\mu}')
% ylabel('\it{a}')
% xlabel('\it{\mu}')
% ylabel('\it{k}')
% zlabel('{LE_2}')
xlabel('\it{a}','FontName','Times New Roman','FontSize',30);
ylabel('\it{b}','FontName','Times New Roman','FontSize',30);
zlabel('\itLE_2','FontName','Times New Roman','FontSize',30);
