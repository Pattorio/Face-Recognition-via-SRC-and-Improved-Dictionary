function [A_hat,E_hat] = inexact_alm_rpca(D,lambda)
% min |A|_* + lambda*|E|_1   s.t. D = A+E
% tol - the tolerance of convergence conditions
% maxIter - the maximum number of iterations

addpath PROPACK;

[m,n] = size(D);
tol = 10e-8;
maxIter = 10e6;

% initialize
rho = 1.5;
norm_D_two = lansvd(D,1,'L');
norm_D_inf = norm(D,inf)/lambda;
norm_D_F = norm(D,'fro');
mu = 1.25/norm_D_two;
mu_max = 10e6;
Y = D/max(norm_D_two, norm_D_inf);
A_hat = zeros(m,n);
E_hat = zeros(m,n);
sv = 10;

converged = false;
iter = 0;

while ~converged
    iter = iter+1;
    
    % update E
    temp_E = D-A_hat+(1/mu)*Y;
    E_hat = max(temp_E-lambda/mu, 0);
    E_hat = E_hat + min(temp_E+lambda/mu,0);
    
    % update A
    [U,S,V] = lansvd(D-E_hat+(1/mu)*Y,sv,'L');
    S = diag(S);
    svp = length(find(S > 1/mu));
    if svp < sv
        sv = min(svp+1,n);
    else
        sv = min(svp + round(0.05*n), n);
    end
    A_hat = U(:,1:svp)*diag(S(1:svp))*V(:,1:svp)';
    
    % update Y
    D_A_E = D- A_hat - E_hat;
    Y = Y + mu*D_A_E;
    
    % update mu
    mu = min(rho*mu,mu_max);
    
    % check the converge conditions
    stopCriterion = norm(D_A_E,'fro')/norm_D_F;
    if stopCriterion < tol
        converged = true;
    end
    if iter == 1 || mod(iter,20)==0 || stopCriterion<tol
        disp(['iteration = ' num2str(iter) ',rank = ' num2str(rank(A_hat))]);
    end
    if ~converged && iter >= maxIter
        disp('Maximun iterations reached!');
        converged = true;
    end
end

    
    
    