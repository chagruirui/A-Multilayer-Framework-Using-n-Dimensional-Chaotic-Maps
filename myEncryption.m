function cipher_img = myEncryption(orig_img)


P=orig_img(:);%转换成一维序列
P=P';
[M,N]=size(P);

%H=HashFunction3(P,'SHA-256');%得到P2的哈希值
 %[Key] = hexStringXor(H);
 Key=[6,6];
 [S1,S2]=chaos7_2d(Key,M,N);

%par= randi([0, 255], 1, 1);
par=202;
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
C(1)=bitxor(bitxor(P1(V(1)),S2(V(1))),par);
par=C(1);
for i=2:M*N
    % C(i)=bitxor(bitxor(P1(V(i)),S2(V(i))),C(i-1));
    C(i)=bitxor(bitxor(P1(V(i)),S2(V(i))),par);
    par=C(i);
end
long=sqrt(M*N);
cipher_img =reshape(C,long,long);

end