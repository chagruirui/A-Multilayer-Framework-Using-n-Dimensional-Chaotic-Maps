%% 主函数调用排列熵函数求时间序列的排列熵值
clc
clear
close all

  b=0.01:0.1:10.01;
 len=length(b);
 %% 
 PE1=zeros(0,len);
 for i=1:1:len
    [x,y,z]=test_31(b(i));%a,b
   PE1(i)=pe(x);
 end
 %plot(x,a,'-*b',x,b,'-or'); %线性，颜色，标记
 plot(b,PE1,'b','LineWidth',1); 

 axis([0,10,0,1])  %确定x轴与y轴框图大小
 set(gca,'XTick',[0:2:10],'FontSize',15,'FontName','Times New Roman'); %x轴范围0-06间隔0.01
 set(gca,'YTick',[0:0.2:1],'FontSize',15,'FontName','Times New Roman'); %y轴范围0-1.2，间隔0.01
 xlabel('\itParameter b','FontName','Times New Roman','FontSize',17)  %x轴坐标描述
 ylabel('\itPE','FontName','Times New Roman','FontSize',17) %y轴坐标描述