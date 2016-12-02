clear all

% Force le code a ne s'executer que sur un seul processeur 
%maxNumCompThreads(1)

% Initialisation des constantes du probleme
c        = 3*10.0^8;     % Celerite des ondes
nlambda  = 10;           % Densite de points par longueur d'onde

L = 15;

journal_plot_params

Num_points = 75; 

for m=20:(20+Num_points-1)
    
    disp(' ');
    disp(['Calcul pour m = ', num2str(m)]);
        
    f = 0.1*m*c; 
    
    disp(['-> f = ', num2str(f)]);
    
    k        = (2*pi*f)/c;   % Nombre d'onde
    lambda   = c/f;          % Longueur d'onde
    
    % Recuperation des coordonnees des points du maillage
    [coord, N(m)] = Maillage(nlambda,f);
    
    disp(['-> N = ', num2str(N(m))]);
    
    % Creation du vecteur de test de la bonne taille
    rho = ones(N(m),1);
    
    % Recuperation des points de quadrature
    [theta, omega_theta, phi, omega_phi] = quadrature(L);
    
    % Recuperation du partitionement
    % Attention partition est une structure de donnees
    partition = buildOctree_bis(coord, N(m), lambda);
    
    disp(['Nombre de partition : ', num2str(partition.nb_part_nv)])
    
    
    % On commence a compter le temps a partir d'ici
    disp('Debut de la multiplication matrice-vecteur')
    
    tic
    
    % Calcul des contribution des cases eloignees
    Res = green_approx_bis(coord,partition,rho,k,theta,omega_theta,phi,omega_phi,L,N(m));
    
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
    
    
    temps_1(m) = toc;
    
    
%     
%     %Comparaison avec la valeur calculee directement
%     
%     Difference selon x
%     [a,b] = meshgrid(coord(:,1), coord(:,1));
%     diff_x = a-b;
%     
%     Difference selon y
%     [a,b] = meshgrid(coord(:,2), coord(:,2));
%     diff_y = a-b;
%     
%     Difference selon z
%     [a,b] = meshgrid(coord(:,3), coord(:,3));
%     diff_z = a-b;
%     
%     Difference selon y
%     G_tot = sqrt(diff_x.^2 + diff_y.^2 +diff_z.^2);
%     G_tot = G_tot + eye(size(G_tot));
%     
%     G_tot = exp(1i*k*G_tot)./G_tot;
%     G_tot = G_tot - diag(diag(G_tot));
%     
%     
%     %produit matrice vecteur
%     tic
%     V = G_tot*rho;
%     temps_2(m) = toc;
   
end


h_fig = setFigure_bis('Figure temps a');

[hAx, h_temps1, h_temps2] = plotyy(N, temps_1, N, temps_2);

h_axis = gca;

set(h_temps1, 'Marker', 'o')
set(h_temps1, 'MarkerSize', 4)
set(h_temps1, 'LineStyle', 'none')
set(h_temps1, 'Color', 'blue');
set(h_temps1, 'MarkerFaceColor', 'blue')

set(h_temps2, 'Marker', 'd')
set(h_temps2, 'MarkerSize', 4)
set(h_temps2, 'LineStyle', 'none')
set(h_temps2, 'Color', 'red');
set(h_temps2, 'MarkerFaceColor', 'red')

set(h_axis, 'Units', 'normalized');
set(h_axis, 'LineWidth', alw);
set(h_axis, 'Position', [left_space+0.03 v_space norm_ax_width-0.08 norm_ax_height]);
set(h_axis, 'FontUnits','points');
set(h_axis, 'FontWeight','normal');
set(h_axis, 'FontSize', fsz);
set(h_axis, 'FontName', f_name);

set(hAx(2), 'Units', 'normalized');
set(hAx(2), 'LineWidth', alw);
set(hAx(2), 'FontUnits','points');
set(hAx(2), 'FontWeight','normal');
set(hAx(2), 'FontSize', fsz);
set(hAx(2), 'FontName', f_name);

xlabel(h_axis,'$N$','Interpreter','LaTeX',...
    'FontSize',10);

ylabel(hAx(1),'$\tau_c$','Interpreter','LaTeX',...
    'FontSize',10, 'Color', 'blue');
set(hAx(1), 'YColor', 'blue');

ylabel(hAx(2),'$\tau_a$','Interpreter','LaTeX',...
    'FontSize',10, 'Color', 'red');
set(hAx(2), 'YColor', 'red');








h_fig2 = setFigure('Figure temps log');

h_t1 = loglog(N,temps_1);
set(h_t1, 'Marker', 'o')
set(h_t1, 'MarkerSize', 2)
set(h_t1, 'LineStyle', 'none')
set(h_t1, 'Color', 'blue');
set(h_t1, 'MarkerFaceColor', 'blue')

hold on

h_t2 = loglog(N,temps_2);
set(h_t2, 'Marker', 'd')
set(h_t2, 'MarkerSize', 2)
set(h_t2, 'LineStyle', 'none')
set(h_t2, 'Color', 'red');
set(h_t2, 'MarkerFaceColor', 'red')

loglog(N, (temps_1(Num_points-1)/(N(Num_points-1).^(3/2)))*N.^(3/2), '--','Color', line_color_3)
loglog(N, (temps_2(Num_points-1)/(N(Num_points-1).^2))*N.^2,'--','Color', line_color_3)

%set(gca, 'xlim', [min(N)*(0.5), max(N)*1.50]);
%set(gca, 'ylim', [min(temps_2)*(0.5), max(temps_1)*5]);

%set(gca,'XTick', [10 100 1000]);
%set(gca,'YTick', [0.00001, 0.001, 0.1, 10]);

