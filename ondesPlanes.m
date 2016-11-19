function G_res = ondesPlanes(x,y,x0,y0,k)

% x et y sont des vecteurs
r0 = x0 - y0;

% Assemblage de la matrice T
L = 4;
%L = floor(sqrt(3)*k*0.15 + 10*log(sqrt(3)*k*0.15+pi))+1;
T = zeros(L+1,L+1);

for j = 1:L
    T(j,j+1) = j/sqrt(4*(j^2)-1);
    T(j+1,j) = T(j,j+1);
end

% Calcul des valeurs propres et des vecteurs propres
[EigVec, EigVal] = eig(T);

theta         = acos(diag(EigVal));
omega         = 2*(EigVec(1,:)).^2;

phi           = linspace(0,2*pi,2*L+2);
omega_phi     = 2*pi/(2*L+1);

phi(end) = [];


normR0 = sqrt(sum(r0(:).^2));

G_res = 0;


for j=1:(L+1)
    
    G = 0;
    
    for p=0:L
        Pol(:) = legendreP(p, (sin(theta(j))*cos(phi(:))*r0(1) +...
            sin(theta(j))*sin(phi(:))*r0(2) + ...
            cos(theta(j))*r0(3) )./normR0);
        
        G = G + (2*p+1)*(i^p)*besselh(p,1,k*normR0)*Pol(:);
    end
    
    G = (i*k/(4*pi))*G;
    
    
    G = G.*exp(i*k*(sin(theta(j))*cos(phi(:)).*(y(1)-y0(1)) + ...
        sin(theta(j)).*sin(phi(:))*(y(2)-y0(2)) + ...
        cos(theta(j))*(y(3)-y0(3))));
    
    G = G.*exp(-i*k*(sin(theta(j))*cos(phi(:))*(x(1)-x0(1)) + ...
        sin(theta(j))*sin(phi(:))*(x(2)-x0(2)) + ...
        cos(theta(j))*(x(3)-x0(3))));
    
    
    G_res = G_res + sum(G(:)*omega_phi)*omega(j);
    
end


%func = @(t,ph) myFunction_bis(t,ph,L,r0,normR0,k);
%res = integral2(func,0,pi,0,2*pi)
    


end

