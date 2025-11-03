function [x,y]=chaos8_2d(key,M,N)
a=key(1);
b=key(2);

MM = M*N;
x= zeros(1,MM+1000);
y = zeros(1,MM+1000);
for n = 1:MM+1000
    x(1)=6;
    y(1)=6;
  	x(n+1)=cos(pi*exp((a-x(n)*x(n)))+exp((4/b*(sin(pi*y(n))))));
 	y(n+1)=cos(pi*exp((4/b*(sin(pi*x(n+1)))))+exp((a-y(n)*y(n))));
end
x=x(1002:length(x)); 
y=y(1002:length(y)); 
end