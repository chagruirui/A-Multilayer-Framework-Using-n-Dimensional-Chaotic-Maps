function isCollinear = PtAreCollinear_1(x, y)
    % PtAreCollinear 判断一组点是否共线
    % 输入:
    %   x - 一个向量，包含点的横坐标
    %   y - 一个向量，包含点的纵坐标
    % 输出:
    %   isCollinear - 逻辑值，true 表示点共线，false 表示点不共线

    % 检查输入点的数量
    if length(x) < 2 || length(y) < 2
        error('至少需要两个点来判断共线性');
    end

    if length(x) ~= length(y)
        error('x 和 y 的长度必须相同');
    end

    % 构造矩阵 A
    A = [x; y]';

    % 计算矩阵 A 的秩
    rankA = rank(A);

    % 判断是否共线
    isCollinear = rankA <= 1;
end