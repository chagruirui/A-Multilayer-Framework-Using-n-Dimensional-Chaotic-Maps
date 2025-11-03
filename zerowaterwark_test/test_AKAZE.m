%% 利用 AKAZE 特征提取实现零水印生成
% AKAZE（Accelerated-KAZE）是一种基于非线性扩散的特征提取方法，
% 能够提取出更加丰富的特征信息。它通过构建尺度空间并使用非线性扩散滤波器来检测特征点
% ，并使用二进制字符串来表示特征描述子。
% AKAZE 具有较高的鲁棒性和计算效率，适合处理复杂图像。
% 读取图像并预处理

addpath('path_to_computer_vision_toolbox');

img = imread('peppers.png'); % 替换为你的图像路径
img = rgb2gray(img); % 转为灰度图像
img = im2double(img); % 转为双精度图像

% AKAZE 特征提取
[keypoints, descriptors] = detectAKAZEFeatures(img);

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
is_valid = verify_watermark_AKAZE(img, zero_watermark);