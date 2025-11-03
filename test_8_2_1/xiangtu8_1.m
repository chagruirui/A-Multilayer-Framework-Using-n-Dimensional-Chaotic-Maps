clear 
clc
close all
x=zeros(1);
y=zeros(1);
% x(1)=100;y(1)=100;a=100;b=100;
%x(1)=11;y(1)=22;a=33;b=44;
 x(1)=1;y(1)=2;
 a=3;b=4;

%x(1)=1;y(1)=1;a=1;b=1;
%x(1)=0.1;y(1)=0.2;a=0.3;b=0.4;
%x(1)=0.1;y(1)=0.1;a=0.1;b=0.1;

for n=1:40000     
%%  sine+logistic
 	% x(n+1)=cos(a*y(n)+2*pi*(4/b*(sin(pi*x(n)))));
	% y(n+1)=sin(b*x(n+1)-2*pi*(a*y(n)*(1-y(n))));
    x(n+1)=cos(a*(y(n))+2*pi*(4/b*(sin(pi*x(n)))));
	y(n+1)=sin(b*(x(n+1))-2*pi*(a*y(n)*(1-y(n))));
%%  Chebyshev+ICMIC
%  	x(n+1)=cos(a*y(n)+2*pi*(sin(b/x(n))));
% 	y(n+1)=sin(b*x(n+1)-2*pi*(cos(a*acos(y(n)))));
%% Cubic+Quadrative cos sin
%     x(n+1)=cos(a*y(n)+2*pi*(b*x(n)*(1-x(n)^2)));
% 	y(n+1)=sin(b*x(n+1)-2*pi*(a-y(n)^2));
end

figure;
H=plot(x(1000:end),y(1000:end),'b');%1000
set(H,'linestyle','none','marker','.','markersize',1)
set(gca,'FontSize',15,'FontName','Times New Roman');
% axis([-1,1,-1,1])  %»∑∂®x÷·”Îy÷·øÚÕº¥Û–°
% set(gca,'XTick',[-1:1:1]); %x÷·∑∂Œß0-06º‰∏Ù0.01
% set(gca,'YTick',[-1:1:1]); %y÷·∑∂Œß0-1.2£¨º‰∏Ù0.01
xlabel('\bf \it x_i','FontName','Times New Roman','FontSize',20);
ylabel('\bf \it y_i','FontName','Times New Roman','FontSize',20);

