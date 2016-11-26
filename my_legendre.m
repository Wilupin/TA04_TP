function leg = my_legendre(n, x)

leg = zeros(n,max(size(x)));

leg(1,:) = ones(size(x));
leg(2,:) = x;

for p=1:(n-1)
    leg(p+2,:) = ((2*p+1)/(p+1)).*x.*leg(p+1,:)-(p/(p+1)).*leg(p,:);
end 



end

