function [Z,E] = inexact_alm_lrr(X,A,lambda)
% min |Z|_* + lamnda * |E|_2,1  s.t. X = AZ+E;
% X - d x n matrix
% A - d x m matrix
% Z - m x n matrix
% E - d x n matrix
% tol is the tolerance of convergence conditions
% maxIter is the maximum number of iterations

mu = 10e-6;
mu_max = 10e6;
rho = 1.1;
tol = 10e-8;

[d,n] = size(X);
m = size(A,2);

% initialize
J = zeros(m,n);
Z = zeros(m,n);
E = sparse(d,n);
Y1 = zeros(d,n);
Y2 = zeros(m,n);

iter = 0;
converged = false;

while ~converged
    iter = iter + 1;
    
    % update J
    temp_J = Z + Y2/mu;
    [U,S,V] = svd(temp,'econ');
    S_diag = diag(S);
    svp = lenth(find(sigma>1/mu));
    




