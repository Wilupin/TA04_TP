function [partition] = buildOctree_bis(coord, N, lambda)

% Structure de donn?es de sortie
partition = struct;

% Variables utilis?es
d = 0.5*lambda;
L = 1.0;
l = 0.5;

% nombre de tranche dans chaque direction
partition.n_x  = floor(L/d)+1;
partition.n_yz = floor(l/d)+1;

refBox_x = zeros(N,1); 
refBox_y = zeros(N,1); 
refBox_z = zeros(N,1); 

coordBox_x = zeros(N,1); 
coordBox_y = zeros(N,1); 
coordBox_z = zeros(N,1); 

for q=1:partition.n_x
    x0 = (q-1)*d + d/2;
    id_x = find(1 == (coord(:,1) >= (q-1)*d & coord(:,1) < q*d));
    refBox_x(id_x) = q;
    coordBox_x(id_x) = x0;
end
    
for q=1:partition.n_yz
    
    y0 = (q-1)*d + d/2;
    id_y = find(1 == (coord(:,2) >= (q-1)*d & coord(:,2) < q*d));
    refBox_y(id_y) = q;
    coordBox_y(id_y) = y0; 
    
    z0 = (q-1)*d + d/2;
    id_z = find(1 == (coord(:,3) >= (q-1)*d & coord(:,3) < q*d));
    refBox_z(id_z) = q;
    coordBox_z(id_z) = z0;  
end

% Rassemblement des informations dans un seul et m?me tableau
partition.ref_box  = [refBox_x, refBox_y, refBox_z];
coordBox           = [coordBox_x, coordBox_y, coordBox_z];


% Association des points dans chaque boite
label = 1;

partition.points_box = sparse(partition.n_x*partition.n_yz*partition.n_yz, N);
partition.size_box   = sparse(partition.n_x*partition.n_yz*partition.n_yz, 1);
partition.is_empty   = ones(partition.n_x,partition.n_yz,partition.n_yz);
partition.label_box  = zeros(N,1);

% Boucle sur toutes les boites
for p=1:partition.n_x
    for q=1:partition.n_yz
        for r=1:partition.n_yz
             id = find(1 == (refBox_x == p & refBox_y == q & refBox_z == r));
             if min(size(id)) ~= 0
                 partition.label_box(id) = label;
                 partition.size_box(label) = max(size(id));
                 partition.points_box(label, 1:max(size(id))) = id;
                 partition.is_empty(p,q,r)                    = 0;
                 label = label + 1;
             end
        end
    end
end


% On enregistre le nombre de boites non vides
partition.nb_part_nv = label - 1;

partition.coords_box  = zeros(partition.nb_part_nv, 3);
partition.num_box     = zeros(partition.nb_part_nv, 3);



label = 1;

% Ecriture des coordonn?es et des positions logiques de chaque boite
for p=1:partition.n_x
    for q=1:partition.n_yz
        for r=1:partition.n_yz
             if (partition.is_empty(p,q,r) == 0)
                 partition.coords_box(label,:) = coordBox(partition.points_box(label,1),:);
                 partition.coordsLogiques_box(label,:) = [p,q,r];
                 label = label + 1;              
             end
        end
    end
end


% On d?clare une matrice de tous les voisins en sparse
partition.liste_voisins = sparse(partition.nb_part_nv, partition.nb_part_nv);

% Construction des couples de boites en interaction
for p=1:partition.nb_part_nv
    for q=1:partition.nb_part_nv
        if (Couple(partition.coordsLogiques_box(p,:), partition.coordsLogiques_box(q,:)) > 0)
           partition.liste_voisins(p,q) = 1;
        end
    end
end


end

