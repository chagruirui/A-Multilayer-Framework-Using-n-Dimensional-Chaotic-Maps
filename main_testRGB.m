%% paper7论文加密认证流程
clear;
clc;
close all;

addpath hash;
addpath pingjia;

%% 输入明文医学图像
I1=imread('fusionRGB4.jpg'); %036_512.jpg

[M,N,r]=size(I1);
figure; 
imshow(I1);
R1=I1(:,:,1);
G1=I1(:,:,2);
B1=I1(:,:,3);
K1=HashFunction3(R1,'SHA-256');%
%% 明文信息熵
%  Entropy1=ENTROPY(I1);
%  %相关性测试 
%  ImCoef_yuan=ImCoef1_6(I1,2000);
%   r = ImCoef3D(I1,2000);
% %直方图
%  figure;
% t1=double(I1);
% hist(t1(:),256);
% %histogram(t1(:), 256);  % 使用30个bin绘制直方图
% xlim([0,255]);%对Y轴设定显示范围
% set(gca,'fontsize',18,'fontname','times new roman');
%  xlabel('\bf \itPixel value ');
%  ylabel('\bf \itFrequency');
%  kaf_yuan=kafangjianyan(t1);
%% 输入QR码
I2=imread('logo.png'); %QR码512
if size(I2,3)>1
I2=rgb2gray(I2);
end
figure;
imshow(I2);
I2=double(I2);
%%  计算凸点构造明文相关密钥
% R1=transpose(I1(:));
%  R2=transpose(I2(:));
%  w0=ConstructWatermark_1(R1,R2);
% % disp("zero watermark: ")
% % disp(w0);
% w1=double(w0);
% ke = processBinaryArray_1(w1);%计算明文反馈密钥
ke=131;
%% 明文相关参数和混沌系统密钥生成
P2=R1;
ke1=101;
ke2=202;
mi=mod(floor(ke1*10^6),M)+1;
ni=mod(floor(ke2*10^8),N)+1;
P2(mi,ni)=ke;%替换掉明文的一个像素，得到P2
%P2(1,1)=ke;%替换掉明文的第一个像素，得到P2
H=HashFunction3(P2,'SHA-256');%得到P2的哈希值
%H=HashFunction3(I1,'SHA-256');%得到P2的哈希值 铭文敏感性
%H='e793c5539f47aee4c835adbcfb10423779f360f059e0d112670692e4398e77d9';%密钥敏感性
 [Key] = hexStringXor(H);
%% 混沌系统初值+ 混沌序列生成
[x,y]=chaos7_2d(Key,M,N);
%[x,y]=chaos7_2d(Key,512,512);%         测试512
%% 基于多域dwt+schur融合的零水印方案
% 生成零水印
chaos_seq = x;
[zero_watermark] = generate_zero_watermark_ds2(R1, I2, chaos_seq);
%%  加密算法 同步置乱扩散+明文反馈
%% 第一轮加密 7.9978

tic
CR1=zlks_jia1(R1,ke,x,y);
CR1=reshape(CR1,M,N);
CG1=zlks_jia1(G1,ke,x,y);
CG1=reshape(CG1,M,N);
CB1=zlks_jia1(B1,ke,x,y);
CB1=reshape(CB1,M,N);
C(:,:,1)=CR1;
C(:,:,2)=CG1;
C(:,:,3)=CB1;
toc
%C=reshape(C,512,512);%         测试512
%第二轮加密 7.9973
% C=zlks_jia1(C,par,x,y);

figure;
imshow(uint8(C));
%imwrite(uint8(C), 'result2_mingwen.jpg');
%% 密文信息熵
  Entropy2_R=ENTROPY(CR1);
  Entropy2_G=ENTROPY(CG1);
  Entropy2_B=ENTROPY(CB1);
%  %相关性测试 
  ImCoef_miR=ImCoef1_6(CR1,2000);
  ImCoef_miG=ImCoef1_6(CG1,2000);
  ImCoef_miB=ImCoef1_6(CB1,2000);
%   r2 = ImCoef3D(C,2000);
% %直方图
% %直方图图像直方图卡方检验
 t2_R=double(CR1);
 kaf_miR=kafangjianyan(t2_R);
  t2_G=double(CG1);
 kaf_miG=kafangjianyan(t2_G);
  t2_B=double(CB1);
 kaf_miB=kafangjianyan(t2_B);
%  figure;
% hist(t2(:),256);
% %histogram(t1(:), 256);  % 使用30个bin绘制直方图
% xlim([0,255]);%对Y轴设定显示范围
% set(gca,'fontsize',18,'fontname','times new roman');
%  xlabel('\bf \itPixel value ');
%  ylabel('\bf \itFrequency');
  %% 剪切 
% C(116:141,116:141)=0;%百分之1 25*25
%C(100:157,100:157)=0;%百分之5  57*57
%C(88:168,88:168)=0;%百分之10  80*80
% C(64:192,64:192)=0;%百分之25  128*128
% C(38:219,38:219)=0;%百分之50 128*256
%figure;imshow( C,[]);%剪裁结果显示5%、10%、25%和50%
%% 添加噪声 
%C1=imnoise(uint8(C), 'salt & pepper', 0.0001);
%C1=imnoise(uint8(C), 'salt & pepper', 0.001);%椒盐噪声0.001、0.01、0.05、0.10
%C1=imnoise(uint8(C), 'salt & pepper', 0.01);
%C1=imnoise(uint8(C), 'salt & pepper', 0.05);
% C1=imnoise(uint8(C), 'salt & pepper', 0.10);
 %figure;imshow(uint8(C1));
%I=imnoise(I, 'speckle');%添加方差为0.04的乘性噪声
% %% 解密
% 
%  Pd1=double(CR1(:));
%  Pd2=double(CG1(:));
%  Pd3=double(CB1(:));
%  %第一轮解密 7.9978
% I1_11=zlks_jie1( Pd1,ke,x,y);I1_11=reshape(I1_11,M,N);
% I1_12=zlks_jie1( Pd2,ke,x,y);I1_12=reshape(I1_12,M,N);
% I1_13=zlks_jie1( Pd3,ke,x,y);I1_13=reshape(I1_13,M,N);
% CP(:,:,1)=I1_11;
% CP(:,:,2)=I1_12;
% CP(:,:,3)=I1_13;
% I1_2=uint8(CP);
% 
%  figure;
%  imshow(uint8(I1_2));
% %%  测试无损
% K2=HashFunction3(I1_2,'SHA-256');%
% CHA_1=K2-K1;
% %PSNR_image = PSNR(I1,I1_2) ;
% 
% %%  提取水印
% extracted_watermark1 = extract_zero_watermark_ds2(R1, zero_watermark, chaos_seq );%原始
% extracted_watermark2 = extract_zero_watermark_ds2(I1_11, zero_watermark, chaos_seq );%攻击
%  figure;
%  imshow(extracted_watermark2,[]);
%  PSNR_qr= PSNR(extracted_watermark1,extracted_watermark2) ;
% %%评价nc
% dNC = nc_zero(double(extracted_watermark1),double(extracted_watermark2));
% % 显示结果
% figure;
% subplot(2,2,1); imshow(R1); title('Embedded channel');
% subplot(2,2,2); imshow(I2); title('Watermark image');
% subplot(2,2,3); imshow(zero_watermark); title('Zero watermark');
% subplot(2,2,4); imshow(extracted_watermark1); title('Extracted watermark')
