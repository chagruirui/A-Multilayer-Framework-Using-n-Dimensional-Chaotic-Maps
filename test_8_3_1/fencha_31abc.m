%% 分岔图
%% 
clear;clc;close all;
n = 300;t = 200;
x = zeros(1,n+t+1);
y = zeros(1,n+t+1);
b=10;%
c=10;
x(1)=0.1;
y(1)=0.1;
z(1)=0.1;
%先迭代稳定之后开始绘图
a = 0.05:0.05:10;
xn=zeros(n,length(a));
yn=zeros(n,length(a));
zn=zeros(n,length(a));

for j=1:length(a)
    for i = 1:n + t

    x(i+1)=cos(a(j)*z(i)+2*pi*(c*x(i)*(1-x(i)^2)));
    y(i+1)=sin(b*x(i+1)-2*pi*(b-y(i)^2));
    z(i+1)=cos(c*y(i+1)+2*pi*(sin(a(j)/z(i))));

    end
    xn(:,j)=x(t + 1:n + t);
    yn(:,j)=y(t + 1:n + t);
    zn(:,j)=z(t + 1:n + t);
end
figure(1);plot(a,xn(:,1:length(a)),'.','Markersize',1,'color',[0.72157 0.52549 00.4314]);
set(gca,'FontSize',20,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlim([0 10]);
xticks(0:5:10);
ylim([-1 1]);
yticks(-1:1:1);
xlabel('\it{a}','FontName','Times New Roman','FontSize',25);
ylabel('\it{x_i}','FontName','Times New Roman','FontSize',25);

figure(2);plot(a,yn(:,1:length(a)),'.','Markersize',1,'color',[0.72157 0.52549 00.4314]);
set(gca,'FontSize',17,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlim([0 10]);
xticks(0:5:10);
ylim([-1 1]);
yticks(-1:1:1);
xlabel('\it{a}','FontName','Times New Roman','FontSize',25);
ylabel('\it{y_i}','FontName','Times New Roman','FontSize',25);

figure(3);plot(a,zn(:,1:length(a)),'m.','Markersize',1,'color',[0.72157 0.52549 00.4314]);
set(gca,'FontSize',17,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlim([0 10]);
xticks(0:5:10);
ylim([-1 1]);
yticks(-1:1:1);
xlabel('\it{a}','FontName','Times New Roman','FontSize',25);
ylabel('\it{z_i}','FontName','Times New Roman','FontSize',25);

saveas(figure(1),'a_x.png')
saveas(figure(2),'a_y.png')
saveas(figure(3),'a_z.png')
%% 

n = 300;t = 200;
x = zeros(1,n+t+1);
y = zeros(1,n+t+1);
a=10;%
c=10;
x(1)=0.1;
y(1)=0.1;
z(1)=0.1;
%先迭代稳定之后开始绘图
b = 0.05:0.05:10;
xn=zeros(n,length(b));
yn=zeros(n,length(b));
zn=zeros(n,length(b));

for j=1:length(b)
    for i = 1:n + t

    x(i+1)=cos(a*z(i)+2*pi*(c*x(i)*(1-x(i)^2)));
    y(i+1)=sin(b(j)*x(i+1)-2*pi*(b(j)-y(i)^2));
    z(i+1)=cos(c*y(i+1)+2*pi*(sin(a/z(i))));

    end
    xn(:,j)=x(t + 1:n + t);
    yn(:,j)=y(t + 1:n + t);
    zn(:,j)=z(t + 1:n + t);
end
figure(4);plot(b,xn(:,1:length(b)),'.','Markersize',1,'color',[0.27451 0.5098 0.70588]);
set(gca,'FontSize',20,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlim([0 10]);
xticks(0:5:10);
ylim([-1 1]);
yticks(-1:1:1);
xlabel('\it{b}','FontName','Times New Roman','FontSize',25);
ylabel('\it{x_i}','FontName','Times New Roman','FontSize',25);

figure(5);plot(b,yn(:,1:length(b)),'.','Markersize',1,'color',[0.27451 0.5098 0.70588]);
set(gca,'FontSize',17,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlim([0 10]);
xticks(0:5:10);
ylim([-1 1]);
yticks(-1:1:1);
xlabel('\it{b}','FontName','Times New Roman','FontSize',25);
ylabel('\it{y_i}','FontName','Times New Roman','FontSize',25);

figure(6);plot(b,zn(:,1:length(b)),'.','Markersize',1,'color',[0.27451 0.5098 0.70588]);
set(gca,'FontSize',17,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlim([0 10]);
xticks(0:5:10);
ylim([-1 1]);
yticks(-1:1:1);
xlabel('\it{b}','FontName','Times New Roman','FontSize',25);
ylabel('\it{z_i}','FontName','Times New Roman','FontSize',25);

saveas(figure(4),'b_x.png')
saveas(figure(5),'b_y.png')
saveas(figure(6),'b_z.png')

%% 

n = 300;t = 200;
x = zeros(1,n+t+1);
y = zeros(1,n+t+1);
a=10;%
b=10;
x(1)=0.1;
y(1)=0.1;
z(1)=0.1;
%先迭代稳定之后开始绘图
c = 0.05:0.05:10;
xn=zeros(n,length(c));
yn=zeros(n,length(c));
zn=zeros(n,length(c));

for j=1:length(c)
    for i = 1:n + t

    x(i+1)=cos(a*z(i)+2*pi*(c(j)*x(i)*(1-x(i)^2)));
    y(i+1)=sin(b*x(i+1)-2*pi*(b-y(i)^2));
    z(i+1)=cos(c(j)*y(i+1)+2*pi*(sin(a/z(i))));

    end
    xn(:,j)=x(t + 1:n + t);
    yn(:,j)=y(t + 1:n + t);
    zn(:,j)=z(t + 1:n + t);
end
figure(7);plot(c,xn(:,1:length(c)),'.','Markersize',1,'color',[0.41569 0.35294 0.80392]);
set(gca,'FontSize',20,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlim([0 10]);
xticks(0:5:10);
ylim([-1 1]);
yticks(-1:1:1);
xlabel('\it{c}','FontName','Times New Roman','FontSize',25);
ylabel('\it{x_i}','FontName','Times New Roman','FontSize',25);

figure(8);plot(c,yn(:,1:length(c)),'.','Markersize',1,'color',[0.41569 0.35294 0.80392]);
set(gca,'FontSize',17,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlim([0 10]);
xticks(0:5:10);
ylim([-1 1]);
yticks(-1:1:1);
xlabel('\it{c}','FontName','Times New Roman','FontSize',25);
ylabel('\it{y_i}','FontName','Times New Roman','FontSize',25);

figure(9);plot(c,zn(:,1:length(c)),'.','Markersize',1,'color',[0.41569 0.35294 0.80392]);
set(gca,'FontSize',17,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlim([0 10]);
xticks(0:5:10);
ylim([-1 1]);
yticks(-1:1:1);
xlabel('\it{c}','FontName','Times New Roman','FontSize',25);
ylabel('\it{z_i}','FontName','Times New Roman','FontSize',25);

saveas(figure(7),'c_x.png')
saveas(figure(8),'c_y.png')
saveas(figure(9),'c_z.png')