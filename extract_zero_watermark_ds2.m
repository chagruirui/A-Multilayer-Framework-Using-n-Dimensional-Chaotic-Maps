function extracted_watermark = extract_zero_watermark_ds2(attacked_img, zero_watermark, chaos_mask)

    % 读取受攻击图像
    I_attacked = double(attacked_img);
   Zero_watermark = double(zero_watermark);
   [m, n] = size(Zero_watermark);

   %边缘检测
    I_attacked= imgaussfilt(I_attacked, 2); % 高斯滤波
     I_attacked_edge =edge( I_attacked  ,'Canny',0.16);
      I_attacked_edge=double(I_attacked_edge);
     figure;
   imshow(I_attacked_edge);
  feature_attacked=I_attacked_edge(:);
    %扩散解密零水印
      chaos_mask=chaos_mask(:);
     Zero_watermark=Zero_watermark(:);
    chaos_seq=mod(floor((chaos_mask+100)*pow2(16)),2);%65536*1double
    Zero_watermark = xor(Zero_watermark, chaos_seq);
    
    % 提取水印
    ex_watermark = xor(feature_attacked, Zero_watermark);

    % 水印置乱解密
   % chaos_mask=chaos_mask(:);
     [~,logo_index] = sort(chaos_mask);
    [~,Watermark_index] = sort(logo_index);
    extracted_watermark= ex_watermark(Watermark_index);

    extracted_watermark=reshape(extracted_watermark,m,n);
end