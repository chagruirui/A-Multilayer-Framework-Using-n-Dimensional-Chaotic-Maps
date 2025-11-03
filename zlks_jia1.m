%% 同时的置乱扩散+反馈
%P原图
%s混沌序列s=2*m*n
function C=zlks_jia1(P, par, S1,S2)
P=P(:);%转换成一维序列
P=P';
[M,N]=size(P);
P=double(P);
P1=zeros(1,M*N);
%混沌序列123
S1=mod(floor(S1*pow2(16)),M*N);
S2=mod(floor(S2*pow2(16)),256);
S3=bitxor(S1,S2);
S3=mod(floor(S3*pow2(16)),8);
% 循环移位
for n=1:M*N
    P1(n)=BitCircShift(P(n),S3(n));
end
%排序
[~,V] = sort(S1,'ascend');
%加密
C=zeros(1,M*N);
%C0=par;
C(1)=bitxor(bitxor(P1(V(1)),S2(V(1))),par);
par=C(1);
for i=2:M*N
    % C(i)=bitxor(bitxor(P1(V(i)),S2(V(i))),C(i-1));
    C(i)=bitxor(bitxor(P1(V(i)),S2(V(i))),par);
    par=C(i);
end
%C=reshape(C,M,N);
end