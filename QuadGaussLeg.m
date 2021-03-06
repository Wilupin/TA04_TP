clear all; 


% Assemblage de la matrice T
L = 3; 

T      = zeros(L,L);
omega  = zeros(L,1);
theta = zeros(L,1); 

for j = 1:(L-1)
    T(j,j+1) = j/sqrt(4*(j^2)-1);
    T(j+1,j) = T(j,j+1);
end

% On definit la matrice sparse
T = sparse(T);


% Calcul des valeurs propres et des vecteurs propres
[EigVec, EigVal] = eigs(T);

theta   = acos(diag(EigVal));
lambda  = diag(EigVal);
omega   = 2*(EigVec(1,:)).^2;


% Comparaison avec les formules de la seance 1
P = @(x) myFunction(x);

myInt     = sum(P(lambda(:)).*omega(:));
matlabInt = integral(P,-1,1);
myOldInt  = (1/3)*(P(-1)+P(1))+(4/3)*P(0);


% Calcul des erreurs relatives
myEr = abs((myInt-matlabInt)/matlabInt);
myOldEr = abs((myOldInt-matlabInt)/matlabInt);


disp(['L integrale vaut avec notre quadrature       : ', num2str(myInt), ' | Er : ', num2str(myEr)]);
disp(['L integrale vaut avec la quadrature seance 1 : ', num2str(myOldInt), ' | Er : ', num2str(myOldEr)]);
disp(['L integrale vaut avec la fonction de matlab  : ', num2str(matlabInt)]);


