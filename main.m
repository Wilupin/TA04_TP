clear all; 

% Initialisation des constantes du probl?me 
c        = 3*10.0^8;     % C?l?rit? des ondes
f        = 2*c;          % Frequence
k        = (2*pi*f)/c;   % Nombre d'onde
lambda   = c/f;          % Longueur d'onde
nlambda  = 10;            % Densit? de points par longueur d'onde

L = 6;


% R?cup?ration des coordonn?es des points du maillage
[coord, N] = Maillage(nlambda,f);

% Cr?ation du vecteur de test de la bonne taille
rho = ones(N,1);

% R?cup?ration des points de quadrature
[theta, omega_theta, phi, omega_phi] = quadrature(L);

% R?cup?ration du partitionement
% Attention partition est une structure de donn?es
partition = buildOctree_bis(coord, N, lambda);

% Allocation du vecteur r?sultats
Res = zeros(N,1);

% On commence ? compter le temps ? partir d'ici
disp('Debut de la multiplication matrice-vecteur')
tic

% Boucle sur les les points pour calculer les contribution des ?l?ments
% lointains de notre probl?me, hors voisinage.
for q=1:N
    q
    q1 = partition.label_box(q);
    G = 0; 
    for p=1:partition.nb_part_nv
        if(partition.liste_voisins(q1,p) == 0)
            for j=1:partition.size_box(p)
                G = G + green_approx(coord(q,:), coord(partition.points_box(j),:),...
                    partition.coords_box(p,:), partition.coords_box(q1,:), ...
                    k,theta, omega_theta, phi, omega_phi,L)*rho(partition.points_box(j));
            end
        else 
            for j=1:partition.size_box(p)
                x = coord(q,:);
                y = coord(partition.points_box(j),:);
                normXY = sqrt((x-y)*(x-y)');
                G = G + exp(1i*k*normXY)/normXY;
            end
        end
    end
    Res(q) = G;
end





