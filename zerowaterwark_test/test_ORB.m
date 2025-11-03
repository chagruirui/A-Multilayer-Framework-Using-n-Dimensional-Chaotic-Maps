% % ORB（Oriented FAST and Rotated BRIEF）
% % 特点：ORB结合了FAST（Features from Accelerated Segment Test）特征点检测和BRIEF（Binary Robust Independent Elementary Features）特征描述子，并进行了改进。它具有旋转不变性和较高的计算效率。
% % 优势：ORB比SIFT和SURF更快，适合嵌入式设备和实时应用。
% 读取图像并预处理
clc
clear
close all 
img = imread('peppers.png'); % 替换为你的图像路径
img = rgb2gray(img); % 转为灰度图像
img = im2double(img); % 转为双精度图像

% ORB 特征提取
[keypoints] = detectORBFeatures(img);

% 选择尺度空间较大的特征点
scales = keypoints.Scale;
[~, sort_idx] = sort(scales, 'descend');
selected_descriptors = descriptors(:, sort_idx(1:100)); % 选择前 100 个特征向量


% 生成零水印
zero_watermark = reshape(selected_descriptors, 1, []);
zero_watermark = round(zero_watermark * 1000); % 量化处理

% 保存零水印
save('zero_watermark.mat', 'zero_watermark');

% 验证阶段
valid = verify_watermark_orb(img, zero_watermark);