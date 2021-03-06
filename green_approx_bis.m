function Res = green_approx_bis(coord,partition,rho,k,theta,omega_theta,phi,omega_phi,L,N)

vec = zeros(L+1,1);

for p=0:L
    vec(p+1) = (2*p+1)*1i^p;
end 

Res     = zeros(N,1);


% Boucle d'integration
for j=1:(L+1)
    
    disp(['Iteration : ', num2str(j)])
    
    RCy     = zeros(partition.nb_part_nv,2*L+1);
    
    s = [sin(theta(j))*cos(phi(:)).'; ...
        sin(theta(j))*sin(phi(:)).' ; ...
        cos(theta(j))*ones(2*L+1,1).'];
    
    % Calcul des coefficients de "masse "RCy
    for p2=1:partition.nb_part_nv
        
       y0 = partition.coords_box(p2,:);
        
        % On ne fait qu'une seule fois cette somme par case
        for l2=1:partition.size_box(p2);
            y = coord(partition.points_box(p2,l2),:);
            y_diff = (y - y0).';
            %[y0.' y.' y_diff]
            Texp1 = exp(-1i*k*sum(bsxfun(@times,y_diff(:),s(:,:))));
            RCy(p2,:) = RCy(p2,:) + Texp1.*rho(partition.points_box(p2,l2));
        end
        
    end
    
    
    
    
    % Parcours des cases une premiere fois
    for p1=1:partition.nb_part_nv   
       
        LCx     = zeros(1,2*L+1);
      
        x0 = partition.coords_box(p1,:);
        
        for p2=1:partition.nb_part_nv
            if(partition.liste_voisins(p1,p2) == 0)
                
                y0 = partition.coords_box(p2,:);
                r0 = x0 - y0;
                normR0 = sqrt(r0*r0');
                
                % Calcul des fonctions tabulee a utiliser
                hank = hankel(L,k*normR0);      
                leg  = my_legendre(L, sum(bsxfun(@times,r0(:),s(:,:)))./normR0);
                
                LCx =  LCx + RCy(p2,:).*(1i*k/(4*pi)).*sum(bsxfun(@times,vec(:).*hank(:),leg(:,:)));           
                %disp(['Iteration j : ', num2str(j),  ' Partition ', num2str(p2)]);
                
             end
        end
        
        
        % Mise ? jour pour les points dans p1 de Res
        for l1=1:partition.size_box(p1)
            
            x = coord(partition.points_box(p1,l1),:);
            x_diff = (x - x0).';
            %[x0' x' x_diff]
            Texp2 = exp(+1i*k*sum(bsxfun(@times,x_diff(:),s(:,:))));
            Res(partition.points_box(p1,l1)) = Res(partition.points_box(p1,l1)) + ...
                sum(LCx.*Texp2)*omega_theta(j)*omega_phi;
          
        end 
    end
    
    %disp(['Iteration j : ', num2str(j), ' Res : ', num2str(Res(partition.points_box(p1,l1))) ])
   
end
  

end




