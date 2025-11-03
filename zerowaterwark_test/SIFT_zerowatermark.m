clc
clear
close all

% 读取图像并预处理
img = imread('peppers.png'); % 替换为你的图像路径
img = rgb2gray(img); % 转为灰度图像
img = im2double(img); % 转为双精度图像

% SIFT 特征提取
[keypoints, descriptors] = detectAndCompute(SIFT(), img);

% 选择尺度空间较大的特征点
scales = keypoints.Scale;
[~, sort_idx] = sort(scales, 'descend');
selected_descriptors = descriptors(:, sort_idx(1:100)); % 选择前 100 个特征向量

% 生成零水印（将特征向量拼接为一维向量并量化）
zero_watermark = reshape(selected_descriptors, 1, []);
zero_watermark = round(zero_watermark * 1000); % 量化处理

% 保存零水印
save('zero_watermark.mat', 'zero_watermark');

% 验证阶段
is_valid = verify_watermark(img, zero_watermark);