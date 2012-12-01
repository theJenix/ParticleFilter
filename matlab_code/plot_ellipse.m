function [x,y] = plot_ellipse(x_c,y_c,a,b,a_theta)
t = linspace(0,2*pi,1000);
x = x_c + a*cos(t)*cos(a_theta) - b*sin(t)*sin(a_theta);
y = y_c + a*cos(t)*sin(a_theta) + b*sin(t)*cos(a_theta);
