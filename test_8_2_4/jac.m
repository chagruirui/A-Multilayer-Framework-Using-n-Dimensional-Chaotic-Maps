%% luchengcheng'
clc
clear 
clc
close all
syms x y a b  pi
    % x(n+1)=cos(a*y(n)+2*pi*(b*x(n)*(1-x(n)^2)));
	% y(n+1)=sin(b*x(n+1)-2*pi*(1/y(n)^2+0.1-a*y(n)));
   x1=cos(a*y+2*pi*(b*x*(1-x^2)));
	y1=sin(b*x1-2*pi*(1/y^2+0.1-a*y));
    jac1=jacobian([x1;y1],[x y])
    %% 
% jac1 =
% 
% [                                                                   sin(a*y - 2*b*pi*x*(x^2 - 1))*(4*b*pi*x^2 + 2*b*pi*(x^2 - 1)),                                                                                        -a*sin(a*y - 2*b*pi*x*(x^2 - 1))]
% [b*cos(2*pi*(1/y^2 - a*y + 1/10) - b*cos(a*y - 2*b*pi*x*(x^2 - 1)))*sin(a*y - 2*b*pi*x*(x^2 - 1))*(4*b*pi*x^2 + 2*b*pi*(x^2 - 1)), cos(2*pi*(1/y^2 - a*y + 1/10) - b*cos(a*y - 2*b*pi*x*(x^2 - 1)))*(2*pi*(a + 2/y^3) - a*b*sin(a*y - 2*b*pi*x*(x^2 - 1)))]
% 