clear;
clc;
close all;
n = 300;t = 200;
x = zeros(1,n+t+1);
y = zeros(1,n+t+1);
z = zeros(1,n+t+1);

%a=10;%10
c=10;
x(1)=6;
y(1)=6;
z(1)=6;
%先迭代稳定之后开始绘图
    a= 0.05:0.05:10;
    b = 0.05:0.05:10;
    xn=zeros(n,length(b));
    yn=zeros(n,length(b));
    zn=zeros(n,length(b));
    
for k=1:length(a)
  for j=1:length(b)
    for i = 1:n + t

    x(i+1)=cos(a(k)*z(i)+2*pi*(c*x(i)*(1-x(i)^2)));
    y(i+1)=sin(b(j)*x(i+1)-2*pi*(b(j)-y(i)^2));
    z(i+1)=cos(c*y(i+1)+2*pi*(sin(a(k)/z(i))));
    end
    xn(:,j)=x(t + 1:n + t);
    yn(:,j)=y(t + 1:n + t);
    zn(:,j)=y(t + 1:n + t);
  end
%   figure(1);
% plot(b,xn(:,1:length(b)),'b.','markersize',1) 
% set(gca,'FontSize',20,'FontName','Times New Roman');
% set(gca,'LooseInset',get(gca,'TightInset'));
% xlabel('\it{a}','FontName','Times New Roman','FontSize',25); 
% ylabel('\it{x_i}','FontName','Times New Roman','FontSize',25)
end

figure(2);
plot3(a,b,xn(:,1:length(b)),'b.','markersize',1) 
set(gca,'FontSize',20,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
xlabel('\it{a}','FontName','Times New Roman','FontSize',25); 
ylabel('\it{b}','FontName','Times New Roman','FontSize',25);
zlabel('\it{x_i}','FontName','Times New Roman','FontSize',25);
xlim([0 10]);
xlim([0 10]);
xticks(0:5:10);
ylim([0 10]);
ylim([0 10]);
yticks(0:5:10);
zlim([-1 1]);
zticks(-1:1:1);



