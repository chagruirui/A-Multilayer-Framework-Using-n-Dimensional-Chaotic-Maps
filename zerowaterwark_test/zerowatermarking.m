% 基于DCT直流分量的零水印算法
function [zerow, elogo]=zerowatermarking(I,logo,K1,K2,K3)
    I = double(I);%载体图像
    logo = double(logo);
    [lm,ln] = size(logo);
    [im,in] = size(I);

    x = 8*ones(1,im/8);
    I_cell = mat2cell(I,x,x);

    Idc = cellfun(@zerowfun,I_cell);

    % DC置乱序列
    X1 = K1;
    [~,index] = sort(X1(1:(im/8)^2));
    % 置乱DC系数，得到zw
    zw = Idc(index(1:lm*ln));

    % 生成logo置乱序列
    X2 = K2;
    X2 = X2(1:lm*ln);
    [~,logo_index] = sort(X2);
    logo_permuted = logo(logo_index);
    logo_permuted = reshape(logo_permuted,[lm ln]);
    logo_permuted(logo_permuted>127) = 1;

    % 加密矩阵
    X3 = K3;
    X3 = X3(1:lm*ln);
    X3 = reshape(X3,[lm,ln]);
    X3 = mod(floor(X3*10^7),2);

    % 生成零水印
    zw_shift = circshift(zw,1);
    z = zw - zw_shift;
    z(z>0) =1;
    z(z<0) =0;
    zerow = reshape(z,[lm ln]);

    final_w = bitxor(zerow,logo_permuted);
    final_w = bitxor(final_w,X3);
    final_w(final_w == 1) = 255;
    elogo=final_w;
end
function w=zerowfun(x)
    tmp = dct2(x);
    w = tmp(1);
    %[swa,swd] = swt(s,3,'db1');
end