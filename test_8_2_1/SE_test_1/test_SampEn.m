clear;
SE5=[];x5(1)=0.3156;y5(1)=0.6423;n=1000;
C5 = [];C4 = [];C3 = [];C2 = [];
for k=0.001:0.1:4
    for a = 0.001:0.1:4
%     a=4;
        for i=1:n-1 
%         x5(i+1)=sin( k * pi^2 * acos(x5(i)) + a*cos(pi^2 * y5(i)^2) * (1 - y5(i)));
%         y5(i+1)=sin( k * pi^2 * acos(y5(i)) + a*cos(pi^2 * x5(i+1)^2) * (1 - x5(i+1)));
        x5(i + 1) = mod(cos(k * acos(x5(i)))^2 - sin(a/y5(i))^2,1);
        y5(i + 1) = mod(-2 * cos(k * acos(x5(i))) * sin(a/y5(i)),1);
        end
        SE5 = [SE5,SampEn(x5,2,0.2*std(x5))];
        C5=[C5;k];
    end
end
k = 4;a = 4;
for i=1:n-1 
    x5(i + 1) = mod(cos(k * acos(x5(i)))^2 - sin(a/y5(i))^2,1);
    y5(i + 1) = mod(-2 * cos(k * acos(x5(i))) * sin(a/y5(i)),1);
end
SE5 = [SE5,SampEn(x5,2,0.2*std(x5))];
C5=[C5;k];
clc;
%  cross 2D hyperchaotic map
SE4=[];x4(1)=0.3156;y4(1)=0.6423;n=1000;
for are=0.001:0.03:4
%         for beta = 0.001:0.1:1
beta=4;
            for i=1:n-1 
            x4(i+1)=sin(are/sin(y4(i)));
            y4(i+1)=beta * sin(pi *(x4(i)+y4(i)));
            end
            SE4 = [SE4,SampEn(y4,2,0.2*std(y4))];
            C4=[C4;are];
%         end
end
are=4;
for i=1:n-1 
    x4(i+1)=sin(are/sin(y4(i)));
    y4(i+1)=beta * sin(pi *(x4(i)+y4(i)));
end
SE4 = [SE4,SampEn(y4,2,0.2*std(y4))];
C4=[C4;are];
% A Henon-like chaotic map
SE3=[];x3(1)=0.3156;y3(1)=0.6423;n=1000;

for a=0.001:0.03:4
        b=4;c=4;
        for i=1:n-1 
            x3(i+1)=c+y3(i)-a * (sin(x3(i)))^2;
            y3(i+1)=b * sin(x3(i));
        end
        SE3 = [SE3,SampEn(x3,2,0.2*std(x3))];
        C3 = [C3;a];
%         end
end
a =4;
for i=1:n-1 
    x3(i+1)=c+y3(i)-a * (sin(x3(i)))^2;
    y3(i+1)=b * sin(x3(i));
end
SE3 = [SE3,SampEn(x3,2,0.2*std(x3))];
C3 = [C3;a];
% improved 2D-LASM
SE2=[];x2(1)=0.3156;y2(1)=0.6423;n=1000;
for mu=0.001:0.03:4
rho=4;
    for i=1:n-1 
        x2(i+1)=sin(pi * mu * (y2(i) + rho - x2(i)) * x2(i) * (1 - x2(i)));
        y2(i+1)=sin(pi * mu * (x2(i+1) + rho - y2(i)) * y2(i) * (1 - y2(i)));
    end
    SE2 = [SE2,SampEn(x2,2,0.2*std(x2))];
    C2 = [C2;mu];
%         end
end
mu = 4;
for i=1:n-1 
    x2(i+1)=sin(pi * mu * (y2(i) + rho - x2(i)) * x2(i) * (1 - x2(i)));
    y2(i+1)=sin(pi * mu * (x2(i+1) + rho - y2(i)) * y2(i) * (1 - y2(i)));
end
SE2 = [SE2,SampEn(x2,2,0.2*std(x2))];
C2 = [C2;mu];

% p2=plot(C2,SE2/max(SE2),'-b','linewidth',1.3);hold on
% p3=plot(C3,SE3/max(SE3),'-k','linewidth',1.3,'MarkerFaceColor','m');hold on
% p4=plot(C4,SE4/max(SE4),'-c','linewidth',1.3,'MarkerFaceColor','m');hold on
% p5=plot(C5,SE5/max(SE5),'-r','linewidth',1.3,'MarkerFaceColor','m');
% 
% 
% set(gca,'FontName','Times New Roman');
% set(gca,'LooseInset',get(gca,'TightInset'),'linewidth',1);
% lgd=legend('ILASM','HLM','CHM','CTCCM','location','best'); 
% set(lgd,'FontSize',10);
% set(gca,'LooseInset',get(gca,'TightInset'));
% set(gca,'YLim',[0 max([max(SE2),max(SE2),max(SE2),max(SE2)])],'FontSize',12);set(gca,'YTick',0:0.2:1);set(gca,'YTickLabel',0:0.2:1);
% xlabel('\mu,\it{b},\it{\alpha},\rho');ylabel('SEs');

figure;
p2=plot(C2,SE2,'-b','linewidth',1.3);hold on
p3=plot(C3,SE3,'-k','linewidth',1.3,'MarkerFaceColor','m');hold on
p4=plot(C4,SE4,'-c','linewidth',1.3,'MarkerFaceColor','m');hold on
p5=plot(C5,SE5,'-r','linewidth',1.3,'MarkerFaceColor','m');

set(gca,'FontName','Times New Roman');
set(gca,'LooseInset',get(gca,'TightInset'),'linewidth',1);
lgd=legend('ILASM','HLM','CHM','CTCCM','location','best'); 
set(lgd,'FontSize',10);
set(gca,'LooseInset',get(gca,'TightInset'));
set(gca,'YLim',[0 max([max(SE2),max(SE3),max(SE4),max(SE5)])],'FontSize',17);set(gca,'YTick',0:0.5:2.1);set(gca,'YTickLabel',0:0.5:2.1);
xlabel('\mu,\it{b},\it{\alpha},\rho');ylabel('SEs');
% saveas(gcf,'SEs.png')