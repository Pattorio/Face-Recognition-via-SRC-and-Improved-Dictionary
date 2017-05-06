function class = getClass(Y,W_hat,A,tr_index)

n = size(A,2);
j = size(Y,2);

% y = B * w
% minimize w_l1 subject to B * w = y

X_hat = W_hat(1:n,:);
E_hat = W_hat(n+1:end,:);

Y_r = Y - E_hat;
K = 13;

for a=1:j
    x_hat = X_hat(:,a);
    y_r = Y_r(:,a);
    [delta,delta_matrix]=getDelta(x_hat,K,tr_index);
    A_delta = A * delta_matrix;
    for k=1:K
        r(k) = norm(y_r - A_delta(:,k),2);
    end
    [M, index] = min(r);
    class(a) = index;
end
    
end