% 相空间重构:eDim为嵌入维数,eLag为延迟时间
% 当X具有多列和多行时，每列将被视为独立的时间序列,该算法对X的每一列假设相同的时间延迟和嵌入维度,并以标量返回ESTDIM和ESTLAG。
 %[~,eLag,eDim] = phaseSpaceReconstruction(X);
%% 排列熵算法
function [pe ,hist] = PermutationEntropy(y,m,t)

%  Calculate the permutation entropy(PE)
%  排列熵算法的提出者：Bandt C，Pompe B. Permutation entropy:a natural complexity measure for time series[J]. Physical Review Letters,2002,88(17):174102.

%  Input:   y: time series;时间序列
%           m: order of permuation entropy 嵌入维数
%           t: delay time of permuation entropy,延迟时间

% Output: 
%           pe:    permuation entropy排列熵
%           hist:  the histogram for the order distribution订单分布的直方图
ly = length(y);
permlist = perms(1:m);
[h,~]=size(permlist);
c(1:length(permlist))=0;

 for j=1:ly-t*(m-1)
     [~,iv]=sort(y(j:t:j+t*(m-1)));
     for jj=1:h
         if (abs(permlist(jj,:)-iv))==0  % iv可看做得到的符号序列
             c(jj) = c(jj) + 1 ;  %累计每种排列对应m！中出现的次数
         end
     end
 end
hist = c;
c=c(c~=0);%找出非零元素索索引值对应的数值
p = c/sum(c);%计算每一种符号序列出现的概率
pe = -sum(p .* log(p));%shannon熵的形式
% 归一化
pe=pe/log(factorial(m));
end
