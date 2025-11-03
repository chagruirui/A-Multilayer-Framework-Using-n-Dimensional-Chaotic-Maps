function [zero_watermark] = generate_zero_watermark_ds2(Original_img, Watermark_img, chaos_mask)

    % 读取原始图像和水印图像
    Original_img = double(Original_img);
    Watermark_img = double(Watermark_img);

    %边缘检测
    Original_img = imgaussfilt(Original_img, 2); % 高斯滤波
    Original_edge =edge(Original_img ,'Canny',0.16);
    Original_edge=double(Original_edge);
   figure;
   imshow(Original_edge);
  feature=Original_edge(:);

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

