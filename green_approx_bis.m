function G_res = green_approx_bis(coord, partition, q1, q, rho, k,theta,omega_theta, phi,omega_phi,L)


vec = zeros(L+1,1);

for p=0:L
    vec(p+1) = (2*p+1)*1i^p;
end 

G_res = 0;
G = zeros(1,2*L+1);
G1 = zeros(1,2*L+1);

x = coord(q,:);

for j=1:L+1
      
    s = [sin(theta(j))*cos(phi(:)).'; ...
        sin(theta(j))*sin(phi(:)).' ; ...
        cos(theta(j))*ones(2*L+1,1).'];
   
    
    for p=1:partition.nb_part_nv
        if(partition.liste_voisins(q1,p) == 0)
            for l=1:partition.size_box(p)
                
                x0 = partition.coords_box(q1,:);
                y0 = partition.coords_box(p,:);
                
                y = coord(partition.points_box(p,l),:);
                
                r0 = x0 - y0;
                normR0 = sqrt(r0*r0');
                
                y_diff = (y - y0).';
                x_diff = (x - x0).';
                
                hank = hankel(L,k*normR0);
                
                leg = my_legendre(L, (s(1,:)*r0(1) + ...
                    s(2,:)*r0(2) + s(3,:)*r0(3))./normR0);
                            
                G1 = sum(bsxfun(@times,vec(:).*hank(:),leg(:,:)));
                
                G1 = G1.*exp(-1i*sum(k*bsxfun(@times,y_diff(:),s(:,:))));  
                G1 = G1.*exp(+1i*sum(k*bsxfun(@times,x_diff(:),s(:,:)))); 
                G1 = G1.*rho(partition.points_box(p,l));
                
                G = G + G1;
            end 
        end
    end
    
    G_res = G_res + sum(G(:))*omega_theta(j);
    
end

G_res = G_res*omega_phi*(1i*k/(4*pi));


end


