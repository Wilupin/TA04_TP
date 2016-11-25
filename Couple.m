function couple = Couple(id1, id2)

% Fonction qui d?termine si deux boites de position logique id1 et id2 sont
% voisines ou non. Renvoie 0 si elles ne le sont pas et 1 si elles le sont.
% Attention Renvoie 2 si jamais on est sur la m?me case

couple = 0;

a = id1(1);
b = id1(2);
c = id1(3);
d = id2(1); 
e = id2(2);
f = id2(3);

if (a==d || a == d+1 || a == d-1) 
    if (b == e && (c == f-1 || c == f+1)) 
        couple = 1;
    end    
    if (b == e+1 && (c == f-1 || c == f+1 || c == f)) 
        couple = 1;
    end
    if (b == e-1 && (c == f-1 || c == f+1 || c == f)) 
        couple = 1;
    end
    if (b == e && (c == f)) 
        couple = 2;
    end
end


end