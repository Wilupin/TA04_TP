function Res_int = intHarm(l,m)

% Assemblage de la matrice T
L = 4;
T      = zeros(L+1,L+1);


for j = 1:L
    T(j,j+1) = j/sqrt(4*(j^2)-1);
    T(j+1,j) = T(j,j+1);
end

% On definit la matrice sparse
T = sparse(T);


% Calcul des valeurs propres et des vecteurs propres
[EigVec, EigVal] = eigs(T);

lambda        = diag(EigVal);
omega         = 2*(EigVec(1,:)).^2;

phi           = linspace(0,2*pi,2*L+2);
omega_phi     = 2*pi/(2*L+1);

P = legendre(l,lambda(:));

if m >= 0 
    Res_int = sum(P(m+1,:)'.*omega(:))*sum(exp(i*m*phi(1:end-1))*omega_phi);
    Res_int = (sqrt((2*l+1)*factorial(l-m))/sqrt(4*pi*factorial(l+m)))*Res_int;
else 
    Res_int = sum(P(abs(m)+1,:)'.*omega(:))*sum(exp(i*m*phi(1:end-1))*omega_phi);
    Res_int = (((-1)^m)*sqrt((2*l+1)*factorial(l-abs(m)))/sqrt(4*pi*factorial(l+abs(m))))*Res_int;
end

