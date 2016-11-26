%clear all; 
 
c = 3*10.0^8;
f = 2*c;
k = (2*pi*f)/c;

L = 10;

[theta, omega, phi, omega_phi] = quadrature(L);

x = [0 0 0];
y = [0 0 0.300];

x0 = [0.0750    0.0750    0.0750];
y0 = [0.0750    0.0750    0.3750];

normXY = sqrt((x-y)*(x-y)');

exp(i*k*normXY)/normXY

%G_res = ondesPlanes(x,y,x0,y0,k,theta, omega, phi, omega_phi,L);
G_res = ondesPlanes(coord(q,:), coord(partition.points_box(3,1),:),...
                   partition.coords_box(q1,:),  partition.coords_box(3,:), ...
                    k,theta, omega_theta, phi, omega_phi,L)*rho(partition.points_box(3,1))

G_res