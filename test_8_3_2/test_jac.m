clc
clear
syms x y z x1 y1 z1 a b c pi

    % x1=cos(a*z+2*pi*(4/c*(sin(pi*x))));
    % y1=sin(b*x1-2*pi*(b*y*(1-y)));
    % z1=cos(c*y1+2*pi*(a*acos(z)));
    x1=cos(a*z+2*pi*(4/c*(sin(pi*x))));
    y1=sin(b*x1-2*pi*(b*y*(1-y)));
    z1=cos(c*y1+2*pi*(a*acos(z)));

  jacobian([x1;y1;z1],[x y z])
  %% 
% ans =
% 
% [                                                                                                                                     -(8*pi^2*sin(a*z + (8*pi*sin(pi*x))/c)*cos(pi*x))/c,                                                                                                                                                                      0,                                                                                                                                                                         -a*sin(a*z + (8*pi*sin(pi*x))/c)]
% [                                                                           -(8*b*pi^2*cos(b*cos(a*z + (8*pi*sin(pi*x))/c) + 2*b*pi*y*(y - 1))*sin(a*z + (8*pi*sin(pi*x))/c)*cos(pi*x))/c,                                                                                    cos(b*cos(a*z + (8*pi*sin(pi*x))/c) + 2*b*pi*y*(y - 1))*(2*b*pi*(y - 1) + 2*b*pi*y),                                                                                                               -a*b*cos(b*cos(a*z + (8*pi*sin(pi*x))/c) + 2*b*pi*y*(y - 1))*sin(a*z + (8*pi*sin(pi*x))/c)]
% [8*b*pi^2*sin(c*sin(b*cos(a*z + (8*pi*sin(pi*x))/c) + 2*b*pi*y*(y - 1)) + 2*a*pi*acos(z))*cos(b*cos(a*z + (8*pi*sin(pi*x))/c) + 2*b*pi*y*(y - 1))*sin(a*z + (8*pi*sin(pi*x))/c)*cos(pi*x), -c*sin(c*sin(b*cos(a*z + (8*pi*sin(pi*x))/c) + 2*b*pi*y*(y - 1)) + 2*a*pi*acos(z))*cos(b*cos(a*z + (8*pi*sin(pi*x))/c) + 2*b*pi*y*(y - 1))*(2*b*pi*(y - 1) + 2*b*pi*y), sin(c*sin(b*cos(a*z + (8*pi*sin(pi*x))/c) + 2*b*pi*y*(y - 1)) + 2*a*pi*acos(z))*((2*a*pi)/(1 - z^2)^(1/2) + a*b*c*cos(b*cos(a*z + (8*pi*sin(pi*x))/c) + 2*b*pi*y*(y - 1))*sin(a*z + (8*pi*sin(pi*x))/c))]
% 