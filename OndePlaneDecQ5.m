%clear all; 
 
c = 3*10.0^8;
f = 2*c;
k = (2*pi*f)/c;

L = 50;

[theta, omega, phi, omega_phi] = quadrature(L);

x = [0.1 0.1 0.1];
y = [0.5 0 0.3];

x0 = [0    0    0];
y0 = [1    0.5    0.5];

normXY = sqrt((x-y)*(x-y)');
normX  = sqrt((x-x0)*(x-x0)');
normY  = sqrt((y-y0)*(y-y0)');
G = exp(i*k*normXY)/normXY;

G_res = ondesPlanes(x,y,x0,y0,k,theta, omega, phi, omega_phi,L);

eps = abs(G-G_res)/abs(G);

disp([ '4$\pi$ & $', num2str(L), '$ & $' num2str(normX), '$ & $', num2str(normY), '$ & $',num2str(G), '$ & $', num2str(G_res), '$ & $', num2str(floor(eps*100)), '$ \\']);


