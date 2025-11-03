function dMSE = MSE(P1,P2)
% 计算mse(均方误差)
% P1:第一幅图像
% P2:第二幅图像
% dMSE:根据两幅图像，计算均方误差

if (size(P1,1) ~= size(P2,1)) or (size(P1,2) ~= size(P2,2))
    error('P1 <> P2');
    dMSE = 0;
    return ;
end
P1=double(P1);
P2=double(P2);
M = size(P1,1);
N = size(P2,2);
d1 = 0;
for i = 1:M
    for j = 1:N
        d1 = d1 + (P1(i,j) - P2(i,j)).^2;
    end
end
dMSE = d1/(M*N);
return
