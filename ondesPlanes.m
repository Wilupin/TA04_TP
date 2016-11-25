function G_res = ondesPlanes(x,y,x0,y0,k)

% x et y sont des vecteurs
r0 = x0 - y0;
normR0 = sqrt(r0*r0');


% Assemblage de la matrice T
L = 4;
%L = floor(sqrt(3)*k*0.15 + 10*log(sqrt(3)*k*0.15+pi))+1;
T = zeros(L+1,L+1);

for jj = 1:L
    T(jj,jj+1) = jj/sqrt(4*(jj^2)-1);
    T(jj+1,jj) = T(jj,jj+1);
end


% Calcul des valeurs propres et des vecteurs propres
[EigVec, EigVal] = eig(T);


theta         = acos(diag(EigVal));
omega         = 2*(EigVec(1,:)).^2;

phi           = linspace(0,2*pi,2*L+2);
omega_phi     = 2*pi/(2*L+1);

phi(end) = [];


G_res = 0;

hank = hankel(L,k*normR0);

for j=1:L+1
    
    G = 0;
    
    s = [sin(theta(j))*cos(phi(:)).';  ...
        sin(theta(j))*sin(phi(:)).' ; ...
        cos(theta(j))*ones(2*L+1,1).'];
    
    for p=0:L
        G = G + (2*p+1)*(1i^p)*hank(p+1)*legendreP(p, (s(1,:)*r0(1) +...
            s(2,:)*r0(2) + s(3,:)*r0(3))./normR0);
    end
    
    G = G.*(1i*k/(4*pi));
   
    G = G.*exp(-1i*k*(s(1,:)*(y(1)-y0(1)) + s(2,:)*(y(2)-y0(2)) + s(3,:)*(y(3)-y0(3))));  
    G = G.*exp(+1i*k*(s(1,:)*(x(1)-x0(1)) + s(2,:)*(x(2)-x0(2)) + s(3,:)*(x(3)-x0(3))));
    
    G_res = G_res + sum(G(:))*omega(j);

           
end

G_res = G_res*omega_phi;


%func = @(t,ph) myFunction_bis(t,ph,L,r0,normR0,k);
%res = integral2(func,0,pi,0,2*pi)
    


end

