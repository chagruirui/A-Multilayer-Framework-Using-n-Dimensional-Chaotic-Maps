%% Lyapunov指数图——雅可比行列式
clear; clc; close all;
%原理是李指数为特征值(反映矩阵收缩性的数)取
ly1=[]; ly2=[]; ly3=[]; C=[];
x(1)=6; 
y(1)=6;
z(1) = 6;
Q=eye(3,3);
c=999;
b=999;

for a = 0.01:0.01:10
    N=1000; % NUMBER OF ITERATIONS
    sum=0;
    for i=2:N
    % x(i)=cos(a*z(i-1)+2*pi*(c*x(i-1)*(1-x(i-1)^2)));
    % y(i)=sin(b*x(i)-2*pi*(b-y(i-1)^2));
    % z(i)=cos(c*y(i)+2*pi*(sin(a/z(i-1))));
    x(i)=cos(a*z(i-1)+2*pi*(c*x(i-1)*(1-x(i-1)^2)));
    y(i)=sin(b*x(i)-2*pi*(b-y(i-1)^2));
    z(i)=cos(c*y(i)+2*pi*(sin(a/z(i-1))));
%% JACOBIAN OF THE HENON MAP
j1=sin(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1))*(4*c*pi*x(i)^2 + 2*c*pi*(x(i)^2 - 1));
j2=0;
j3=-a*sin(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1));
j4=b*cos(b*cos(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1)) - 2*pi*(- y(i)^2 + b))*sin(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1))*(4*c*pi*x(i)^2 + 2*c*pi*(x(i)^2 - 1));
j5= 4*pi*y(i)*cos(b*cos(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1)) - 2*pi*(- y(i)^2 + b));
j6= -a*b*cos(b*cos(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1)) - 2*pi*(- y(i)^2 + b))*sin(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1));
j7=-b*c*cos(b*cos(a*z(i)- 2*c*pi*x(i)*(x(i)^2 - 1)) - 2*pi*(- y(i)^2 + b))*sin(2*pi*sin(a/z(i)) + c*sin(b*cos(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1)) - 2*pi*(- y(i)^2 + b)))*sin(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1))*(4*c*pi*x(i)^2 + 2*c*pi*(x(i)^2 - 1));
j8=-4*c*pi*y(i)*cos(b*cos(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1)) - 2*pi*(- y(i)^2 + b))*sin(2*pi*sin(a/z(i)) + c*sin(b*cos(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1)) - 2*pi*(- y(i)^2 + b)));
j9=sin(2*pi*sin(a/z(i)) + c*sin(b*cos(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1)) - 2*pi*(- y(i)^2 + b)))*((2*a*pi*cos(a/z(i)))/z(i)^2 + a*b*c*cos(b*cos(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1)) - 2*pi*(- y(i)^2 + b))*sin(a*z(i) - 2*c*pi*x(i)*(x(i)^2 - 1)));
     

       J = [j1 j2 j3;
             j4 j5 j6;
             j7 j8 j9];
         
         [Q,R]=qr(J*Q);  %qr分解是用来求矩阵特征值的一种算法，这里F的特征值是R的对角元素的值，Q为正交阵
        %这里F的收缩性用了对应特征值矩阵r的对角元来描述
        sum = sum + log(abs(diag(R)));  %这里diag(R)是个n行一列的矩阵，所有操作都是对n行元素分别进行，所以有下边的Lyapunov(1),Lyapunov(2)等
        %该公式为求李指数公式，见P72
        Lyapunov=sum/N; 
    end
    if N==1000
        ly1=[ly1;Lyapunov(1)];
        ly2=[ly2;Lyapunov(2)];
        ly3=[ly3;Lyapunov(3)];
        C=[C;a];
        %fprintf(1,'l1=%f\n',ly1);
    end
end

plot(C,ly1,'LineWidth',1.4);
hold on;
plot(C,ly2,'LineWidth',1.4);
hold on;
plot(C,ly3,'LineWidth',1.4);
hold on;
% plot(C,0*ones(1,length(C)))
% hold on;
 % axis([0,10,-2,6])  %确定x轴与y轴框图大小
 % line([0,10],[0,0],'linestyle','--');
 % set(gca,'XTick',[0:5:10]); %x轴范围0-06间隔0.01
 % set(gca,'YTick',[-2:2:6]); %y轴范围0-1.2，间隔0.01
lgd=legend('LE_1','LE_2','LE_3','0','Location','SouthEast'); 
set(lgd,'FontName','Times New Roman','FontSize',20);
set(gca,'LooseInset',get(gca,'TightInset'));
set(gca,'FontSize',20,'FontName','Times New Roman');
ylabel('\itLEs','FontName','Times New Roman','FontSize',30);
xlabel('\ita','FontName','Times New Roman','FontSize',30);


% y1=line([0,2],[0,0]);
% set(y1,'linestyle','--');