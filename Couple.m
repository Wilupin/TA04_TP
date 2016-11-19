function couple = Couple(id)

couple = 0;

a = id(1);
b = id(2);
c = id(3);
d = id(4); 
e = id(5);
f = id(6);

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