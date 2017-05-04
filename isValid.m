function isvalid = isValid(x_hat,K)
% x_hat - n x 1 vector
% K - the total number of in-set phase classes
% m = K*n --- m = size(A,2)
%         --- n - the number of training tokens per class
% tau - threshold 

    
    norm1_x = norm(x_hat,1);
    delta_x = max(x_hat);
    
    SCI = (K*(delta_x/norm1_x)-1)/(K-1);
    
    tau = 0.5;
    if SCI>=tau
        isvalid = true;
    else
        isvalid = false;
    end
    
end