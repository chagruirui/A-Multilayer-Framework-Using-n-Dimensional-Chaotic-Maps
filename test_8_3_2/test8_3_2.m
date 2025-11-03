%% 相空间图
%测试新的混沌系统
clear;
clc;
%% 参数
%a =10;b=10;c=10;
%a =1;b=2;c=3;
%a =11;b=12;c=13; 
a =100;b=100;c=100;

N = 50000;
x = zeros(1,N);
y = zeros(1,N);
z = zeros(1,N);
%% 初值
 x(1) = 1;y(1) =1;z(1) =1;
%x(1) = 0.1;y(1) =0.2;z(1) =0.3;
%x(1) = 11;y(1) =12;z(1) =13;
%x(1) = 0.01;y(1) =0.02;z(1) =0.03;
%% 
for i = 1:N

    %% test3-3 sine+logistic+Chebyshev 
    x(i+1)=cos(a*z(i)+2*pi*(4/c*(sin(pi*x(i)))));
    y(i+1)=sin(b*x(i+1)-2*pi*(b*y(i)*(1-y(i))));
    z(i+1)=cos(c*y(i+1)+2*pi*(a*acos(z(i))));
end
figure;
plot3(x,y,z,'.','markersize',1) 
set(gca,'FontSize',15,'FontName','Times New Roman');
xlabel('\bf \it x','FontName','Times New Roman'); 
ylabel('\bf \it y','FontName','Times New Roman');
zlabel('\bf \it z','FontName','Times New Roman');
hold on
plot3(x(1),y(1),z(1),'r.','markersize',8);

figure;
plot(x,y,'.','markersize',1) 
set(gca,'FontSize',15,'FontName','Times New Roman');
xlabel('\bf \it x','FontName','Times New Roman') 
ylabel('\bf \it y','FontName','Times New Roman')
hold on
plot(x(1),y(1),'r.','markersize',8)
figure;
plot(x,z,'.','markersize',1) 
set(gca,'FontSize',15,'FontName','Times New Roman');
xlabel('\bf \it x','FontName','Times New Roman') 
ylabel('\bf \it z','FontName','Times New Roman')
hold on
plot(x(1),z(1),'r.','markersize',8)
figure;
plot(y,z,'.','markersize',1) 
set(gca,'FontSize',15,'FontName','Times New Roman');

xlabel('\bf \it y','FontName','Times New Roman') 
ylabel('\bf \it z','FontName','Times New Roman')
hold on
plot(y(1),z(1),'r.','markersize',8)
%saveas(figure(1),'xiangtu.png')
% figure;
% plot(x,'.') 
% xlabel('t') 
% ylabel('x')
% figure;
% plot(y,'.') 
% xlabel('t') 
% ylabel('y')
% figure;
% plot(z,'.') 
% xlabel('t') 
% ylabel('z')