%% 密钥敏感性分析
clear;
clc;
close all;
I1=imread('result1.jpg'); %036_512.jpg
if size(I1,3)>1
I1=rgb2gray(I1);
end
[M,N]=size(I1);
I1=double(I1);
figure; 
imshow(I1);
I2=imread('result2.jpg'); %QR码512
if size(I2,3)>1
I2=rgb2gray(I2);
end
figure;
imshow(I2);
I2=double(I2);
I_CHA=abs(I1-I2);
figure;
imshow(uint8(I_CHA));
%直方图
 figure;
t1=double(I_CHA);
hist(t1(:),256,'FontName','Times New Roman');
H='e793c5539f471ee4c835adbcfb10423779f360f059e0d112670692e4398e77d9';
 [Key] = hexStringXor(H);
 %% 解密
 Pd=I2(:);
 ke=230;
 [x,y]=chaos7_2d(Key,M,N);
 %第一轮解密 7.9978
I1_1=zlks_jie1( Pd,ke,x,y);
I1_1=reshape(I1_1,M,N);
figure;
imshow(uint8(I1_1));
imwrite(uint8(I1_1), 'result2_de.jpg');
%% 密钥敏感性
nu = NPCRUACI(I1,I2);