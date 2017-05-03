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
maxIter = 1e6;

[d,n] = size(X);
m = size(A,2);

atx = A'*X;
inv_a = inv(A'*A + eye(m));

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
    
    sigma = diag(S);
    svp = lenth(find(sigma>1/mu));
    if svp >= 1
        sigma = sigma(1:svp) - 1/mu;
    else
        svp = 1;
        sigma = 0;
    end
    J = U(:,1:svp)*diag(sigma)*V(:,1:svp)';
    
    % update Z
    Z = inv_a * (atx - A'*E + J + (A'*Y1 - Y2)/mu);
    
    % update E
    xmaz = X - A*Z;
    Q = xmaz+Y1/mu;
    alpha = lambda/mu;
    for i = 1:n
        Q_norm = norm(Q(:,i),2);
        if  Q_norm > alpha
            E(:,i) = (Q_norm - alpha)/Q_norm * Q(:,i);
        else
            E(:,i) = zero(n,1);
        end
    end
    
    % update Y1
    xmazme = xmaz - E;
    Y1 = Y1 + mu*xmazme;
    
    % update Y2
    zmj
    Y2 = Y2 - mu*zmj;
    
    % update mu
    mu = min(rho*mu, u_max);
    
    condition = max(max(max(abs(xmazme))),max(max(abs(zmj))));
    
    if (mod(iter,50) == 0) || (condition < tol)
        disp('The number of iteration = ' num2str(iter));
    end
    
    if iter == maxIter && condtition > tol
        converged = 1;
        disp('Reach max iteration');
    end
    
    if condition < tol
        converged = 1;
    end
end

    
    
    
    
    
        
    




