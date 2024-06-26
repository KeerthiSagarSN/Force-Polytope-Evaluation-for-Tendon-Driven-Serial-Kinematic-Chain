clc

% Setting path to search functions
% A script for path set
% 1: set Matlab path
%PlanPATH = [pwd,'/',mfilename];
%addpath(path, PlanPATH);

%p_path = [PlanPATH 'Zonotopes-master'];
%addpath(path, p_path);



syms theta_a theta_b r_a r_b X Y
syms q1 q2 q3 q4 q5 q6 

%% initialization and declaration (units in m)
L1=0.315; L2=0.234;
b1=10e-3; b2=10e-3; b3=10e-3; b4=10e-3;
d1=20e-3; d2=20e-3; d3=20e-3; d4=20e-3;
h1=70e-3; h2=70e-3; h3=70e-3; h4=70e-3;
u1=70e-3; u2=70e-3; u3=70e-3; u4=70e-3;
s1=10e-3; s2=10e-3; s3=0; s4=0;
z= [theta_a theta_b r_a r_b]';
q=[q1 q2 q3 q4 q5 q6]';
% cos sin
Ca= cos(theta_a);
Cb= cos(theta_b);
Sa= sin(theta_a);
Sb= sin(theta_b);
Cab=Ca*Cb-Sa*Sb;
Sab=Sa*Cb+Ca*Sb;
%% Kinematics of biarticular
q1= sqrt((h1+r_a*Ca-s1*Sa)^2+(d1-r_a*Sa-s1*Ca)^2);
q2= sqrt((h2-r_b*Ca-s2*Sa)^2+(d2-r_b*Sa+s2*Ca)^2);
q3= sqrt((h3+(L1-r_a)*Cb-s3*Sb)^2+(d3-(L1-r_a)*Sb-s3*Cb)^2);
q4= sqrt((h4-(L1-r_b)*Cb-s4*Sb)^2+(d4-(L1-r_b)*Sb+s4*Cb)^2);
q5= sqrt((u1-L1*Ca+u3*Cab-b3*Sab)^2+(b1-L1*Sa-u3*Sab-b3*Cab)^2);
q6= sqrt((u2-L1*Ca+u4*Cab+b4*Sab)^2+(b2-L1*Sa+u4*Sab-b4*Cab)^2);

%%% Changing here for Force polytope  - No negative sign required for the
%%% force polytope also differentation w.r.t to r_a and r_b not required as
%%% the pivot points are not moving but in a fixed position
%W= - transpose(jacobian([q1,q2,q3,q4,q5,q6] ,[theta_a,theta_b,r_a,r_b]));

W= transpose(jacobian([q1,q2,q3,q4,q5,q6],[theta_a,theta_b]));



%% End-point space and wire space
X=L1*Ca+L2*Cab;

Y=L1*Sa+L2*Sab;

x=[X Y]';
J= jacobian([X,Y],[theta_a,theta_b]);



% Design parameters for the analytic function
%% test with thetas
 theta_a= pi/2;
 theta_b=pi/6;
%% holding the tool tip, posture fixed, find the angles (IK)
% r_a=0.15;
% r_b=0.15;
r_a=0.2;
r_b=0.1;

F_wire_max = [100;20;125;40;87;100];
F_wire_min = [23;23;23;12;15;100];
F_wire_third = F_wire_max/3.33;
F_wire_half = F_wire_max/2;
F_wire_fourth = F_wire_max/4;
Fe_min = double(vpa(subs(inv(transpose(J))*W*F_wire_min)))
Fe_max = double(vpa(subs(inv(transpose(J))*W*F_wire_max)))
Fe_third = double(vpa(subs(inv(transpose(J))*W*F_wire_third)))
Fe_half = double(vpa(subs(inv(transpose(J))*W*F_wire_half)))
Fe_fourth = double(vpa(subs(inv(transpose(J))*W*F_wire_fourth)))

% Force vertices as graph points to the Zonotope function to plot
G_Fe = [Fe_min(1) Fe_max(1) Fe_third(1) Fe_half(1) Fe_fourth(1);Fe_min(2) Fe_max(2) Fe_third(2) Fe_half(2) Fe_fourth(2)]


zonotope_2d_gen(G_Fe)

%% stiffness ellipsoid %%% COmmenting below for the force polytope
%k_wire=[0.2,0.2,0.2,0.2,0.2,0.2];
%Kw=diag(k_wire);
%Ke=-transpose(pinv(J))*W*Kw*transpose(W)*pinv(J);

 
 

%Xx=-0.3;
%Yy=0.3;
%theta_b=acos((Xx^2+Yy^2-L1^2-L2^2)/2*L1*L2);
%theta_a=simplify(vpa(subs(atan(Yy/Xx)-atan((L2*Sb)/(L1+L2*Cb)))));
%M = [];
%CN = [];
%M_fn = [];
%CN_fn = [];
%I = [];
%J = [];

% for i=-0.50:0.1:0.50
%      for j =-0.50:0.1:0.50

        %for j=1: length(Xx)
            %for j=9
% for teta_a = 1:1:110
%     for teta_b = 1:1:150
%         
%         i = simplify(vpa(subs(L1*cosd(teta_a)+L2*cosd(teta_a+teta_b))));
%         I = [I,i];
%         
%         j = simplify(vpa(subs(L1*sind(teta_a)+L2*cosd(teta_a+teta_b))));
%         J = [J,j];
%         theta_a = teta_a;
%         theta_b = teta_b;
%         A=simplify(vpa(subs(Ke)));
%         %       plotcontourel(A,Xx(j),Yy(j))
%         [M_fn,CN_fn] = eigellivv(A,X,Y);
%         %disp('I am here');
%         %M = [M,M_fn]
%         CN = [CN,CN_fn];
%         M = [M,M_fn];
%             
%     end
% end
%plotcontourel(A)


%save('CN_Biart.mat')




