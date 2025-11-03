clear;
clc;
close all;

SE=[];
x(1)=6;
y(1)=6;

n=1000;
C = [];
% for b=0.01:0.05:7
for b=0:0.05:10
    for a = 0:0.05:10 
        for i=1:n-1 
    x(i+1)=cos(a*(y(i))+2*pi*(4/b*(sin(pi*x(i)))));
	y(i+1)=sin(b*(x(i+1))-2*pi*(a*y(i)*(1-y(i))));
%           x(i+1)=cos(pi*(4/b*(sin(pi*x(i))))+(a*y(i)*(1-y(i)))+c);
% 	      y(i+1)=cos(pi*(a*x(i+1)*(1-x(i+1)))+(4/b*(sin(pi*y(i))))+d);
        end
        SE = [SE,SampEn(x,2,0.2*std(x))];
        C=[C;b];
    end
end
b = 10;a = 10;
for i=1:n-1 
    x(i+1)=cos(a*(y(i))+2*pi*(4/b*(sin(pi*x(i)))));
	y(i+1)=sin(b*(x(i+1))-2*pi*(a*y(i)*(1-y(i))));
end
SE = [SE,SampEn(x,2,0.2*std(x))];
C=[C;b];
p5=plot(C,SE,'-b','linewidth',1,'MarkerFaceColor','m');

 axis([0,10,0,2.5])  %»∑∂®x÷·”Îy÷·øÚÕº¥Û–°
 set(gca,'XTick',[0:2:10],'FontSize',15,'FontName','Times New Roman'); %x÷·∑∂Œß0-06º‰∏Ù0.01
 set(gca,'YTick',[0:0.5:2.5],'FontSize',15,'FontName','Times New Roman'); %y÷·∑∂Œß0-1.2£¨º‰∏Ù0.01
 xlabel('\bf \it b','FontName','Times New Roman','FontSize',17)  %x÷·◊¯±Í√Ë ˆ
 ylabel('\bf \it SE','FontName','Times New Roman','FontSize',17) %y÷·◊¯±Í√Ë ˆ