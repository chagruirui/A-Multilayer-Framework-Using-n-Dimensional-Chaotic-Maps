clear;clc;close all;
% a = 2:0.005:4;
%定义迭代次数1000
Maxcycle = 1000;
%定义2个1000 * 1的全0矩阵用来存放x,y的值，加快迭代速度
x = zeros(Maxcycle,1);
y = zeros(Maxcycle,1);
%定义一个length(a)*2的全零矩阵用来存放lamudax的值、lamuday的值，加快迭代速度
% lamuda = zeros(length(a),2);
%定义一个2*1的全零矩阵用来存放每次循环两个lamuda的值，加快迭代速度
LE  = zeros(2,1);
LE1 = [];
LE2 = [];
    x(1) = 6;
    y(1) = 6;
    Q = eye(2);
        len=numel(0.05:0.05:10);
for a = 0.05:0.05:10
    %计算J0；
    for b = 0.05:0.05:10
        
J0 = [                                                        (2*b*pi*sin(a*y(1) + 2*pi*sin(b/x(1)))*cos(b/x(1)))/x(1)^2,                                                                                                     -a*sin(a*y(1) + 2*pi*sin(b/x(1)));
       (2*b^2*pi*cos(b*cos(a*y(1) + 2*pi*sin(b/x(1))) - 2*pi*cos(a*acos(y(1))))*sin(a*y(1) + 2*pi*sin(b/x(1)))*cos(b/x(1)))/x(1)^2, -cos(b*cos(a*y(1) + 2*pi*sin(b/x(1))) - 2*pi*cos(a*acos(y(1))))*(a*b*sin(a*y(1) + 2*pi*sin(b/x(1))) + (2*a*pi*sin(a*acos(y(1))))/(1 - y(1)^2)^(1/2))];


        % J0 = [   sin(exp((4*sin(pi*x(1)))/b) + pi*exp(- x(1)^2 + a))*(2*x(1)*pi*exp(- x(1)^2 + a) - (4*pi*exp((4*sin(pi*x(1)))/b)*cos(pi*x(1)))/b),   0;
        %        -(4*pi^2*sin(exp(- y(1)^2 + a) + pi*exp((4*sin(pi*x(1)))/b))*exp((4*sin(pi*x(1)))/b)*cos(pi*x(1)))/b, 2*y(1)*sin(exp(- y(1)^2 + a) + pi*exp((4*sin(pi*x(1)))/b))*exp(- y(1)^2 + a)];
      
        B = J0 * Q;
        [Q,R] = qr(B);
        sum = log(abs(diag(R)));
        for n = 1:Maxcycle-1
            %定义che-icm混沌
 	x(n+1)=cos(a*y(n)+2*pi*(sin(b/x(n))));
	y(n+1)=sin(b*x(n+1)-2*pi*(cos(a*acos(y(n)))));

            %高维混沌系统的Lyapunov指数使用雅可比迭代方式求解
            %找出偏导矩阵
            % [-2 * a .* x 1; b 0]
xx=(2*b*pi*sin(a*y(n) + 2*pi*sin(b/x(n)))*cos(b/x(n)))/x(n)^2;
xy= -a*sin(a*y(n) + 2*pi*sin(b/x(n)));
yx= (2*b^2*pi*cos(b*cos(a*y(n) + 2*pi*sin(b/x(n))) - 2*pi*cos(a*acos(y(n))))*sin(a*y(n) + 2*pi*sin(b/x(n)))*cos(b/x(n)))/x(n)^2;
yy=-cos(b*cos(a*y(n) + 2*pi*sin(b/x(n))) - 2*pi*cos(a*acos(y(n))))*(a*b*sin(a*y(n) + 2*pi*sin(b/x(n))) + (2*a*pi*sin(a*acos(y(n))))/(1 - y(n)^2)^(1/2));

          J = [xx, xy; yx, yy];

            %乘单位矩阵的原因可能是为了加快迭代速度？初始化了一个2*2的矩阵
            B = J * Q;
            %进行qr分解，将B矩阵分解成正交矩阵Q和上三角矩阵R，R矩阵的正对角线的值即为lamuda的值
            [Q,R] = qr(B);
            %高维混沌系统的Lyapunov指数1/n*sum(ln(lumada));
            sum = sum + log(abs(diag(R)));
        end
        LE = sum / Maxcycle;
        LE1 = [LE1,LE(1)];
        LE2 = [LE2,LE(2)];
    end
    
%     lamuda(i,1) = LE(1);
%     lamuda(i,2) = LE(2);
end
LE1=reshape(LE1,len,len);
LE2=reshape(LE2,len,len);
% k = 2:0.005:4;
% 
% plot(k,lamuda(:,1),'g-','LineWidth',1.4);
% hold on ;
% plot(k,lamuda(:,2),'b-','LineWidth',1.4);
% 
% lgd=legend('\itLE 1','\itLE 2','Location','SouthEast'); 
% set(lgd,'FontName','Times New Roman','FontSize',15);
% set(gca,'LooseInset',get(gca,'TightInset'));
% ylabel('Lyapunov exponents','FontName','Times New Roman','FontSize',15);
% xlabel('\it{a}','FontName','Times New Roman','FontSize',15);

% saveas(gcf,'CICM.bmp')

