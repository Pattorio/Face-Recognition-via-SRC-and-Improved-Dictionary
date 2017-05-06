
classNum = 120;
classImageNum = 26;
classTrainNum = 13;
classTestNum = 13;
trainNum = classTrainNum * classNum;
testNum = classTrainNum * classNum;
lambda = 1/sqrt(2000);
img_size = [50,40];

load AR;
tr_index = [];

for i = 1:classNum
    for j = 1:classTrainNum
        index1 = (i-1)*classTrainNum+j;
        index2 = (i-1)*classImageNum+j;
        trainBase(:,index1) = double(fea(:,index2));
        tr_index = [tr_index,i];
    end
end

te_index = [];
for i = 1:classNum
    for j = 1:classTestNum
        index1 = (i-1)*classTestNum+j;
        index2 = (i-1)*classImageNum+classTrainNum+j;
        testBase(:,index1) = double(fea(:,index2));
        te_index = [te_index,i];
    end
end
clear i j index1 index2;


A = [trainBase testBase];
clear trainBase testBase;


%{
X_norm = zeros(D,N);
for i = 1:N
    X_norm(:,i) = X(:,i)/norm(X(:,i));
end
%}

trA = A(:,1:trainNum);
teA = A(:,trainNum+1:end);

%{
% show AR images
for i = 1:trainNum
    temp_img = reshape(trA(:,i),img_size);
    image8Bit = uint8(255 * mat2gray(temp_img));
    imshow(image8Bit);
end
%}

%{
% do RPCA on AR dictionary
lambda_rpca = 1/sqrt(size(trA, 1));

for i = 1:max(tr_index)
    temp_rpca = find(tr_index == i);
    [A_rpca(:,temp_rpca),E_rpca(:,temp_rpca)] = inexact_alm_rpca(trA(:,temp_rpca),lambda_rpca);
end

% show RPCA result
A0 = [];
A_img = [];
E_img = [];

for i = 1:13
    temp_img = reshape(trA(:,i),img_size);
    A0_temp = uint8(255 * mat2gray(temp_img));
    A0 = [A0 A0_temp];
    
    temp_img = reshape(E_rpca(:,i),img_size);
    E_temp = uint8(255 * mat2gray(temp_img));
    E_img = [E_img E_temp];
    
    temp_img = reshape(A_rpca(:,i),img_size);
    A_temp = uint8(255 * mat2gray(temp_img));
    A_img = [A_img A_temp];
    
end
subplot(3,1,1);
imshow(A0);
subplot(3,1,2);
imshow(A_img);
subplot(3,1,3);
imshow(E_img);

%}




