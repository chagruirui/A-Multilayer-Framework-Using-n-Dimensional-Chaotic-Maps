function [x,y,z]=test_32(b)
M = 1000;
a =10;
%b=1;
c=10;
x= zeros(1,M+1); y = zeros(1,M+1);
for i = 1:M
 x(1) = 1;y(1) =1;z(1) =1;
    x(i+1)=cos(a*z(i)+2*pi*(4/c*(sin(pi*x(i)))));
    y(i+1)=sin(b*x(i+1)-2*pi*(b*y(i)*(1-y(i))));
    z(i+1)=cos(c*y(i+1)+2*pi*(a*acos(z(i))));

end

end
