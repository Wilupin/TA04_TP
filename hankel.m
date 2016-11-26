function h = hankel(n, z)

h = zeros(n,max(size(z)));

h(1,:) = exp(1i*z)./(1i*z);

for p=0:1
    h(2,:) = h(2,:) + (1i^(p-1-1))*(factorial(p+1)/(factorial(p)*factorial(1-p)*(2^p)))./(z.^(p+1));
end

h(2,:) = h(2,:).*exp(1i*z);

for p=2:n
    h(p+1,:) = ((2*(p-1)+1)./z).*h(p,:) - h(p-1,:);
end


end

