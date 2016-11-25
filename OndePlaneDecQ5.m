clear all; 

c = 3*10.0^8;
f = 2*c;
k = (2*pi*f)/c;

x = [0 0 0];
y = [1 0.3 0.3];

x0 = [0 0 0];
y0 = [1 0.3 0.3];

normXY = sqrt((x-y)*(x-y)');

exp(i*k*normXY)/normXY

G_res = ondesPlanes(x,y,x0,y0,k);

G_res