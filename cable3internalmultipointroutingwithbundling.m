clc
syms theta_a theta_b r_a r_b X Y qc1 qc2 qc3 ra1 ra2
syms L1 L2 b1 b2 b3 b4 d1 d2 d3 d4 h1 h2 h3 h4 u1 u2 u3 u4 s1 s2 s3 s4 s5 s11 s12 t1
%syms q1 q2 q3 q4 q5 q6 qc1 qc2 qc3

%% initialization and declaration (units in m)
L1=0.315; L2=0.234;
b1=10e-3; b2=10e-3; b3=10e-3; b4=10e-3;
d1=20e-3; d2=20e-3; d3=20e-3; d4=20e-3;
m1=0; m2=0;
p1=0; p2=0;
h1=70e-3; h2=70e-3; h3=70e-3; h4=70e-3;
u1=70e-3; u2=70e-3; u3=70e-3; u4=70e-3;
s1=10e-3; s2=10e-3; s3=10e-3; s4=10e-3; s5=10e-3; s11=10e-3; s12=10e-3;
z= [theta_a theta_b]'; % removed ra and rb
q=[qc1 qc2 qc3]';
% cos sin
Ca= cos(theta_a);
Cb= cos(theta_b);
Sa= sin(theta_a);
Sb= sin(theta_b);
Cab=Ca*Cb-Sa*Sb;
Sab=Sa*Cb+Ca*Sb;
%% Kinematics of biarticular
%In the paper the variables are changed, the map is given by h1=a;u=b1;
%=e;d=m;b=p; e11 is the split attachment point/ first internal routing.
%in the code we use h,s...
%point
% 3 muscle it is not general case as we need to add the offset at the base
% with proper variable
q11= sqrt((h1+(ra1-t1)*Ca-s12*Sa)^2+((ra1-t1)*Sa+s12*Ca-m1)^2);
q1int_0=sqrt((t1*Ca+s11*Sa+s12*Sa)^2+(t1*Sa-s11*Ca-s12*Ca)^2);
q1int_1= sqrt((-h1+ra2*Ca+s11*Sa+s1*Sa)^2+(ra2*Sa-s11*Ca-s1*Ca-m1)^2);
q12= sqrt((d1*Ca+ s1*Sa+ r_b*Cab-s4*Sab)^2+(d1*Sa-s1*Ca+ r_b*Sab + s4*Cab)^2);
q2= sqrt((-h2+r_a*Ca+s11*Sa)^2+(-m2+r_a*Sa-s11*Ca)^2);
q3= sqrt((u1+r_a*Ca-s1*Sa)^2+(-p1+r_a*Sa+(s12)*Ca)^2);
%q4= sqrt((d1*Ca+ s1*Sa+ r_b*Cab-s4*Sab)^2+(d1*Sa-s1*Ca+ r_b*Sab + s4*Cab)^2);
q5= sqrt((d1*Ca- s11*Sa+ r_b*Cab+s3*Sab)^2+(d1*Sa+s11*Ca+ r_b*Sab - s3*Cab)^2);
qc1=q11+q12+q1int_0+q1int_1;
qc2=q2+q5;
qc3=q3;
% char1=latex(q5)
W= - transpose(jacobian([qc1 qc2 qc3] ,[theta_a,theta_b]))
%% End-point space and wire space
X=L1*Ca+L2*Cab;
Y=L1*Sa+L2*Sab;
x=[X Y]';
J= jacobian([X,Y],[theta_a,theta_b]);
%% stiffness ellipsoid
k_wire=[0.2,0.2,0.2];
Kw=diag(k_wire);
Ke=-transpose(pinv(J))*W*Kw*transpose(W)*pinv(J);
%% test with thetas
% theta_a= pi/2;
% theta_b=pi/6;
%% holding the tool tip, posture fixed, find the angles (IK)
r_a=0.2;
ra1=(r_a/2);
ra2=(r_a/2);
t1=ra1/2;
r_a=ra1+ra2;
r_b=0.1;
%Xx=-0.3;
%Yy=0.3;
%theta_b=acos((Xx^2+Yy^2-L1^2-L2^2)/2*L1*L2);
%theta_a=simplify(vpa(subs(atan(Yy/Xx)-atan((L2*Sb)/(L1+L2*Cb)))));
M = [];
CN = [];
M_fn = [];
CN_fn = [];
I = [];
J = [];

% for i=-0.50:0.1:0.50
%      for j =-0.50:0.1:0.50

        %for j=1: length(Xx)
            %for j=9
for teta_a = 1:5:110
    for teta_b = 1:5:150
        
        i = simplify(vpa(subs(L1*cosd(teta_a)+L2*cosd(teta_a+teta_b))));
        I = [I,i];
        
        j = simplify(vpa(subs(L1*sind(teta_a)+L2*sind(teta_a+teta_b))));
        J = [J,j];
        theta_a = teta_a;
        theta_b = teta_b;
        A=simplify(vpa(subs(Ke)));
        %       plotcontourel(A,Xx(j),Yy(j))
        [M_fn,CN_fn] = eigellivv(A,X,Y);
        %disp('I am here');
        %M = [M,M_fn]
        CN = [CN,CN_fn];
        M = [M,M_fn];
            
    end
end
%plotcontourel(A)


save('CN_cable3internalmultipointroutingwithbundling.mat')