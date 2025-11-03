function Key=HashtoDecimal3(KeyHex,HashVal)
    %KeyHex,HashVal:是哈希函数生成的字符串
    %Convert HexBin to Hex Decimal将HexBin转换为十六进制小数  
    n=size(KeyHex,2)/2;
    
    HexBin=Hex2Bin(KeyHex,4);%%HEX2BIN将十六进制字符串转换为二进制字符串。64*4
    HexBin=HexBin(:)';
    HexDecimal=zeros(1,n);
    for i=1:1:n
        HexDecimal(i)=bin2dec(HexBin((i-1)*8+1:i*8));
    end
    %%Convert HashVal to Decimal将HashVal转换为十进制
    HashBin=Hex2Bin(HashVal,4);%HEX2BIN将十六进制字符串转换为二进制字符串
    HashBin=HashBin(:)';
    HashDecimal=zeros(1,n);
    for i=1:1:n
        HashDecimal(i)=bin2dec(HashBin((i-1)*8+1:i*8));
    end
    Key=bitxor(HexDecimal,HashDecimal);
    
end