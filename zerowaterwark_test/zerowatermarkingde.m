%  提取水印
function [zwlogo,wlogo]=zerowatermarkingde(I,zerow,elogo,K1,K2,K3)
    elogo = double(elogo);
    zerow=double(zerow);
    elogo(elogo>127) = 1;
    [lm,ln] = size(elogo);
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

    % 加密矩阵
    X3 = K3;
    X3 = X3(1:lm*ln);

    X3 = reshape(X3,[lm,ln]);
    X3 = mod(floor(X3*10^7),2);

    zw_shift = circshift(zw,1);

    z = zw - zw_shift;

    z(z>0) =1;
    z(z<0) =0;
    zwlogo = reshape(z,[lm ln]);
    
    % 解密
    tmp1 = bitxor(elogo,zerow);
    logo_t = bitxor(tmp1,X3);

    [~,logo_tindex] = sort(logo_index);
    logow = logo_t(logo_tindex);

    logow = reshape(logow,[lm ln]);
    logow(logow ==1)=255;
    
    wlogo=logow;
end

function w=zerowfun(x)
    tmp = dct2(x);
    w = tmp(1);
end