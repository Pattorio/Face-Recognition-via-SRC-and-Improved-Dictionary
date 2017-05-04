function ri_y = modify_ri_y(y,w_hat,A)
% A - m x n matrix
% B - m x (n+m) matirx
% A_e - m x m identity matrix (I)
% x - n x 1 vector
% w_hat - (m+n) x 1 vector

[m,n] = size(A);

% y = B * w
% minimize w_l1 subject to B * w = y

x_hat = w_hat(1:n);
e_hat = w_hat(n+1:n+m);

y_r = y - e_hat;

for i = 1:n
    delta_i_x = zeros(n,1);
    delta_i_x(i) = x_hat(i);
    tmp = y_r -A * delta_i_x;
    ri_y(i) = norm(tmp,2);
end

    
end