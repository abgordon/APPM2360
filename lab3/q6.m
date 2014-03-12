%simple code for first section: set up adjacency matrix for books, check
%eigenvectors

adj = [0 0 0 1 1 1; 0 0 1 0 1 1; 0 0 0 1 0 1; 0 0 0 0 1 0; 1 1 0 1 0 0; 0 1 1 0 0 0]
[V,D] = eigs(adj,1)

%******* Section 2: ********
A =studentadjacency  %was having lots of trouble with "load" so I used the import wizard to load the matrix into my workspace
% load included 'workspace.mat' if you want to run this code
x = rand(33,1) %our random vector
[V,D] = eigs(A,1); %create eigenvector here to check error in loop


err = zeros(50,1)
rsave = zeros(50,1) %set up some vectors to store my error/r values

err(1,1) = norm(x-abs(V))  %set an initial value for err so the graph doesn't look weird

r=1;
for k = 2:50
     x = A*x;  %power method implemented here: Abk/||bk||
     x = x/norm(x);
     Ek = norm(x-abs(V))
     err(k,1) = Ek; %store our error values in our "err" vector
     r = Ek/err(k-1,1)
     rsave(k,1) = r; %store our r values in our "r" vector
     
end

x
abs(V)
plot(err) %Check out the results
r




%this code sorts the first fifteen students by rank

% rank = zeros(15,2)
% for i = 1:15,
%     rank(i,1) = x(i,1);
%     rank(i,2) = i;
% end
% 
% rank
% rank=sort(rank)


