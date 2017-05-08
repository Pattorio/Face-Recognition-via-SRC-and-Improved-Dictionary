
% load images and downsampling
load_img;
%load_AR_img;
%load_noise_img;
disp('Load imaged successfully!');

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

for i = 1:max(tr_index)
    temp_rpca = find(tr_index == i);
    [A_rpca(:,temp_rpca),E_rpca(:,temp_rpca)] = inexact_alm_rpca(trA(:,temp_rpca),lambda_rpca);
end

%[A_rpca,E_rpca,iter] = inexact_alm_rpca(trA,lambda_rpca);

disp('Finish RPCA!');


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
x_rpca = w_rpca(1:num_tr,:);
e_rpca = w_rpca((num_tr+1):end,:);

x = w(1:num_tr,:);
e = w((num_tr+1):end,:);

% recovery
Y_rpca = A_rpca * x_rpca;
Y = trA * x;

% classification
class_raw = getClass(Y,w,trA,tr_index);
class_rpca = getClass(Y_rpca,w_rpca,A_rpca,tr_index);
ac_raw = accuracy(class_raw,te_index)
ac_rpca = accuracy(class_rpca,te_index)

