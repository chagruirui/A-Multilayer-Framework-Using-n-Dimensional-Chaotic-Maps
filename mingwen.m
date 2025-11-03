%% 明文敏感
clear;
clc;
close all;
I1=imread('result1_mingwen.jpg'); %036_512.jpg
if size(I1,3)>1
I1=rgb2gray(I1);
end
[M,N]=size(I1);
I1=double(I1);
figure; 
imshow(I1);
I2=imread('result2_mingwen.jpg'); %QR码512
if size(I2,3)>1
I2=rgb2gray(I2);
end
figure;
imshow(I2);
I2=double(I2);
I_CHA=abs(I1-I2);
figure;
imshow(uint8(I_CHA));
%% 明文敏感性
nu = NPCRUACI(I1,I2);