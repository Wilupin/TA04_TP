function [coordNodes, id] = buildOctree(coord, N, lambda, L, l )

d = 0.3*lambda;

% nombre de tranche dans chaque direction
n_x  = floor(L/d)+1;
n_yz = floor(l/d)+1;

id = 1;

for p=1:N 
    for q=1:n_x
        if (coord(p,1) >= (q-1)*d && coord(p,1) < q*d)
           x0 = (q-1)*d + d/2;
            for qq=1:n_yz 
               if (coord(p,2) >= (qq-1)*d && coord(p,2) < qq*d) 
                   y0 = (qq-1)*d + d/2;
                   for qqq=1:n_yz
                        if (coord(p,3) >= (qqq-1)*d && coord(p,3) < qqq*d)
                            z0 = (qqq-1)*d + d/2;
                            coordNodes(p,1) = x0;
                            coordNodes(p,2) = y0;
                            coordNodes(p,3) = z0;
                        end
                   end
               end
            end
        end
    end
end 


end

