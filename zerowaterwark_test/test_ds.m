% 基于多域dwt+schur融合的零水印方案
clc
clear
close all

original_img=imread('peppers.png'); 
if size(original_img,3)>1
original_img=rgb2gray(original_img);
end

watermark_img = imread('logo.png');
if size(watermark_img,3)>1
watermark_img=rgb2gray(watermark_img);
end
[m,n] = size(watermark_img);

% 生成零水印
chaos_seq = logistic_map(0.5, 3.9, m*n);
[zero_watermark] = generate_zero_watermark_ds(original_img, watermark_img, chaos_seq);


% 模拟攻击（例如添加噪声）
%attacked_img = imnoise(original_img, 'gaussian', 0, 0.01);

% 提取水印
extracted_watermark = extract_zero_watermark_ds(original_img, zero_watermark, chaos_seq );

% 显示结果
figure;
subplot(2,2,1); imshow(original_img); title('original img');
subplot(2,2,2); imshow(watermark_img); title('watermark img');
subplot(2,2,3); imshow(zero_watermark); title('zero watermark');
subplot(2,2,4); imshow(extracted_watermark); title('extracted watermark')