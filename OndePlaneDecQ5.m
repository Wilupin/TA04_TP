%clear all; 
 
c = 3*10.0^8;
f = 2*c;
k = (2*pi*f)/c;

L = 20;

[theta, omega, phi, omega_phi] = quadrature(L);

x = [0.2 0.2 0.2];
y = [0.4 0.5 0.6];

x0 = [0    0    0];
y0 = [0.5    0.5    0.5];

normXY = sqrt((x-y)*(x-y)');

exp(i*k*normXY)/normXY

G_res = ondesPlanes(x,y,x0,y0,k,theta, omega, phi, omega_phi,L);


G_res