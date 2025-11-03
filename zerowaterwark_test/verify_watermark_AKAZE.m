function is_valid = verify_watermark_AKAZE(img, zero_watermark)
    img = rgb2gray(img);
    img = im2double(img);

    % AKAZE 特征提取
    [keypoints, descriptors] = detectAKAZEFeatures(img);

    % 选择尺度空间较大的特征点
    scales = keypoints.Scale;
    [~, sort_idx] = sort(scales, 'descend');
    selected_descriptors = descriptors(:, sort_idx(1:100)); % 选择前 100 个特征向量

    % 提取特征向量并量化
    extracted_features = reshape(selected_descriptors, 1, []);
    extracted_features = round(extracted_features * 1000); % 量化处理

    % 计算相似度
    correlation = corrcoef(zero_watermark, extracted_features);
    similarity = correlation(1, 2);

    % 判断是否通过验证
    threshold = 0.8; % 设置相似度阈值
    is_valid = similarity >= threshold;
end