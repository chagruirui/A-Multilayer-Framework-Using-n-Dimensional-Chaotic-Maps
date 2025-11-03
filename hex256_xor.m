function dec_result = hex256_xor(input_str)
    % 检查输入是否为64个字符的十六进制字符串
    if length(input_str) ~= 64
        error('输入必须为64个字符的十六进制字符串');
    end
    valid_chars = ismember(input_str, ['0':'9', 'a':'f', 'A':'F']);
    if ~all(valid_chars)
        error('输入包含非十六进制字符');
    end
    
    % 转换为大写以便统一处理
    input_str = upper(input_str);
    
    % 初始化异或结果为0（32位无符号整数）
    xor_result = uint32(0);
    
    % 分割并处理每个32位块
    for i = 1:8
        start_idx = (i-1)*8 + 1;
        end_idx = i*8;
        block_hex = input_str(start_idx:end_idx);
        
        % 将十六进制块转换为十进制数值
        block_dec = hex2dec(block_hex);
        
        % 转换为uint32类型并进行异或操作
        xor_result = bitxor(xor_result, uint32(block_dec));
    end
    
    % 返回十进制结果
    dec_result = double(xor_result);
end