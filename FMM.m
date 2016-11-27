clear all;

journal_plot_params;

c = 3*10.0^8;

Num_points = 60;

for m = 1:Num_points

    nlambda = m;
    f = 3*10.0^8;
    
    k = (2*pi*f)/c;
   
    [coord, N(m)] = Maillage(nlambda,f);
    
    % Difference selon x
    [a,b] = meshgrid(coord(:,1), coord(:,1));
    diff_x = a-b;
    
    % Difference selon y
    [a,b] = meshgrid(coord(:,2), coord(:,2));
    diff_y = a-b;
    
    % Difference selon z
    [a,b] = meshgrid(coord(:,3), coord(:,3));
    diff_z = a-b;
    
    tic
    
    % Difference selon y
    G = sqrt(diff_x.^2 + diff_y.^2 +diff_z.^2);
    G = G + eye(size(G));
    
    G = exp(i*k*G)./G;
    G = G - diag(diag(G));
    
    temps_2(m) = toc;
    
    % produit matrice vecteur
    tic
    rho = ones(max(size(coord(:,1))),1);
    V = G*rho;
    temps_1(m) = toc;

end


h_fig = setFigure_bis('Figure temps a');

[hAx, h_temps1, h_temps2] = plotyy(N, temps_1, N, temps_2);
set(h_temps1, 'Marker', 'o')
set(h_temps1, 'MarkerSize', 4)
set(h_temps1, 'LineStyle', 'none')
set(h_temps1, 'Color', 'blue');
set(h_temps1, 'MarkerFaceColor', 'blue')

hold on; 

set(h_temps2, 'Marker', 'd')
set(h_temps2, 'MarkerSize', 4)
set(h_temps2, 'LineStyle', 'none')
set(h_temps2, 'Color', 'red');
set(h_temps2, 'MarkerFaceColor', 'red')
hold on;

journal_plot_params;

h_axis = gca;

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

set(hAx,'xlim',[0,max(N(:))+10]);
set(hAx(1),'ylim', [0, max(temps_1(2:end))*1.50]);
set(hAx(2),'ylim', [0, max(temps_2(2:end))*1.10]);

set(hAx(1),'YTick', linspace(0,max(temps_1(2:end))*1.50,5));
set(hAx(2),'YTick', linspace(0,max(temps_2(2:end))*1.10,5));



xlabel(h_axis,'$N$','Interpreter','LaTeX',...
    'FontSize',10);

ylabel(hAx(1),'$\tau_c$','Interpreter','LaTeX',...
    'FontSize',10, 'Color', 'blue');
set(hAx(1), 'YColor', 'blue');

ylabel(hAx(2),'$\tau_a$','Interpreter','LaTeX',...
    'FontSize',10, 'Color', 'red');
set(hAx(2), 'YColor', 'red');

% For new version of Matlab
%set(hAx(1),'TickLabelFormat','%.1f');
%set(hAx(2),'TickLabelFormat','%.1f');







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

hold on

loglog(N, (temps_1(Num_points)/(N(Num_points).^2))*N.^2, '--','Color', line_color_3)
loglog(N, (temps_2(Num_points)/(N(Num_points).^2))*N.^2,'--','Color', line_color_3)

set(gca, 'xlim', [min(N)*(0.5), max(N)*1.50]);
set(gca, 'ylim', [min(temps_1)*(0.5), max(temps_2)*5]);

set(gca,'XTick', [10 100 1000]);
set(gca,'YTick', [0.00001, 0.001, 0.1, 10]);


journal_axis(gca, '$N$', '$\tau_a, \tau_c$')



