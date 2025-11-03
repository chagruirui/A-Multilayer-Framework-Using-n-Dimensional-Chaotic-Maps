% ==================================================
% 单个图像加密算法的统计性能分析
% 计算指标：信息熵、相关系数、NPCR、UACI
% 输出：平均值、标准差、95%置信区间
% ==================================================

clc;
clear;
close all;

% 1. 初始化参数
num_images = 100; % 图像数量 N
dataset_path = 'image_dataset/'; % 图像数据集路径
alpha = 0.05; % 显著性水平，用于计算95%置信区间
t_critical = tinv(1-alpha/2, num_images-1); % t分布的临界值

% 2. 预分配数组存储结果
entropy_vals = zeros(num_images, 1);
horizontal_corr_vals = zeros(num_images, 1);
kafang=zeros(num_images, 1);
vertical_corr_vals = zeros(num_images, 1);
diagonal_corr_vals = zeros(num_images, 1);
npcr_vals = zeros(num_images, 1);
uaci_vals = zeros(num_images, 1);

% 3. 遍历所有图像并计算指标
fprintf('开始处理 %d 张图像...\n', num_images);
for img_idx = 1:num_images
    % 读取原始图像
    orig_img = imread(fullfile(dataset_path, sprintf('%03d.jpg', img_idx)));

    % orig_img = imresize(orig_img, [512 512]);


    % 确保图像是二维的（灰度图）
    if size(orig_img, 3) == 3
        orig_img = rgb2gray(orig_img);
    end
    orig_img = double(orig_img);

    
    % 使用您的算法加密图像
    cipher_img = myEncryption(orig_img); % 请替换为您的加密函数
    
    % 计算各项指标
    entropy_vals(img_idx) = ENTROPY_4_26(cipher_img);%calc_entropy

    % 计算卡方检验
    kafang(img_idx)=kafangjianyan(cipher_img);

    % 计算三个方向的相关系数
    [horizontal_corr_vals(img_idx), vertical_corr_vals(img_idx), diagonal_corr_vals(img_idx)] = ...
        calc_correlation_coefficients(cipher_img);
    
    % 计算NPCR和UACI
    [npcr_vals(img_idx), uaci_vals(img_idx)] = calc_npcr_uaci(orig_img, cipher_img);
    
    fprintf('已处理图像 %d/%d\n', img_idx, num_images);
end

% 4. 计算统计量函数
function [mu, sigma, ci_low, ci_high] = compute_stats(data, t_critical, n)
    mu = mean(data);
    sigma = std(data);
    se = sigma / sqrt(n); % 标准误差
    margin = t_critical * se; % 置信区间半宽
    ci_low = mu - margin;
    ci_high = mu + margin;
end

% 5. 为每个指标计算统计量
fprintf('\n=== 算法性能统计分析结果 ===\n');
fprintf('基于 %d 张测试图像\n\n', num_images);

% 信息熵
[mu_ent, sigma_ent, ci_low_ent, ci_high_ent] = compute_stats(entropy_vals, t_critical, num_images);
fprintf('信息熵 (Information Entropy):\n');
fprintf('  平均值 = %.6f, 标准差 = %.6f\n', mu_ent, sigma_ent);
fprintf('  95%% 置信区间 = [%.6f, %.6f]\n\n', ci_low_ent, ci_high_ent);
% 卡方检验
[ku_ent, kigma_ent, k_low_ent, k_high_ent] = compute_stats(kafang, t_critical, num_images);
fprintf('卡方检验:\n');
fprintf('  平均值 = %.6f, 标准差 = %.6f\n', ku_ent, kigma_ent);
fprintf('  95%% 置信区间 = [%.6f, %.6f]\n\n', k_low_ent, k_high_ent);
% 水平相关系数
[mu_hcorr, sigma_hcorr, ci_low_hcorr, ci_high_hcorr] = compute_stats(horizontal_corr_vals, t_critical, num_images);
fprintf('水平相关系数 (Horizontal Correlation):\n');
fprintf('  平均值 = %.6f, 标准差 = %.6f\n', mu_hcorr, sigma_hcorr);
fprintf('  95%% 置信区间 = [%.6f, %.6f]\n\n', ci_low_hcorr, ci_high_hcorr);

