function G_res = ondesPlanes(x,y,x0,y0,k,theta,omega, phi, omega_phi,L)

% x et y sont des vecteurs
r0 = x0 - y0;
normR0 = sqrt(r0*r0');

hank = hankel(L,k*normR0);
vec  = zeros(L,1);

G_res = 0;

for p=0:L
    vec(p+1) = (2*p+1)*1i^p;
end 

for j=1:L+1
    
    s = [sin(theta(j))*cos(phi(:)).';  ...
        sin(theta(j))*sin(phi(:)).' ; ...
        cos(theta(j))*ones(2*L+1,1).'];
    
    leg = my_legendre(L, (s(1,:)*r0(1) + ...
            s(2,:)*r0(2) + s(3,:)*r0(3))./normR0);
    
    G = sum(bsxfun(@times,vec(:).*hank(:),leg(:,:)));
    G = G.*exp(-1i*k*(s(1,:)*(y(1)-y0(1)) + s(2,:)*(y(2)-y0(2)) + s(3,:)*(y(3)-y0(3))));  
    G = G.*exp(+1i*k*(s(1,:)*(x(1)-x0(1)) + s(2,:)*(x(2)-x0(2)) + s(3,:)*(x(3)-x0(3))));
    
    G_res = G_res + sum(G(:))*omega(j);           
end

G_res = G_res*omega_phi.*(1i*k/(4*pi));
    


end

