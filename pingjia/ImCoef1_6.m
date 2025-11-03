%相关系数计算四个方向一张二维图
function r=ImCoef1_6(A,N)
A=double(A);[m,n]=size(A);r=zeros(1,3);
x1=mod(floor(rand(1,N)*10^10),m-1)+1;
x2=mod(floor(rand(1,N)*10^10),m)+1;
x3=mod(floor(rand(1,N)*10^10),m-1)+2;
y1=mod(floor(rand(1,N)*10^10),n-1)+1;
y2=mod(floor(rand(1,N)*10^10),n)+1;
u1=zeros(1,N);u2=zeros(1,N);u3=zeros(1,N);u4=zeros(1,N);
v1=zeros(1,N);v2=zeros(1,N);v3=zeros(1,N);v4=zeros(1,N); 
for i=1:N
u1(i)=A(x1(i),y2(i));v1(i)=A(x1(i)+1,y2(i));%水平
u2(i)=A(x2(i),y1(i));v2(i)=A(x2(i),y1(i)+1); %竖直
u3(i)=A(x1(i),y1(i));v3(i)=A(x1(i)+1,y1(i)+1); %正对角
u4(i)=A(x3(i),y1(i));v4(i)=A(x3(i)-1,y1(i)+1);%反对角
end
%计算相关系数
r(1)=mean((u1-mean(u1)).*(v1-mean(v1)))/(std(u1,1)*std(v1,1)); 
r(2)=mean((u2-mean(u2)).*(v2-mean(v2)))/(std(u2,1)*std(v2,1));
r(3)=mean((u3-mean(u3)).*(v3-mean(v3)))/(std(u3,1)*std(v3,1));
r(4)=mean((u4-mean(u4)).*(v4-mean(v4)))/(std(u4,1)*std(v4,1));
%水平方向上随机选择的n对响铃像素点的相关图形
figure();
plot(u1,v1,'b.','linewidth',3,'markersize',5);
hold on

plot(u2,v2,'g.','linewidth',3,'markersize',5);
hold on

plot(u3,v3,'m.','linewidth',3,'markersize',5);

hold on

plot(u4,v4,'c.','linewidth',3,'markersize',5);
axis([0 250 0 250]);
set(gca,'XTick',0:50:250,'YTick',0:50:250,'fontsize',18,'fontname','times new roman');
set(gca,'XTickLabel',{'0','50','100','150','200','250'}); 
set(gca,'YTickLabel',{'0','50','100','150','200','250'}); 
 xlabel('\bf \itPixel value on location(\itx\rm,\ity\rm)');
 ylabel('\bf \itPixel value on location(\itxrm+1,\ity\rm)');
% xlabel('(\itx\rm,\ity\rm)\fontname{宋体}位置上的像素灰度值');
% ylabel('(\itxrm+1,\ity\rm)\fontname{宋体}位置上的像素灰度值');
end