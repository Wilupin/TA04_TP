function func = myFunction_bis(t,ph,L,r0,normR0,k)

func = 0;

for p=0:L
    func = func + (2*p+1)*(i^p)*besselh(p,1,k*normR0)*...
        legendreP(p, (sin(t).*cos(ph)*r0(1) +...
        sin(t).*sin(ph)*r0(2) + ...
        cos(t)*r0(3))./normR0).*sin(t);
end

func = (i*k/(4*pi))*func;


    
% p = 2;
% 
% func =  (2*p+1)*(1i^p)*besselh(p,1,k*normR0)*legendreP(p, (sin(t).*cos(ph)*r0(1) +...
%          sin(t).*sin(ph)*r0(2) + ...
%          cos(t)*r0(3))./normR0);
%      
% 
% func = (i*k/(4*pi))*func;

end

