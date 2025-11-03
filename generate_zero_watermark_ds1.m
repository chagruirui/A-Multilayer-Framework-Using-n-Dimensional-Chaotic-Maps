function [zero_watermark] = generate_zero_watermark_ds1(Original_img, Watermark_img, chaos_mask)

    % 读取原始图像和水印图像
    Original_img = double(Original_img);
    Watermark_img = double(Watermark_img);
   % 归一化图像到0-1范围
     Original_img = im2double(Original_img);
    % 计算傅里叶变换
    F = fft2(Original_img );
    F_shift = fftshift(F); % 将零频分量移到中心
    magnitude_spectrum = log(1 + abs(F_shift)); % 计算频谱的对数

    % 特征提取（示例：取绝对值并二值化）
    feature = abs(magnitude_spectrum) > mean(abs(magnitude_spectrum(:)));
    feature=feature(:);%65536*1 logical

    % 混沌加密水印
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

