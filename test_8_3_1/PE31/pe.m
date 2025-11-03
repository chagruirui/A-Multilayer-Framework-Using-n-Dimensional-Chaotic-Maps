%一个时间序列的排列熵
function pe=pe(X)
[m,~]=size(X);  % X为时间序列,一行为一个时间序列。
% 求排列熵:pe为排列熵
pe=zeros(1,m);
for i=1:m
    [pe(i),~] = PermutationEntropy(X(i,:),6,1);%m=5.6.7  t大于等于1
end
end