% 垂直相关系数
[mu_vcorr, sigma_vcorr, ci_low_vcorr, ci_high_vcorr] = compute_stats(vertical_corr_vals, t_critical, num_images);
fprintf('垂直相关系数 (Vertical Correlation):\n');
fprintf('  平均值 = %.6f, 标准差 = %.6f\n', mu_vcorr, sigma_vcorr);
fprintf('  95%% 置信区间 = [%.6f, %.6f]\n\n', ci_low_vcorr, ci_high_vcorr);

% 对角相关系数
[mu_dcorr, sigma_dcorr, ci_low_dcorr, ci_high_dcorr] = compute_stats(diagonal_corr_vals, t_critical, num_images);
fprintf('对角相关系数 (Diagonal Correlation):\n');
fprintf('  平均值 = %.6f, 标准差 = %.6f\n', mu_dcorr, sigma_dcorr);
fprintf('  95%% 置信区间 = [%.6f, %.6f]\n\n', ci_low_dcorr, ci_high_dcorr);

% NPCR
[mu_npcr, sigma_npcr, ci_low_npcr, ci_high_npcr] = compute_stats(npcr_vals, t_critical, num_images);
fprintf('NPCR:\n');
fprintf('  平均值 = %.6f%%, 标准差 = %.6f\n', mu_npcr, sigma_npcr);
fprintf('  95%% 置信区间 = [%.6f%%, %.6f%%]\n\n', ci_low_npcr, ci_high_npcr);

% UACI
[mu_uaci, sigma_uaci, ci_low_uaci, ci_high_uaci] = compute_stats(uaci_vals, t_critical, num_images);
fprintf('UACI:\n');
fprintf('  平均值 = %.6f%%, 标准差 = %.6f\n', mu_uaci, sigma_uaci);
fprintf('  95%% 置信区间 = [%.6f%%, %.6f%%]\n\n', ci_low_uaci, ci_high_uaci);

% 6. 辅助函数定义
function entropy = calc_entropy(img)
    % 计算图像的信息熵
    [counts, ~] = imhist(uint8(img));
    prob = counts / sum(counts);
    prob(prob == 0) = []; % 移除零概率值
    entropy = -sum(prob .* log2(prob));
end

function [h_corr, v_corr, d_corr] = calc_correlation_coefficients(img)
    % 计算水平、垂直和对角方向的相邻像素相关系数
    [h, w] = size(img);
    
    % 水平方向
    x = img(1:end, 1:end-1);
    y = img(1:end, 2:end);
    h_corr = corr2(x(:), y(:));
    
    % 垂直方向
    x = img(1:end-1, 1:end);
    y = img(2:end, 1:end);
    v_corr = corr2(x(:), y(:));
    
    % 对角方向
    x = img(1:end-1, 1:end-1);
    y = img(2:end, 2:end);
    d_corr = corr2(x(:), y(:));
end

function [npcr, uaci] = calc_npcr_uaci(orig_img, cipher_img)
    % 计算NPCR和UACI
    % 确保图像尺寸相同
    if any(size(orig_img) ~= size(cipher_img))
        error('原始图像和加密图像尺寸不一致');
    end
    
    % 转换为相同数据类型
    orig_img = double(orig_img);
    cipher_img = double(cipher_img);
    
    P1=double(orig_img);P2=double(cipher_img);[M,N]=size(P1);
    D=(P1~=P2);npcr=sum(sum(D))/(M*N)*100;

    uaci=sum(sum(abs(P1-P2)))/(255*M*N)*100;
end