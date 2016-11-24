x = 1:0.1:10;
z = exp(i*x)./(i*x);

plot(x,imag(z), 'o');
hold on
plot(x, imag(hankel(0,x)), '--');
hold on
plot(x,real(z), 'o');
hold on
plot(x, real(hankel(0,x)), '--');