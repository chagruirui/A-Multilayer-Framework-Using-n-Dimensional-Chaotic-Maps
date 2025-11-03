clc
clear
syms x y z x1 y1 z1 a b c pi

    % x1=cos(a*z+2*pi*(c*x*(1-x^2)));
    % y1=sin(b*x1-2*pi*(b-y^2));
    % z1=cos(c*y1+2*pi*(sin(a/z)));
    x1=cos(a*z+2*pi*(c*x*(1-x^2)));
    y1=sin(b*x1-2*pi*(b-y^2));
    z1=cos(c*y1+2*pi*(sin(a/z)));
  jacobian([x1;y1;z1],[x y z])
  %% 
% ans =
% 
% [                                                                                                                                            sin(a*z - 2*c*pi*x*(x^2 - 1))*(4*c*pi*x^2 + 2*c*pi*(x^2 - 1)),                                                                                                                                                0,                                                                                                                                                                     -a*sin(a*z - 2*c*pi*x*(x^2 - 1))]
% [                                                                                  b*cos(b*cos(a*z - 2*c*pi*x*(x^2 - 1)) - 2*pi*(- y^2 + b))*sin(a*z - 2*c*pi*x*(x^2 - 1))*(4*c*pi*x^2 + 2*c*pi*(x^2 - 1)),                                                                                   4*pi*y*cos(b*cos(a*z - 2*c*pi*x*(x^2 - 1)) - 2*pi*(- y^2 + b)),                                                                                                           -a*b*cos(b*cos(a*z - 2*c*pi*x*(x^2 - 1)) - 2*pi*(- y^2 + b))*sin(a*z - 2*c*pi*x*(x^2 - 1))]
% [-b*c*cos(b*cos(a*z - 2*c*pi*x*(x^2 - 1)) - 2*pi*(- y^2 + b))*sin(2*pi*sin(a/z) + c*sin(b*cos(a*z - 2*c*pi*x*(x^2 - 1)) - 2*pi*(- y^2 + b)))*sin(a*z - 2*c*pi*x*(x^2 - 1))*(4*c*pi*x^2 + 2*c*pi*(x^2 - 1)), -4*c*pi*y*cos(b*cos(a*z - 2*c*pi*x*(x^2 - 1)) - 2*pi*(- y^2 + b))*sin(2*pi*sin(a/z) + c*sin(b*cos(a*z - 2*c*pi*x*(x^2 - 1)) - 2*pi*(- y^2 + b))), sin(2*pi*sin(a/z) + c*sin(b*cos(a*z - 2*c*pi*x*(x^2 - 1)) - 2*pi*(- y^2 + b)))*((2*a*pi*cos(a/z))/z^2 + a*b*c*cos(b*cos(a*z - 2*c*pi*x*(x^2 - 1)) - 2*pi*(- y^2 + b))*sin(a*z - 2*c*pi*x*(x^2 - 1)))]
% 