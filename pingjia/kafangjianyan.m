function chai1=kafangjianyan(P)
[M,N]=size(P);g=M*N/256;
fp1=hist(P(:),256);
chai1=sum((fp1-g).^2)/g;
end