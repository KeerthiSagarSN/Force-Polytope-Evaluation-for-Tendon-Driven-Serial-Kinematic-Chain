% A=[0.1170 0.0199;
%     0.0199 0.0658];
% theta=(0:0.01:2*pi);
% x=[cos(theta); sin(theta)];
% r=sqrt(diag(x'*A*x));
% hold on
% plot(x(1,:)./r', x(2,:)./r' )
% hold off

% Matlab script gg303_lab_09_example_V
function [M,CN] = eigellivv(A,e_x,e_y)
%A=[-0.1139 0.0188;
 %    0.0188 -0.0647];
%A = [2 1;1 1];
k_scale = 1;
a = A(1,1); b = A(1,2); c = A(2,1); d = A(2,2);
theta = 0:2*pi/360:2*pi;
x = k_scale*cos(theta); y = k_scale*sin(theta); % coordinates of pts. on unit
%circle
X = [x;y];
Xp = A*X; % Xp represents X' in the notes
xp = e_x+Xp(1,:); yp = e_y+Xp(2,:);
% Find matrix of eigenvectors (vA) and eigenvalues (dA)
[vA,dA] = eig(A);
va=vA(:,1);
vb=vA(:,2);
la=dA(1,1);
lb=dA(2,2);
% Find indices for the maximum and minimum eigenvalues
[i,j] = find(dA == max(dA(1,1),dA(2,2))); % maximum
[k,l] = find(dA == min(dA(1,1),dA(2,2))); % minimum
eig_max = max(dA(1,1),dA(2,2));
eig_min = min(dA(1,1),dA(2,2));
% Plot ellipse and its major and minor semi-axes
%plot(xp,yp); % ellipse
% plot
%hold on
% Commented below
%quiver(e_x,e_y,va(1)*la/(norm(va)),va(2)*la/(norm(va)),0), quiver(e_x,e_y,vb(1)*lb/(norm(vb)),vb(2)*lb/norm(vb),0) %% take the unit vector to fit the quiver , multiply by eigenvalue/ norm
% plot(dA(j,j)*[e_x,vA(1,j)],dA(j,j)*[e_y,vA(2,j)],'--'); % major semiaxis (x')
% plot(dA(l,l)*[e_x,vA(1,l)],dA(l,l)*[e_y,vA(2,l)],'r'); % minor semiaxis (y')
%  plot(dA(j,j)*[0,vA(1,j)],dA(j,j)*[0,vA(2,j)],'--'); % major semiaxis (x')
%  plot(dA(l,l)*[0,vA(1,l)],dA(l,l)*[0,vA(2,l)],'r'); % minor semiaxis (y')
%hold off
%axis equal;
%xlabel('x'); ylabel('y')
%title ('Hand stiffness ellipse during postural task')
% Find orientation, in degrees, of major semi-axis
%theta_xxp = simplify(mod(atan2(vA(2,j),vA(1,j))*180/pi,180))

M = (eig_max^2*eig_min^2)/(eig_max^2+eig_min^2);
CN = eig_max/eig_min;
end