function extracted_watermark = extract_zero_watermark_ds1(attacked_img, zero_watermark, chaos_mask)


    % 读取受攻击图像
    I_attacked = double(attacked_img);
   Zero_watermark = double(zero_watermark);
   [m, n] = size(Zero_watermark);
   % 归一化图像到0-1范围
     I_attacked = im2double(I_attacked);


    %扩散解密零水印
      chaos_mask=chaos_mask(:);
     Zero_watermark=Zero_watermark(:);
    chaos_seq=mod(floor((chaos_mask+100)*pow2(16)),2);%65536*1double
    Zero_watermark = xor(Zero_watermark, chaos_seq);

       % 计算傅里叶变换
    F = fft2(I_attacked );
    F_shift = fftshift(F); % 将零频分量移到中心
    magnitude_spectrum = log(1 + abs(F_shift)); % 计算频谱的对数

    % 提取特征
    feature_attacked = abs(magnitude_spectrum) > mean(abs(magnitude_spectrum(:)));
    feature_attacked=double(feature_attacked(:));%65536*1 logical
    
    % 提取水印
    ex_watermark = xor(feature_attacked, Zero_watermark);

    % 水印置乱解密
   % chaos_mask=chaos_mask(:);
     [~,logo_index] = sort(chaos_mask);
    [~,Watermark_index] = sort(logo_index);
    extracted_watermark= ex_watermark(Watermark_index);

    extracted_watermark=reshape(extracted_watermark,m,n);
end