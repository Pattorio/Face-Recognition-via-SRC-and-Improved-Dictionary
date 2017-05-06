
% load images and downsampling
load_img;
disp('Load imaged successfully!');
downsample_size = img_size./3;

trA = im2double(trA);
teA = im2double(teA);

num_tr = size(trA, 2);
num_te = size(teA, 2);

%{
% normalize dictionanry 
for i = 1:num_tr
    trA(:,i) = trA(:,i)/norm(trA(:,i),2);
end
for i = 1:num_te
    teA(:,i) = teA(:,i)/norm(teA(:,i),2);
end
%}

% RPCA
% min |A|_* + lambda|E|_1 s.t D = A + E 
% Recovery a low-rank matrix A from a corrupted data matrix D
% [A,E] = inexact_alm_rpca(D,lambda)

disp('Do RPCA for dictionary...');
lambda_rpca = 1/sqrt(size(trA, 1));

[A_rpca,E_rpca] = inexact_alm_rpca(trA,lambda_rpca);
disp('Finish RPCA!');

%{
for i = 1:num_tr
    temp_img = reshape(E_rpca(:,i),downsample_size);
    image8Bit = uint8(255 * mat2gray(temp_img));
    imshow(image8Bit);
end
%}


%{
% LRR
% min rank(Z) + lambda|E|_2,1 s.t X = AZ + E 
% where Z is the low rank representataion of X
% [Z,E] = inexact_alm_rpca(A,lambda) 
% We can use A = X for reason that it is exactness to oueliers and
% robustness to sample-sepcific corruptions
disp('Do LRR for dictionary...');

lambda_lrr = 1/sqrt(size(trA, 1));
[Z_lrr,E_lrr] = LRR(trA,lambda_lrr);
A_lrr = trA * Z_lrr;
disp('Finish LRR!');
%}

% SRC intitialization
m_rpca = size(A_rpca,1);
m = size(trA,1);

% B = [A,I];
B_rpca = [A_rpca,eye(m_rpca)];
B = [trA, eye(m)];


rho = 1.5;
alpha = lambda_rpca;

% ADMM for dictionary from RPCA
for i = 1:num_te
    [w_rpca(:,i), history_rpca] = basis_pursuit(B_rpca, teA(:,i), rho, alpha);
end

% ADMM for raw dictionary
for i = 1:num_te
    [w(:,i),history] = basis_pursuit(B,teA(:,i),rho,alpha);
end


% w = [x;e]
x = w(1:num_tr,:);
e = w((num_tr+1):end,:);

x_rpca = w_rpca(1:num_tr,:);
e_rpca = w_rpca((num_tr+1):end,:);

% recovery
Y_rpca = A_rpca * x_rpca;
Y = trA * x;



%{
y = reshape(y,downsample_size);
image8Bit = uint8(255 * mat2gray(y));
imshow(image8Bit);
%}