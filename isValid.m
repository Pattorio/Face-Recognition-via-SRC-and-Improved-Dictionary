function [isvalid,X_hat,norm1_delta,SCI] = isValid(x_hat,K)
% x_hat - n x 1 vector
% K - the total number of in-set phase classes
% m = K*n --- m = size(A,2)
%         --- n - the number of training tokens per class
% tau - threshold 

    X = repmat(x_hat,1,K);
    X_hat = zeros(size(X));
    for k=1:K
        i_start = (k-1)*19+1;
        i_end = k*19;
        X_hat(i_start:i_end,k) = X(i_start:i_end,k);
        norm1_delta(k) = norm(X_hat(:,k),1);
    end

    norm1_x = norm(x_hat,1);
    delta_x = max(norm1_delta);
    
    SCI = (K*(delta_x/norm1_x)-1)/(K-1);
    
    tau = 0.2;
    if SCI>=tau
        isvalid = true;
    else
        isvalid = false;
    end
    
end