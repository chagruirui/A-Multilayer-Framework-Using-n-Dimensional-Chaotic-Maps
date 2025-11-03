% 基于SWT直流分量的零水印算法
function [zerow]=Zwatermarking(I,logo,K1)
    I = double(I);% 载体图像
    logo = double(logo);% 二维码
    [lm,ln] = size(logo);

    % 二维码预处理 - 置乱
    K1=reshape(K1,1,lm*ln);
    X1 = K1;
    X1 = X1(1:lm*ln);
    [~,logo_index] = sort(X1);
    logo_permuted = logo(logo_index);
    logo_permuted = reshape(logo_permuted,[lm ln]);
    logo_permuted(logo_permuted>127) = 1;
    
    % 获得系数
    [swa,swd] = swt(I,3,'db1');
    Iswt = swa(3,:);

    % 信息矩阵二值化
    zw_shift = circshift(Iswt,1);
    z = Iswt - zw_shift;
    z(z>0) = 1;
    z(z<0) = 0;
    information = reshape(z,[lm ln]);
    
    % 异或生成零水印
    final_w = bitxor(information,logo_permuted);
    zerow = (final_w*255);
end