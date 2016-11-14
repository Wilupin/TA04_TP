clear all;

M = [6.5 31 -14 -43 ; 9.1 -3 11 31 ; 17.6 -16 28 80 ; 26.2 50 -7 -26];
M = [1.1 2 3 4 ; 5 6.8 7 8 ; 9 10 11.7 12 ; 13 14 15 16.5];

% B = (1/M(1,4).*M(:,4))*M(1,:)
% R = M - (1/M(1,4).*M(:,4))*M(1,:)
% 
% B = B + (1/R(3,2))*(R(:,2)*R(3,:))
% R = R - (1/R(3,2))*(R(:,2)*R(3,:))

M
B = 0;
i = 1;
j = 0;
eps = 0.01;
 
u = zeros(4,100);
v = zeros(4,100);

R_row = zeros(4,1);
R_col = zeros(4,1);


for k = 1:200
    
    R_row = M(i,:);
    
    for p=1:k-1 
        R_row = R_row - u(i,p)*v(:,p)';
    end
    
    [maximum, j] = max(abs(R_row));
    
    R_row
    
    if (R_row(j) == 0)
        gamma = 0;
    else 
        gamma = 1./(R_row(j));
    end
   
    
    if gamma == 0 
        break
    else 
       
        R_col(:) = M(:,j);
        
        for q=1:k-1
            R_col(:) = R_col(:) - v(j,q)*u(:,q);
        end
        
        u(:,k) = gamma*R_col(:);
        v(:,k) = R_row(:)'; 
        
        B = B + u(:,k)*v(:,k)';

        norm_vec = sqrt(sum(u(:,k).^2)*sum(v(:,k).^2));
        norm_mat = sqrt(sum(sum(B(:,:).^2)));
        
        if (norm_vec < eps*norm_mat)
            break
        end
    
        [maximum, i] = max(abs(R_col));
    end
    
end

gamma
k
B
norm_mat

