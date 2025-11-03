%% luchengcheng'
clc
clear 
clc
close all
syms x y a b  pi
%      x(n+1)=cos(a*y(n)+2*pi*(b*x(n)*(1-x(n)^2)));
%  y(n+1)=sin(b*x(n+1)-2*pi*(a-y(n)^2));
    x1=cos(a*y+2*pi*(b*x*(1-x)^2));
	y1=sin(b*x1-2*pi*(a-y^2));
    jac1=jacobian([x1;y1],[x y])
    %% 
% jac1 =
% 
% [                                                          -sin(a*y + 2*b*pi*x*(x - 1)^2)*(2*b*pi*(x - 1)^2 + 2*b*pi*x*(2*x - 2)),                                                                     -a*sin(a*y + 2*b*pi*x*(x - 1)^2)]
% [-b*cos(b*cos(a*y + 2*b*pi*x*(x - 1)^2) - 2*pi*(- y^2 + a))*sin(a*y + 2*b*pi*x*(x - 1)^2)*(2*b*pi*(x - 1)^2 + 2*b*pi*x*(2*x - 2)), cos(b*cos(a*y + 2*b*pi*x*(x - 1)^2) - 2*pi*(- y^2 + a))*(4*pi*y - a*b*sin(a*y + 2*b*pi*x*(x - 1)^2))]
% 