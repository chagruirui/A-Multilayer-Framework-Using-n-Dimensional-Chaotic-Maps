%  提取水印
function [rlogo]=Zwatermarkingde(I,zerow,K1)
    I = double(I);% 载体图像
    zerow(zerow>=127)=1;
    
    [lm,ln] = size(zerow);
    [im,in] = size(I);

    % 获得系数
    [swa,swd] = swt(I,3,'db1');
   Iswt = swa(3,:);
    %Iswt = swd(3,:);
    % 信息矩阵二值化
    zw_shift = circshift(Iswt,1);
    z = Iswt - zw_shift;
    z(z>0) = 1;
    z(z<0) = 0;
    information = reshape(z,[im in]);
    
    % 异或得到二维码
    elogo = bitxor(information,zerow);

    % 生成logo置乱序列
    K1=reshape(K1,1,lm*ln);
    X1 = K1;
    X1 = X1(1:lm*ln);
    [~,logo_index] = sort(X1);
    [~,logo_tindex] = sort(logo_index);
    logow = elogo(logo_tindex);

    rlogo = reshape(logow,[lm ln]);
end