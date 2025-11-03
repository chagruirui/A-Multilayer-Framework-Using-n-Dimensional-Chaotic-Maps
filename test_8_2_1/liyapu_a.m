%% a为变量
clear all;clc;close all;
%原理是李指数为特征值(反映矩阵收缩性的数)
ly1=[];ly2=[];C=[];
x(1)=6;
y(1)=6;
w=eye(2,2);
for a=0.05:0.05:10   %r
b=0.01;%
N=1000; % NUMBER OF ITERATIONS
sl1=0; sl2=0; 
for n=1:N

 	x(n+1)=cos(a*y(n)+2*pi*(4/b*(sin(pi*x(n)))));
	y(n+1)=sin(b*x(n+1)-2*pi*(a*y(n)*(1-y(n))));

%%% JACOBIAN OF THE HENON MAP
% xx=-(8*pi^2*sin(a*y(n) + (8*pi*sin(pi*x(n)))/b)*cos(pi*x(n)))/b;
% xy=  -a*sin(a*y(n) + (8*pi*sin(pi*x(n)))/b);
% yx=  b*cos(b*x(n) + 2*pi*a*y(n)*(y(n) - 1));
% yy=cos(b*x(n) + 2*pi*a*y(n)*(y(n) - 1))*(2*pi*a*y(n) + 2*pi*a*(y(n) - 1));
xx=  -(8*pi^2*sin(a*y(n) + (8*pi*sin(pi*x(n)))/b)*cos(pi*x(n)))/b;
xy=  -a*sin(a*y(n) + (8*pi*sin(pi*x(n)))/b);
yx= -8*pi^2*cos(b*cos(a*y(n) + (8*pi*sin(pi*x(n)))/b) + 2*a*pi*y(n)*(y(n) - 1))*sin(a*y(n) + (8*pi*sin(pi*x(n)))/b)*cos(pi*x(n));
yy=cos(b*cos(a*y(n) + (8*pi*sin(pi*x(n)))/b) + 2*a*pi*y(n)*(y(n) - 1))*(2*a*pi*(y(n) - 1) - a*b*sin(a*y(n) + (8*pi*sin(pi*x(n)))/b) + 2*a*pi*y(n));
% jac1 =
%  
% [                                                    -(8*pi^2*sin(a*y + (8*pi*sin(pi*x))/b)*cos(pi*x))/b,                                                                                        -a*sin(a*y + (8*pi*sin(pi*x))/b)]
% [-8*pi^2*cos(b*cos(a*y + (8*pi*sin(pi*x))/b) + 2*a*pi*y*(y - 1))*sin(a*y + (8*pi*sin(pi*x))/b)*cos(pi*x), cos(b*cos(a*y + (8*pi*sin(pi*x))/b) + 2*a*pi*y*(y - 1))*(2*a*pi*(y - 1) - a*b*sin(a*y + (8*pi*sin(pi*x))/b) + 2*a*pi*y)]
% 

jac=[xx, xy; yx, yy];
F=jac*w;
[w,q]=qr(F);  %qr分解是用来求矩阵特征值的一种算法，这里F的特征值是q的对角元素的值，w为正交阵
              %这里F的收缩性用了对应特征值矩阵q的对角元来描述
sl1 = sl1 + log(abs(diag(q)));  %这里diag(q)是个n行一列的矩阵，所有操作都是对n行元素分别进行，素以有下边的l1(1),l1(2)等
                                %该公式为求李指数公式，见P72
l1=sl1/N; 
end
if N==1000
ly1=[ly1;l1(1)];
ly2=[ly2;l1(2)];
C=[C;a];
%fprintf(1,'l1=%f\n',ly1);
end
end
%%去白边
% c=[];
% a=0.01:0.005:1;
% C=[c,a];
% f=figure;
% fa=gca;
 
plot(C,ly1,'-','LineWidth',1.4);
hold on;
plot(C,ly2,'-r','LineWidth',1.4);
lgd=legend('\lambda 1','\lambda 2','Location','SouthEast'); 
set(lgd,'FontName','Times New Roman','FontSize',10);
%set(gca,'LooseInset',get(gca,'TightInset'));

 axis([0,10,-2,12])  %确定x轴与y轴框图大小
 line([0,10],[0,0],'linestyle','--');
 set(gca,'XTick',[0:2:10]); %x轴范围0-06间隔0.01
 set(gca,'YTick',[-2:2:12]); %y轴范围0-1.2，间隔0.01
ylabel('\bf \itLEs','FontName','Times New Roman','FontSize',17);
xlabel('\bf \it a','FontName','Times New Roman','FontSize',17);
% y1=line([0.1,4],[0,0]);
% set(y1,'linestyle','--');
set(gca,'FontSize',17,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'));
%deletewhite(f,fa);

