clear all;

Res_int = zeros(10,5)

for i = 1:10
    for j =1:i
        Res_int(i,j) = intHarm(i-1,j-1);
    end
end

abs(Res_int)