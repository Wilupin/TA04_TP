clear all; 

% Initialisation des constantes du probl?me 
c        = 3*10.0^8;     % C?l?rit? des ondes
f        = 2*c;          % Frequence
k        = (2*pi*f)/c;   % Nombre d'onde
lambda   = c/f;          % Longueur d'onde
nlambda  = 5;            % Densit? de points par longueur d'onde

L = 10;


% Recuperation des coordonnees des points du maillage
[coord, N] = Maillage(nlambda,f);

% Creation du vecteur de test de la bonne taille
rho = ones(N,1);

% Recuperation des points de quadrature
[theta, omega_theta, phi, omega_phi] = quadrature(L);

% Recuperation du partitionement
% Attention partition est une structure de donnees
partition = buildOctree_bis(coord, N, lambda);

% Allocation du vecteur r?sultats
Res = zeros(N,1);

% On commence a compter le temps a partir d'ici
disp('Debut de la multiplication matrice-vecteur')
tic

% Boucle sur les les points pour calculer les contribution des elements
% lointains de notre probleme, hors voisinage.
for q=1:N
    q
    % Partition dans laquelle appartient q
    q1 = partition.label_box(q);
    G = 0; 
    for p=1:partition.nb_part_nv
        G = G + green_approx_bis(coord, partition, q1, q, rho, k,theta,omega_theta, phi,omega_phi,L);
       if(partition.liste_voisins(q1,p) == 0)
            for j=1:partition.size_box(p)
                if (q ~= partition.points_box(p,j))
                    x = coord(q,:);
                    y = coord(partition.points_box(p,j),:);
                    normXY = sqrt((x-y)*(x-y)');
                    G = G + (exp(1i*k*normXY)/normXY)*rho(partition.points_box(p,j));
                end
            end
        end
    end
    Res(q) = G;
end



% Comparaison avec la valeur calculee directement

% Difference selon x
[a,b] = meshgrid(coord(:,1), coord(:,1));
diff_x = a-b;

% Difference selon y
[a,b] = meshgrid(coord(:,2), coord(:,2));
diff_y = a-b;

% Difference selon z
[a,b] = meshgrid(coord(:,3), coord(:,3));
diff_z = a-b;

% Difference selon y
G_tot = sqrt(diff_x.^2 + diff_y.^2 +diff_z.^2);
G_tot = G_tot + eye(size(G_tot));

G_tot = exp(1i*k*G_tot)./G_tot;
G_tot = G_tot - diag(diag(G_tot));


% produit matrice vecteur
V = G_tot*rho;






