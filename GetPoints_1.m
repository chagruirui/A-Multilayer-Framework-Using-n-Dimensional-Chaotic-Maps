% 输入两个序列获得点集
function [x,y] = GetPoints_1(x,y,keepNaN)
    arguments
        % s
        x
        y
        keepNaN=false
    end

    % x=[s.X];
    % y=[s.Y];

    if ~keepNaN
        x(isnan(x))=[];
        y(isnan(y))=[];
    end
end
