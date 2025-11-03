%% 分岔图
clear;clc;close all;
n = 300;t = 200;
x = zeros(1,n+t+1);
y = zeros(1,n+t+1);
a=10;%
x(1)=6;
y(1)=6;
%先迭代稳定之后开始绘图
b = 0.05:0.05:10;
xn=zeros(n,length(b));
yn=zeros(n,length(b));

for j=1:length(b)
    for i = 1:n + t

    x(i+1)=cos(a*y(i)+2*pi*(b(j)*x(i)*(1-x(i)^2)));
	y(i+1)=sin(b(j)*x(i+1)-2*pi*(a-y(i)^2));

    end
    xn(:,j)=x(t + 1:n + t);
    yn(:,j)=y(t + 1:n + t);

end
figure(1);plot(b,xn(:,1:length(b)),'b.','Markersize',1);
set(gca,'FontSize',20,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlim([0 10]);
xticks(0:5:10);
ylim([-1 1]);
yticks(-1:1:1);
xlabel('\it{b}','FontName','Times New Roman','FontSize',25);
ylabel('\it{x_i}','FontName','Times New Roman','FontSize',25);
figure(2);plot(b,yn(:,1:length(b)),'b.','Markersize',1);
set(gca,'FontSize',17,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlim([0 10]);
xticks(0:5:10);
ylim([-1 1]);
yticks(-1:1:1);
xlabel('\it{b}','FontName','Times New Roman','FontSize',25);
ylabel('\it{y_i}','FontName','Times New Roman','FontSize',25);
%saveas(figure(1),'k_x.png')
%saveas(figure(2),'k_y.png')
%% 
% clear;clc;close all;
n = 300;t = 200;
x = zeros(1,n+t+1);
y = zeros(1,n+t+1);
b = 10;
x(1) = 0.1; y(1) = 0.1;
%先迭代稳定之后开始绘图
a = 0.05:0.05:10;
xn=zeros(n,length(a));
yn=zeros(n,length(a));

for j=1:length(a)
    for i = 1:n + t

     x(i+1)=cos(a(j)*y(i)+2*pi*(b*x(i)*(1-x(i)^2)));
	y(i+1)=sin(b*x(i+1)-2*pi*(a(j)-y(i)^2));

    end
    xn(:,j)=x(t + 1:n + t);
    yn(:,j)=y(t + 1:n + t);

end
figure(3);plot(a,xn(:,1:length(a)),'b.','Markersize',1);
set(gca,'FontSize',30,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlim([0 10]);
xticks(0:5:10);
ylim([-1 1]);
yticks(-1:1:1);
xlabel('\it{a}','FontName','Times New Roman','FontSize',25);
ylabel('\it{x_i}','FontName','Times New Roman','FontSize',25);
figure(4);plot(a,yn(:,1:length(a)),'b.','Markersize',1);
set(gca,'FontSize',25,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlim([0 10]);
xticks(0:5:10);
ylim([-1 1]);
yticks(-1:1:1);
xlabel('\it{a}','FontName','Times New Roman','FontSize',25);
ylabel('\it{y_i}','FontName','Times New Roman','FontSize',25);

%saveas(figure(3),'rho_x.png')
%saveas(figure(4),'rho_y.png')