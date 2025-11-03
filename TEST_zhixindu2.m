% ==================================================
% 图像加密算法的统计性能分析与显著性测试
% 计算指标：信息熵、相关系数、NPCR、UACI
% 输出：平均值、标准差、95%置信区间，以及与参考算法的显著性测试
% ==================================================

clc;
clear;
close all;

% 1. 初始化参数
num_images = 100; % 图像数量 N
dataset_path = 'image_dataset/'; % 图像数据集路径
alpha = 0.05; % 显著性水平
t_critical = tinv(1-alpha/2, num_images-1); % t分布的临界值

% 2. 预分配数组存储结果
% 您的算法
entropy_proposed = zeros(num_images, 1);
horizontal_corr_proposed = zeros(num_images, 1);
vertical_corr_proposed = zeros(num_images, 1);
diagonal_corr_proposed = zeros(num_images, 1);
npcr_proposed = zeros(num_images, 1);
uaci_proposed = zeros(num_images, 1);

% 参考算法 (例如AES, 混沌加密等)
entropy_reference = zeros(num_images, 1);
horizontal_corr_reference = zeros(num_images, 1);
vertical_corr_reference = zeros(num_images, 1);
diagonal_corr_reference = zeros(num_images, 1);
npcr_reference = zeros(num_images, 1);
uaci_reference = zeros(num_images, 1);

% 3. 遍历所有图像并计算指标
fprintf('开始处理 %d 张图像...\n', num_images);
for img_idx = 1:num_images
    % 读取原始图像
    orig_img = imread(fullfile(dataset_path, sprintf('%03d.png', img_idx)));
    
    % 确保图像是二维的（灰度图）
    if size(orig_img, 3) == 3
        orig_img = rgb2gray(orig_img);
    end
    orig_img = double(orig_img);
    
    % 使用您的算法加密图像
    cipher_proposed = myEncryption(orig_img); % 请替换为您的加密函数
    
    % 使用参考算法加密图像
    cipher_reference = referenceEncryption(orig_img); % 请替换为参考算法的加密函数
    
    % 计算您的算法的各项指标
    entropy_proposed(img_idx) = calc_entropy(cipher_proposed);
    [horizontal_corr_proposed(img_idx), vertical_corr_proposed(img_idx), diagonal_corr_proposed(img_idx)] = ...
        calc_correlation_coefficients(cipher_proposed);
    [npcr_proposed(img_idx), uaci_proposed(img_idx)] = calc_npcr_uaci(orig_img, cipher_proposed);
    
    % 计算参考算法的各项指标
    entropy_reference(img_idx) = calc_entropy(cipher_reference);
    [horizontal_corr_reference(img_idx), vertical_corr_reference(img_idx), diagonal_corr_reference(img_idx)] = ...
        calc_correlation_coefficients(cipher_reference);
    [npcr_reference(img_idx), uaci_reference(img_idx)] = calc_npcr_uaci(orig_img, cipher_reference);
    
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

% 5. 显著性检验函数
function [h, p_value, test_type] = significance_test(proposed_data, reference_data, metric_type)
    % 执行配对t检验
    % 根据指标类型确定检验方向
    switch metric_type
        case {'entropy', 'npcr'} % 越大越好，使用右尾检验
            [h, p_value] = ttest(proposed_data, reference_data, 'Alpha', 0.05, 'Tail', 'right');
            test_type = '右尾检验 (越大越好)';
        case {'horizontal_corr', 'vertical_corr', 'diagonal_corr'} % 越小越好，使用左尾检验
            [h, p_value] = ttest(proposed_data, reference_data, 'Alpha', 0.05, 'Tail', 'left');
            test_type = '左尾检验 (越小越好)';
        case 'uaci' % 接近理想值(33.4635%)最好，使用双尾检验
            [h, p_value] = ttest(proposed_data, reference_data, 'Alpha', 0.05, 'Tail', 'both');
            test_type = '双尾检验 (接近理想值)';
        otherwise
            error('未知的指标类型');
    end
end

