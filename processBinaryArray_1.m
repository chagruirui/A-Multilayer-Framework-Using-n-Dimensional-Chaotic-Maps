function final_dec_result = processBinaryArray_1(bin_array)
    % processBinaryArray 处理二进制数组
    % 输入:
    %   bin_array - 任意长度的二进制数组（1×n）
    % 输出:
    %   final_dec_result - 处理后的最终十进制结果

    % 计算数组长度
    seq_length = length(bin_array);

    % 判断序列长度是否为 8 的整数倍
    if mod(seq_length, 8) ~= 0
        % 如果不是 8 的整数倍，则补零
        padding_length = 8 - mod(seq_length, 8);
        bin_array = [bin_array, zeros(1, padding_length)];
    end

    % 重新计算数组长度（补零后）
    seq_length = length(bin_array);

    % 初始化每组的十进制结果数组
    dec_results = zeros(1, seq_length / 8);

    % 每 8 位一组，转换为十进制
    for i = 1:8:seq_length
        group = bin_array(i:i+7);  % 提取每组 8 位
        group_str = num2str(group);  % 将二进制数组转换为字符串
        dec_results((i+7)/8) = bin2dec(group_str);  % 转换为十进制
    end

    % 对每组的十进制结果执行异或操作
    final_dec_result = dec_results(1);
    for i = 2:length(dec_results)
        final_dec_result = bitxor(final_dec_result, dec_results(i));
    end
end