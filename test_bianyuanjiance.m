%% 测试边缘检测算法
clear;
clc;
close all;
I1=imread('033.jpg'); %036_512.jpg
if size(I1,3)>1
I1=rgb2gray(I1);
end
[M,N]=size(I1);
figure; 
imshow(I1);

BW5=edge(I1,'LOG',0.16);
figure; 
imshow(BW5);

BW6=edge(I1,'Canny',0.16);
figure; 
imshow(BW6);

