%% Õ¨ ±µƒ÷√¬“¿©…¢Ω‚√‹
%P‘≠Õº Cº”√‹Õº
%sªÏ„Á–Ú¡–s=2*m*n
function P1=zlks_jie1(C,par,S1,S2)
[M,N]=size(C);
C=double(C);
P1=zeros(1,M*N);
%ªÏ„Á–Ú¡–123
S1=mod(floor(S1*pow2(16)),M*N);
S2=mod(floor(S2*pow2(16)),256);
S3=bitxor(S1,S2);
S3=mod(floor(S3*pow2(16)),8);
%≈≈–Ú
[~,V] = sort(S1,'ascend');
%Ω‚√‹
C=C(:);
C=C';
P=zeros(1,M*N);
C0=par;
P(V(1))=bitxor(bitxor(C(1),S2(V(1))),C0);
for i=2:M*N
    P(V(i))=bitxor(bitxor(C(i),S2(V(i))),C(i-1));
end
for n=1:M*N
    P1(n)=BitCircShift(P(n),-S3(n));
end
end