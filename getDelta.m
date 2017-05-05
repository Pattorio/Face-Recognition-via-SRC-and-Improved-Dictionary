function [delta_maxNorm, delta_matrix]= getDelta(x_hat,K)
X = repmat(x_hat,1,K);
delta_matrix = zeros(size(X));
for k=1:K
    i_start = (k-1)*19+1;
    i_end = k*19;
    delta_matrix(i_start:i_end,k) = X(i_start:i_end,k);
    norm1_delta(k) = norm(delta_matrix(:,k),1);
end

delta_maxNorm = max(norm1_delta);
end