% 6. 为每个指标计算统计量并进行显著性检验
fprintf('\n=== 算法性能统计分析结果 ===\n');
fprintf('基于 %d 张测试图像\n\n', num_images);

% 信息熵
[mu_ent_p, sigma_ent_p, ci_low_ent_p, ci_high_ent_p] = compute_stats(entropy_proposed, t_critical, num_images);
[mu_ent_r, sigma_ent_r, ci_low_ent_r, ci_high_ent_r] = compute_stats(entropy_reference, t_critical, num_images);
[h_ent, p_ent, test_type_ent] = significance_test(entropy_proposed, entropy_reference, 'entropy');

fprintf('信息熵 (Information Entropy):\n');
fprintf('  您的算法: 平均值 = %.6f, 标准差 = %.6f, 95%% CI = [%.6f, %.6f]\n', ...
    mu_ent_p, sigma_ent_p, ci_low_ent_p, ci_high_ent_p);
fprintf('  参考算法: 平均值 = %.6f, 标准差 = %.6f, 95%% CI = [%.6f, %.6f]\n', ...
    mu_ent_r, sigma_ent_r, ci_low_ent_r, ci_high_ent_r);
fprintf('  显著性检验 (%s): p值 = %.6f, h = %d (1表示有显著差异)\n\n', ...
    test_type_ent, p_ent, h_ent);

% 水平相关系数
[mu_hcorr_p, sigma_hcorr_p, ci_low_hcorr_p, ci_high_hcorr_p] = compute_stats(horizontal_corr_proposed, t_critical, num_images);
[mu_hcorr_r, sigma_hcorr_r, ci_low_hcorr_r, ci_high_hcorr_r] = compute_stats(horizontal_corr_reference, t_critical, num_images);
[h_hcorr, p_hcorr, test_type_hcorr] = significance_test(horizontal_corr_proposed, horizontal_corr_reference, 'horizontal_corr');

fprintf('水平相关系数 (Horizontal Correlation):\n');
fprintf('  您的算法: 平均值 = %.6f, 标准差 = %.6f, 95%% CI = [%.6f, %.6f]\n', ...
    mu_hcorr_p, sigma_hcorr_p, ci_low_hcorr_p, ci_high_hcorr_p);
fprintf('  参考算法: 平均值 = %.6f, 标准差 = %.6f, 95%% CI = [%.6f, %.6f]\n', ...
    mu_hcorr_r, sigma_hcorr_r, ci_low_hcorr_r, ci_high_hcorr_r);
fprintf('  显著性检验 (%s): p值 = %.6f, h = %d (1表示有显著差异)\n\n', ...
    test_type_hcorr, p_hcorr, h_hcorr);

% 垂直相关系数
[mu_vcorr_p, sigma_vcorr_p, ci_low_vcorr_p, ci_high_vcorr_p] = compute_stats(vertical_corr_proposed, t_critical, num_images);
[mu_vcorr_r, sigma_vcorr_r, ci_low_vcorr_r, ci_high_vcorr_r] = compute_stats(vertical_corr_reference, t_critical, num_images);
[h_vcorr, p_vcorr, test_type_vcorr] = significance_test(vertical_corr_proposed, vertical_corr_reference, 'vertical_corr');

fprintf('垂直相关系数 (Vertical Correlation):\n');
fprintf('  您的算法: 平均值 = %.6f, 标准差 = %.6f, 95%% CI = [%.6f, %.6f]\n', ...
    mu_vcorr_p, sigma_vcorr_p, ci_low_vcorr_p, ci_high_vcorr_p);
fprintf('  参考算法: 平均值 = %.6f, 标准差 = %.6f, 95%% CI = [%.6f, %.6f]\n', ...
    mu_vcorr_r, sigma_vcorr_r, ci_low_vcorr_r, ci_high_vcorr_r);
fprintf('  显著性检验 (%s): p值 = %.6f, h = %d (1表示有显著差异)\n\n', ...
    test_type_vcorr, p_vcorr, h_vcorr);

