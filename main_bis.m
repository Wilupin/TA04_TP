clear all

% Initialisation des constantes du probl?me 
c        = 3*10.0^8;     % Celerite des ondes
f        = 2*c;          % Frequence
k        = (2*pi*f)/c;   % Nombre d'onde
lambda   = c/f;          % Longueur d'onde
nlambda  = 5;            % Densite de points par longueur d'onde

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


% On commence a compter le temps a partir d'ici
disp('Debut de la multiplication matrice-vecteur')

% Calcul des contribution des cases eloignees
Res = green_approx_bis(coord,partition,rho,k,theta,omega_theta,phi,omega_phi,L,N);
    

% Cette partie fonctionne bien on n'y touche plus
% On reparcourt une fois l'ensemble des cases
for p1=1:partition.nb_part_nv
    
    % On s'interesse cette fois ci aux cases voisines
    for p2=p1:partition.nb_part_nv
        if(partition.liste_voisins(p1,p2) > 0)
            
            for l1=1:partition.size_box(p1)
                for l2=1:partition.size_box(p2)
                    
                    if (partition.points_box(p1,l1) ~= partition.points_box(p2,l2))
                        
                        x = coord(partition.points_box(p1,l1),:);
                        y = coord(partition.points_box(p2,l2),:);
                        normXY = sqrt((x-y)*(x-y)');
                        
                        Res(partition.points_box(p1,l1)) = Res(partition.points_box(p1,l1)) + ...
                            (exp(1i*k*normXY)/normXY)*rho(partition.points_box(p2,l2));
                        
                        if(p2 ~= p1)
                            
                            Res(partition.points_box(p2,l2)) = Res(partition.points_box(p2,l2)) + ...
                                (exp(1i*k*normXY)/normXY)*rho(partition.points_box(p1,l1));
                            
                        end
                    end
                end
            end
            
        end
    end
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






