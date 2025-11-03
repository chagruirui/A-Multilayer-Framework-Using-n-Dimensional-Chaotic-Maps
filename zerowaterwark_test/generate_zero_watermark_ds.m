function [zero_watermark] = generate_zero_watermark_ds(Original_img, Watermark_img, chaos_mask)
    % 参数设置
    wavelet_name = 'haar'; % 小波基名称
    level = 1; % 小波分解级数

    % 读取原始图像和水印图像
    Original_img = double(Original_img);
    Watermark_img = double(Watermark_img);

    % 离散小波变换(DWT)
    [LL, HL, LH, HH] = dwt2(Original_img, wavelet_name);
    LHLH = [LL, HL; LH, HH];

    % Schur分解低频分量
    [U, T] = schur(LHLH);

    % 特征提取（示例：取绝对值并二值化）
    feature = abs(T) > mean(abs(T(:)));
    feature=feature(:);%65536*1 logical

    % 混沌加密水印（示例：Logistic混沌序列）
    [m, n] = size(Watermark_img);
    Watermark_img = abs(Watermark_img) > mean(abs(Watermark_img(:)));%二值化
    Watermark_img=Watermark_img(:);%65536*1logical
%置乱加密
    chaos_mask=chaos_mask(:);
    [~,Watermark_index] = sort(chaos_mask);
    Watermark_permuted = Watermark_img(Watermark_index);
   % Watermark_permuted = reshape(Watermark_permuted,[m n]);

    %生成零水印
    zero_watermark = xor(feature, Watermark_permuted );
    %zero_watermark=floor(zero_watermark*255);

      %扩散加密
   chaos_seq=mod(floor((chaos_mask+100)*pow2(16)),2);%65536*1double
    encrypted_zero_watermark = xor(zero_watermark, chaos_seq);

    zero_watermark=reshape(encrypted_zero_watermark,m,n);
end

