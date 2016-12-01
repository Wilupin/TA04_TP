%clear all; 
 
c = 3*10.0^8;
f = 2*c;
k = (2*pi*f)/c;

L = 2;

[theta, omega, phi, omega_phi] = quadrature(L);

x = [0 0 0];
y = [1.5 0.5 0.5];

x0 = [0    0    0];
y0 = [1.5    0.5    0.5];

normXY = sqrt((x-y)*(x-y)');

G = exp(i*k*normXY)/normXY;

G_res = ondesPlanes(x,y,x0,y0,k,theta, omega, phi, omega_phi,L);

eps = abs(G-G_res)/abs(G);

disp([num2str(G), '   ', num2str(G_res), '   ', num2str(eps)]);


