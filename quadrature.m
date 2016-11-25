function [theta, omega_theta, phi, omega_phi] = quadrature(L)


T = zeros(L+1,L+1);

for jj = 1:L
    T(jj,jj+1) = jj/sqrt(4*(jj^2)-1);
    T(jj+1,jj) = T(jj,jj+1);
end



% Calcul des valeurs propres et des vecteurs propres
[EigVec, EigVal] = eig(T);


theta         = acos(diag(EigVal));
omega_theta   = 2*(EigVec(1,:)).^2;

phi           = linspace(0,2*pi,2*L+2);
omega_phi     = 2*pi/(2*L+1);

phi(end) = [];


end

