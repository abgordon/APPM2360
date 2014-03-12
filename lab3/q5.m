%simple code for first section: set up adjacency matrix for books, check
%eigenvectors

adj = [0 0 0 1 1 1; 0 0 1 0 1 1; 0 0 0 1 0 1; 0 0 0 0 1 0; 1 1 0 1 0 0; 0 1 1 0 0 0]
[V,D] = eigs(adj,1)


