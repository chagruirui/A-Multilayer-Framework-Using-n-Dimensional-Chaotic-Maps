function extracted_watermark = extract_zero_watermark_ds(attacked_img, zero_watermark, chaos_mask)
    % 参数设置
    wavelet_name = 'haar';
    level = 1;

    % 读取受攻击图像
    I_attacked = double(attacked_img);
   Zero_watermark = double(zero_watermark);
   [m, n] = size(Zero_watermark);

    %扩散解密零水印
      chaos_mask=chaos_mask(:);
     Zero_watermark=Zero_watermark(:);
    chaos_seq=mod(floor((chaos_mask+100)*pow2(16)),2);%65536*1double
    Zero_watermark = xor(Zero_watermark, chaos_seq);

    % 小波分解
    [LL_attacked, HL_attacked, LH_attacked, HH_attacked] = dwt2(I_attacked, wavelet_name);
   LHLH_attacked = [LL_attacked, HL_attacked; LH_attacked, HH_attacked];

    % Schur分解
    [U_attacked, T_attacked] = schur(LHLH_attacked);

    % 提取特征
    feature_attacked = abs(T_attacked) > mean(abs(T_attacked(:)));
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