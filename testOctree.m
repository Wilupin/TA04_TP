clear all;

c = 3*10.0^8;

nlambda = 10;
f = 6*10.0^8;
lambda = c/f;

[coord, N] = Maillage(nlambda,f);

%[coordNodes, id] = buildOctree( coord, N, lambda, 1, 0.5 );
[rfB, cdB, n_x, n_yz] = buildOctree_bis( coord, N, lambda, 1, 0.5 );

id = [rfB(1,:) rfB(2,:)];
Couple(id)

rho = ones(N,1);





