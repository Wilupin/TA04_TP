clear all;

journal_plot_params;

c = 3*10.0^8;

nlambda = 10;
f = 3*10.0^8;

k = (2*pi*f)/c;

[coord, N] = Maillage(nlambda,f);
refNodes = buildOctree(coord,N,lambda);


h_fig = setFigure('ScatterPlot');
h_plot = scatter3(coord(:,1), coord(:,2), coord(:,3), 4)
set(h_plot, 'MarkerFaceColor', 'red')
set(h_plot, 'MarkerEdgeColor', 'red')
axis equal
grid off
view(152,25)

axesLabelsAlign3D()

h_axis = gca;

set(h_axis, 'Units', 'normalized');
set(h_axis, 'LineWidth', alw);
set(h_axis, 'Position', [left_space+0.03 v_space norm_ax_width norm_ax_height]);
set(h_axis, 'FontUnits','points');
set(h_axis, 'FontWeight','normal');
set(h_axis, 'FontSize', fsz);
set(h_axis, 'FontName', f_name);

xlabel(h_axis,'$x/L$','Interpreter','LaTeX',...
    'FontSize',10);

ylabel(h_axis,'$y/L$','Interpreter','LaTeX',...
    'FontSize',10);

zlabel(h_axis,'$z/L$','Interpreter','LaTeX',...
    'FontSize',10);

hold on 

x=0:.1:1;
y=0:0.1:0.5;
[X,Y] = meshgrid(x,y);
Z= 0.*X;
h_plan = surf(X,Y,Z)
set(h_plan, 'FaceAlpha', 0.05) 
set(h_plan, 'FaceColor', 'cyan') 
set(h_plan, 'EdgeColor', 'blue') 
set(h_plan, 'LineStyle', ':')
set(h_plan, 'EdgeAlpha', 0.4) 

hold on 

x=0:.1:1;
z=0:0.1:0.5;
[X,Z] = meshgrid(x,y);
Y= 0.*X;
h_plan_2 = surf(X,Y,Z)
set(h_plan_2, 'FaceAlpha', 0.05) 
set(h_plan_2, 'FaceColor', 'cyan') 
set(h_plan_2, 'EdgeColor', 'blue') 
set(h_plan_2, 'LineStyle', ':')
set(h_plan_2, 'EdgeAlpha', 0.4)


hold on 

z=0:0.1:0.5;
[Y,Z] = meshgrid(z);
X = 0.*Y;
h_plan_3 = surf(X,Y,Z)
set(h_plan_3, 'FaceAlpha', 0.05) 
set(h_plan_3, 'FaceColor', 'cyan') 
set(h_plan_3, 'EdgeColor', 'blue')
set(h_plan_3, 'LineStyle', ':')
set(h_plan_3, 'EdgeAlpha', 0.4)



%hold on 

% x=0:.1:1;
% y=0:0.1:0.5;
% [X,Y] = meshgrid(x,y);
% Z= 0.5*ones(size(X));
% h_plan = surf(X,Y,Z)
% set(h_plan, 'FaceAlpha', 0.05) 
% set(h_plan, 'FaceColor', 'cyan') 
% set(h_plan, 'EdgeColor', 'blue') 
% set(h_plan, 'EdgeAlpha', 0.4) 
% alpha(h_plan,0.2)

hold on 