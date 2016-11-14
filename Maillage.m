function [coord,N] = Maillage(nlambda, f)

L = 1; 
l = 0.5;

c = (3.0*10^8);

lambda = c/f;
h = lambda/nlambda;

a = 0:h:L;
b = 0:h:l; 

s_a = max(size(a));
s_b = max(size(b)); 


% X : coordonnees en x des points sur une face
% Y : coordonnees en y des points sur une face
% Z : coordonnees en y des points sur une face

% Faces 1 et 3 du maillage
[X,Z] = meshgrid(a,b);
X = reshape(X,s_a*s_b,1);
Z = reshape(Z,s_a*s_b,1);

coord_1(:,1) = X(:);
coord_1(:,2) = zeros(s_a*s_b,1); 
coord_1(:,3) = Z(:); 

coord_3(:,1) = X(:); 
coord_3(:,2) = l*ones(s_a*s_b,1);
coord_3(:,3) = Z(:);



% Faces 2 et 4 du maillage
Y = Z;

coord_2(:,1) = X(:); 
coord_2(:,2) = Y(:);
coord_2(:,3) = l*ones(s_a*s_b,1);

coord_4(:,1) = X(:); 
coord_4(:,2) = Y(:);
coord_4(:,3) = zeros(s_a*s_b,1);




% Faces 5 et 6 du maillage
[Y,Z] = meshgrid(b,b);
Y = reshape(Y,s_b*s_b,1);
Z = reshape(Z,s_b*s_b,1);

coord_5(:,1) = L*ones(s_b*s_b,1); 
coord_5(:,2) = Y(:);
coord_5(:,3) = Z(:);

coord_6(:,1) = zeros(s_b*s_b,1);
coord_6(:,2) = Y(:);
coord_6(:,3) = Z(:);

coord = [coord_1; coord_2; coord_3; coord_4; coord_5; coord_6 ];

coord = unique(coord, 'rows');

%4*(s_a*(s_b-1)) + 2*(s_b-2)^2
N = max(size(coord));

end

