
journal_plot_params;

load('Premier_essai.mat');

Num_points = max(size(N))-1;

N(end) = [];
temps_1(end) = [];
temps_2(end) = [];

x = 1:10000 ;
y = (max(temps_1)/(max(N.^(3/2))+100000))*x.^(3/2);

h_fig = setFigure_bis('Figure temps a');

[hAx, h_temps1, h_temps2] = plotyy(N, temps_1, N, temps_2);
hold on 
plot(x, y); 

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

hold on;

h_t2 = loglog(N,temps_2);
set(h_t2, 'Marker', 'd')
set(h_t2, 'MarkerSize', 2)
set(h_t2, 'LineStyle', 'none')
set(h_t2, 'Color', 'red');
set(h_t2, 'MarkerFaceColor', 'red')

loglog(N, (temps_1(Num_points-1)/(N(Num_points-1).^(3/2)))*N.^(3/2), '--','Color', line_color_3)
loglog(N, (temps_2(Num_points-1)/(N(Num_points-1).^2))*N.^2,'--','Color', line_color_3)

set(gca, 'xlim', [min(N)*(0.5), max(N)*1.50]);
set(gca, 'ylim', [min(temps_2)*(0.5), max(temps_1)*5]);

set(gca,'XTick', [10 100 1000]);
set(gca,'YTick', [0.00001, 0.001, 0.1, 10]);