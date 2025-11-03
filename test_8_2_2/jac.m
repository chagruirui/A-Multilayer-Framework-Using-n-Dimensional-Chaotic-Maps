%% luchengcheng'
clc
clear 
clc
close all
syms x y a b  pi

 	% x(n+1)=cos(a*y(n)+2*pi*(sin(b/x(n))));
	% y(n+1)=sin(b*x(n+1)-2*pi*(cos(a*acos(y(n)))));
 	x1=cos(a*y+2*pi*(sin(b/x)));
	y1=sin(b*x1-2*pi*(cos(a*acos(y))));
    jac1=jacobian([x1;y1],[x y])
    %% 
% jac1 =
% 
% [                                                        (2*b*pi*sin(a*y + 2*pi*sin(b/x))*cos(b/x))/x^2,                                                                                                     -a*sin(a*y + 2*pi*sin(b/x))]
% [(2*b^2*pi*cos(b*cos(a*y + 2*pi*sin(b/x)) - 2*pi*cos(a*acos(y)))*sin(a*y + 2*pi*sin(b/x))*cos(b/x))/x^2, -cos(b*cos(a*y + 2*pi*sin(b/x)) - 2*pi*cos(a*acos(y)))*(a*b*sin(a*y + 2*pi*sin(b/x)) + (2*a*pi*sin(a*acos(y)))/(1 - y^2)^(1/2))]