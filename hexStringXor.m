function [Key] = hexStringXor(hexString)
    % 检查输入是否为64个字符的十六进制字符串
    if length(hexString) ~= 64 || ~all(ismember(hexString, '0123456789ABCDEFabcdef'))
        error('输入必须是长度为64个字符的十六进制字符串！');
    end

    n=size(hexString,2)/2;
    HexBin=Hex2Bin(hexString,4);%%HEX2BIN将十六进制字符串转换为二进制字符串。64*4
    HexBin=HexBin(:)';
    HexDecimal=zeros(1,n);
    for i=1:1:n
        HexDecimal(i)=bin2dec(HexBin((i-1)*8+1:i*8));%1*256char二进制
    end
    key1=HexDecimal(1:16);
    xor_value1 = key1(1);
    for i1 = 2:16
    xor_value1 = bitxor(xor_value1, key1(i1));
    end
    Key(1)= xor_value1 / 256+6;
    key2=HexDecimal(17:32);
    xor_value2 = key2(1);
    for i2 = 2:16
    xor_value2 = bitxor(xor_value2, key2(i2));
    end
    Key(2) = xor_value2 /256+6;
    %% 明文相关参数par
    % tmp=floor(xor_value1*256+xor_value2);
    % par = mod(tmp, 256); % 明文相关参数
end