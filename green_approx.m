function G_res = green_approx(x,y,x0,y0,k,theta,omega_theta,phi,omega_phi,L)

r0 = x0 - y0;
normR0 = sqrt(r0*r0');

hank = hankel(L,k*normR0);

G_res = 0;

for j=1:L+1
    
    G = 0;
    
    s = [sin(theta(j))*cos(phi(:)).'; ...
        sin(theta(j))*sin(phi(:)).' ; ...
        cos(theta(j))*ones(2*L+1,1).'];
    
    for p=0:L
        G = G + (2*p+1)*(1i^p)*hank(p+1)*legendreP(p, (s(1,:)*r0(1) +...
            s(2,:)*r0(2) + s(3,:)*r0(3))./normR0);
    end
    
    G = G.*(1i*k/(4*pi));
   
    G = G.*exp(-1i*k*(s(1,:)*(y(1)-y0(1)) + s(2,:)*(y(2)-y0(2)) + s(3,:)*(y(3)-y0(3))));  
    G = G.*exp(+1i*k*(s(1,:)*(x(1)-x0(1)) + s(2,:)*(x(2)-x0(2)) + s(3,:)*(x(3)-x0(3))));
    
    G_res = G_res + sum(G(:))*omega_theta(j);
    
end

G_res = G_res*omega_phi;


end

