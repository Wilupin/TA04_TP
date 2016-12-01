
% Initialisation des constantes du probl?me
c        = 3*10.0^8;     % Celerite des ondes
f        = 4*c;          % Frequence
k        = (2*pi*f)/c;   % Nombre d'onde
lambda   = c/f;          % Longueur d'onde
nlambda  = 5;            % Densite de points par longueur d'onde


d = 0.3*lambda;

L_opt = floor(sqrt(3)*k*d + 7.5*log(sqrt(3)*k*d + pi))


% Recuperation des coordonnees des points du maillage
[coord, N] = Maillage(nlambda,f);

% Creation du vecteur de test de la bonne taille
rho = ones(N,1);



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



for m = 2:30
    
    L(m) = m; 
    
    % Recuperation des points de quadrature
    [theta, omega_theta, phi, omega_phi] = quadrature(L(m));
    
    % Recuperation du partitionement
    % Attention partition est une structure de donnees
    partition = buildOctree_bis(coord, N, lambda);
    
    
    % On commence a compter le temps a partir d'ici
    disp('Debut de la multiplication matrice-vecteur')
    
    % Calcul des contribution des cases eloignees
    Res = green_approx_bis(coord,partition,rho,k,theta,omega_theta,phi,omega_phi,L(m),N);
    
    
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
    
    
    
    norm2(m) = 100*sqrt((Res-V)'*(Res-V))/sqrt(V'*V);
    normInf(m) = 100*max(abs(Res-V))/max(abs(V));
end



journal_plot_params; 

h_fig = setFigure('Figure');

h_plot = semilogy(L(1:end-2), 0.01*norm2(1:end-2), 'o'); 
set(h_plot, 'Color', 'blue'); 
set(h_plot, 'MarkerFaceColor', 'blue');
set(h_plot, 'MarkerSize', 4);

hold on 


h_p = semilogy(L(1:end-2), 0.01*normInf(1:end-2), 'x'); 
set(h_p, 'Color', 'red'); 
set(h_p, 'MarkerFaceColor', 'red');
set(h_p, 'MarkerSize', 4);

set(gca, 'ylim', [10^(-6.5) 10^(0.5)]);
set(gca, 'yTick',[0.000001 0.0001 0.01 1]);

journal_axis(gca,'$L_G$', '$\eta_{2/\infty}$');


