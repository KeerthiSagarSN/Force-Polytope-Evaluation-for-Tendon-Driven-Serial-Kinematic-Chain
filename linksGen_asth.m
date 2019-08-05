%% Link given two points A and B
clear all;close all;clc
% input parameters
A=[0,0];
B=[10,10];
thickness = 2;

r = thickness/2;




figure
circle(A,r);
circle(B,r);
parallelLines(A,B,r);
%% Local functions
function circle(origin, radius)
theta = linspace( -pi, pi, 100);
cx = origin(1) + radius*cos(theta);
cy = origin(2) + radius*sin(theta);
hold on;
plot(cx,cy,'b');hold on;
plot(origin(1),origin(2),'ro');hold on;
end



function parallelLines(A,B,radius)
x1 = A(1); y1 = A(2); x2 = B(1); y2 = B(2);  
ABup_x = linspace(x1,x2,100);
ABup_y = linspace(y1+radius,y2+radius,100);
ABdown_x = linspace(x1,x2,100);
ABdown_y = linspace(y1-radius,y2-radius,100);
hold on;
plot(ABup_x,ABup_y,'b'); hold on;
plot(ABdown_x,ABdown_y,'b'); hold on;
end



