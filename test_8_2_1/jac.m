%% 
clc
clear 
clc
close all
syms x y a b  pi
	% x(n+1)=cos(a*y(n)+2*pi*(4/b*(sin(pi*x(n)))));
	% y(n+1)=sin(b*x(n+1)-2*pi*(a*y(n)*(1-y(n))));
 	x1=cos(a*y+2*pi*(4/b*(sin(pi*x))));
	y1=sin(b*x1-2*pi*(a*y*(1-y)));
    jac1=jacobian([x1;y1],[x y])
    %% 
% jac1 =
%  
% [                                                    -(8*pi^2*sin(a*y + (8*pi*sin(pi*x))/b)*cos(pi*x))/b,                                                                                        -a*sin(a*y + (8*pi*sin(pi*x))/b)]
% [-8*pi^2*cos(b*cos(a*y + (8*pi*sin(pi*x))/b) + 2*a*pi*y*(y - 1))*sin(a*y + (8*pi*sin(pi*x))/b)*cos(pi*x), cos(b*cos(a*y + (8*pi*sin(pi*x))/b) + 2*a*pi*y*(y - 1))*(2*a*pi*(y - 1) - a*b*sin(a*y + (8*pi*sin(pi*x))/b) + 2*a*pi*y)]
% 