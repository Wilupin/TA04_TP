function h = hankel( n, z )

h = zeros(1,max(size(z)));

for p=0:n
    h = h + (1i^(p-n-1))*(factorial(p+n)/(factorial(p)*factorial(n-p)*(2^p)))./(z.^(p+1));
end

h = h.*exp(1i*z);

end

