function [refBox, coordBox, n_x, n_yz] = buildOctree_bis(coord, N, lambda, L, l )

d = 0.3*lambda;

% nombre de tranche dans chaque direction
n_x  = floor(L/d)+1;
n_yz = floor(l/d)+1;

refBox_x = zeros(N,1); 
refBox_y = zeros(N,1); 
refBox_z = zeros(N,1); 

coordBox_x = zeros(N,1); 
coordBox_y = zeros(N,1); 
coordBox_z = zeros(N,1); 

for q=1:n_x
    x0 = (q-1)*d + d/2;
    id_x = find(1 == (coord(:,1) >= (q-1)*d & coord(:,1) < q*d));
    refBox_x(id_x) = q;
    coordBox_x(id_x) = x0;
end
    
for q=1:n_yz
    
    y0 = (q-1)*d + d/2;
    id_y = find(1 == (coord(:,2) >= (q-1)*d & coord(:,2) < q*d));
    refBox_y(id_y) = q;
    coordBox_y(id_y) = y0; 
    
    z0 = (q-1)*d + d/2;
    id_z = find(1 == (coord(:,3) >= (q-1)*d & coord(:,3) < q*d));
    refBox_z(id_z) = q;
    coordBox_z(id_z) = z0; 
   
end


refBox   = [refBox_x, refBox_y, refBox_z];
coordBox = [coordBox_x, coordBox_y, coordBox_z];

end

