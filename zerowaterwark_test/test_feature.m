clc
clear
close all

%% 1. HOG 特征提取
% % 读取图像
% im = im2single(imread('peppers.png'));
% 
% % 提取 HOG 特征
% [featureVector, visualization] = extractHOGFeatures(im, 'CellSize', [8 8], 'BlockSize', [2 2]);
% 
% % 可视化 HOG 特征
% figure;
% subplot(1, 2, 1);
% imshow(im);
% title('Original Image');
%% 2. SIFT 特征提取
% % 读取图像
% im = imread('peppers.png');
% if size(im,3)>1
% im=rgb2gray(im);
% end
% % 检测 SIFT 特征点
% points = detectSURFFeatures(im);
% 
% % 提取 SIFT 描述子
% [features, valid_points] = extractFeatures(im, points);
% 
% % 可视化特征点
% figure;
% imshow(im);
% hold on;
% plot(valid_points);
%% 3. 颜色特征提取
% % 读取图像
% im = imread('peppers.png');
% 
% % 将图像转换为灰度图像
% gray_im = rgb2gray(im);
% 
% % 计算灰度直方图
% histogram = imhist(gray_im);
% 
% % 可视化直方图
% figure;
% plot(histogram);
% title('Gray Histogram');
%% 4. 纹理特征提取
% % 读取图像
% im = imread('peppers.png');
% 
% % 计算图像的梯度
% sobel_x = [-1 0 1; -2 0 2; -1 0 1];
% sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];
% gradient_x = imfilter(double(im), sobel_x);
% gradient_y = imfilter(double(im), sobel_y);
% 
% % 计算梯度幅值
% gradient_magnitude = sqrt(gradient_x.^2 + gradient_y.^2);
% 
% % 可视化梯度幅值
% figure;
% imshow(gradient_magnitude, []);
% title('Gradient Magnitude');
%% 5. 形状特征提取
% % 读取图像
% im = imread('peppers.png');
% 
% % 转换为二值图像
% bw = imbinarize(rgb2gray(im));
% 
% % 提取边缘
% edges = edge(bw);
% 
% % 计算边缘特征
% edge_features = regionprops(edges, 'Perimeter', 'Area');
% 
% % 输出边缘特征
% disp(edge_features);
%% 6.单层小波分解提取特征
% %通过单层小波分解，将图像分解为低频逼近分量（LL）和高频细节分量（LH、HL、HH），
% % 然后提取这些分量的特征。
% % 读取图像并转为灰度
% img = imread('peppers.png'); % 替换为你的图像路径
% img = rgb2gray(img);
% img = im2double(img);
% 
% % 单层小波分解（使用 Daubechies 4 小波）
% [cA, cH, cV, cD] = dwt2(img, 'db4');
% 
% % 提取特征（例如，计算各分量的能量）
% energy_cA = sum(cA(:).^2);
% energy_cH = sum(cH(:).^2);
% energy_cV = sum(cV(:).^2);
% energy_cD = sum(cD(:).^2);
% 
% % 显示分解结果
% figure;
% subplot(2, 2, 1);
% imshow(cA, []);
% title('LL (低频逼近)');
% subplot(2, 2, 2);
% imshow(cH, []);
% title('LH (水平细节)');
% subplot(2, 2, 3);
% imshow(cV, []);
% title('HL (垂直细节)');
% subplot(2, 2, 4);
% imshow(cD, []);
% title('HH (对角线细节)');
%% 7. 多层小波分解提取特征
%%通过多层小波分解，提取图像的多分辨率特征。每一层分解都会生成低频逼近分量和高频细节分量
% % 读取图像并转为灰度
% img = imread('peppers.png'); % 替换为你的图像路径
% img = rgb2gray(img);
% img = im2double(img);
% 
% % 3 层小波分解（使用 Symlet 5 小波）
% [C, S] = wavedec2(img, 3, 'sym5');
% 
% % 提取各层系数
% level3 = appcoef2(C, S, 'sym5', 3);  % 第 3 层低频
% [level3H, level3V, level3D] = detcoef2('all', C, S, 3);  % 第 3 层细节
% 
% % 提取特征（例如，计算各分量的能量）
% energy_level3 = sum(level3(:).^2);
% energy_level3H = sum(level3H(:).^2);
% energy_level3V = sum(level3V(:).^2);
% energy_level3D = sum(level3D(:).^2);
% 
% % 可视化多层分解
% figure;
% subplot(1, 4, 1);
% imshow(level3, []);
% title('Layer3 LL');
% subplot(1, 4, 2);
% imshow(level3H, []);
% title('Layer3 LH');
% subplot(1, 4, 3);
% imshow(level3V, []);
% title('Layer3 HL');
% subplot(1, 4, 4);
% imshow(level3D, []);
% title('Layer3 HH');
%% 8. 小波变换结合阈值处理提取特征
% %通过小波变换对图像进行去噪或增强，然后提取特征。
% % 读取图像并转为灰度
% img = imread('peppers.png'); % 替换为你的图像路径
% img = rgb2gray(img);
% img = im2double(img);
% 
% % 添加噪声
% noisy_img = img + 0.05 * randn(size(img));
% 
% % 小波去噪
% denoised_img = wdenoise2(noisy_img, 3, 'Wavelet', 'sym6', ...
%     'DenoisingMethod', 'Bayes', 'ThresholdRule', 'Median');
% 
% % 提取特征（例如，计算去噪后的图像能量）
% energy_denoised = sum(denoised_img(:).^2);
% 
% % 对比原图和去噪结果
% figure;
% subplot(1, 2, 1);
% imshow(noisy_img);
% title('含噪图像');
% subplot(1, 2, 2);
% imshow(denoised_img);
% title('去噪结果');
%% 小波变换结合边缘检测
% %通过增强小波变换的高频细节系数，实现边缘检测。
% % 读取图像并转为灰度
% img = imread('peppers.png'); % 替换为你的图像路径
% img = rgb2gray(img);
% img = im2double(img);
% 
% % 单层小波分解（使用 Haar 小波）
% [cA, cH, cV, cD] = dwt2(img, 'haar');
% 
% % 增强高频细节系数
% cH = cH * 3;
% cV = cV * 3;
% cD = cD * 3;
% 
% % 重构边缘增强图像
% edge_enhanced = idwt2(cA, cH, cV, cD, 'haar');
% 
% % 显示原图和边缘增强结果
% figure;
% subplot(1, 2, 1);
% imshow(img);
% title('原图');
% subplot(1, 2, 2);
% imshow(edge_enhanced);
% title('边缘增强结果');
