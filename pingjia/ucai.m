%lena与随机图像间的UACI期望值
clc;
clear;
close all;
K=[1.1 2.2 3.3 4.4];
P=imread('lenaRGB.bmp');
P=rgb2gray(P);
iptsetpref('imshowborder','tight');
%figure(1);imshow(P);
%调用加密函数，显示加密图像
C=TyEncrypt(P,K);
%figure(2);imshow(C);
u1=UACIExpect(P);
u2=UACIExpect(C);