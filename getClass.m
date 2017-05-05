function class = getClass(Y,W_hat,A)

n = size(A,2);
j = size(Y,2);

% y = B * w
% minimize w_l1 subject to B * w = y

X_hat = W_hat(1:n,:);
E_hat = W_hat(n+1:end,:);

Y_r = Y - E_hat;
K = 13;

for a=1:j
    [delta,delta_matrix]=getDelta(X_hat(:,a),K);
    A_delta = A * delta_matrix;
    for k=1:K
        r(k) = norm(Y_r(:,a) - A_delta(:,k),2);
    end
    [M, index] = min(r);
    class(a) = index;
end
    
end