% 对角相关系数
[mu_dcorr_p, sigma_dcorr_p, ci_low_dcorr_p, ci_high_dcorr_p] = compute_stats(diagonal_corr_proposed, t_critical, num_images);
[mu_dcorr_r, sigma_dcorr_r, ci_low_dcorr_r, ci_high_dcorr_r] = compute_stats(diagonal_corr_reference, t_critical, num_images);
[h_dcorr, p_dcorr, test_type_dcorr] = significance_test(diagonal_corr_proposed, diagonal_corr_reference, 'diagonal_corr');

fprintf('对角相关系数 (Diagonal Correlation):\n');
fprintf('  您的算法: 平均值 = %.6f, 标准差 = %.6f, 95%% CI = [%.6f, %.6f]\n', ...
    mu_dcorr_p, sigma_dcorr_p, ci_low_dcorr_p, ci_high_dcorr_p);
fprintf('  参考算法: 平均值 = %.6f, 标准差 = %.6f, 95%% CI = [%.6f, %.6f]\n', ...
    mu_dcorr_r, sigma_dcorr_r, ci_low_dcorr_r, ci_high_dcorr_r);
fprintf('  显著性检验 (%s): p值 = %.6f, h = %d (1表示有显著差异)\n\n', ...
    test_type_dcorr, p_dcorr, h_dcorr);

% NPCR
[mu_npcr_p, sigma_npcr_p, ci_low_npcr_p, ci_high_npcr_p] = compute_stats(npcr_proposed, t_critical, num_images);
[mu_npcr_r, sigma_npcr_r, ci_low_npcr_r, ci_high_npcr_r] = compute_stats(npcr_reference, t_critical, num_images);
[h_npcr, p_npcr, test_type_npcr] = significance_test(npcr_proposed, npcr_reference, 'npcr');

fprintf('NPCR:\n');
fprintf('  您的算法: 平均值 = %.6f%%, 标准差 = %.6f, 95%% CI = [%.6f%%, %.6f%%]\n', ...
    mu_npcr_p, sigma_npcr_p, ci_low_npcr_p, ci_high_npcr_p);
fprintf('  参考算法: 平均值 = %.6f%%, 标准差 = %.6f, 95%% CI = [%.6f%%, %.6f%%]\n', ...
    mu_npcr_r, sigma_npcr_r, ci_low_npcr_r, ci_high_npcr_r);
fprintf('  显著性检验 (%s): p值 = %.6f, h = %d (1表示有显著差异)\n\n', ...
    test_type_npcr, p_npcr, h_npcr);

% UACI
[mu_uaci_p, sigma_uaci_p, ci_low_uaci_p, ci_high_uaci_p] = compute_stats(uaci_proposed, t_critical, num_images);
[mu_uaci_r, sigma_uaci_r, ci_low_uaci_r, ci_high_uaci_r] = compute_stats(uaci_reference, t_critical, num_images);
[h_uaci, p_uaci, test_type_uaci] = significance_test(uaci_proposed, uaci_reference, 'uaci');

fprintf('UACI:\n');
fprintf('  您的算法: 平均值 = %.6f%%, 标准差 = %.6f, 95%% CI = [%.6f%%, %.6f%%]\n', ...
    mu_uaci_p, sigma_uaci_p, ci_low_uaci_p, ci_high_uaci_p);
fprintf('  参考算法: 平均值 = %.6f%%, 标准差 = %.6f, 95%% CI = [%.6f%%, %.6f%%]\n', ...
    mu_uaci_r, sigma_uaci_r, ci_low_uaci_r, ci_high_uaci_r);
fprintf('  显著性检验 (%s): p值 = %.6f, h = %d (1表示有显著差异)\n\n', ...
    test_type_uaci, p_uaci, h_uaci);

% 7. 辅助函数定义
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
    
    % 计算NPCR
    diff = orig_img ~= cipher_img;
    npcr = sum(diff(:)) / numel(orig_img) * 100;
    
    % 计算UACI
    uaci = mean(abs(orig_img(:) - cipher_img(:)) / 255) * 100;
end