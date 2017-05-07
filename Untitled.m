[m,n] = size(Y);
RPCA = [];
Raw = [];
for i = 1:num_tr
    image = uint8(255*mat2gray(trA(:,i)));
    temp = reshape(image,[64,56]);
    RPCA = [RPCA temp];
    
    imageRaw = uint8(255*mat2gray(trA(:,i)));
    tempRaw = reshape(imageRaw,[64,56]);
    Raw = [Raw tempRaw];
end

figure;
title('RPCA');
for i = 1:13
    subplot(13,1,i);
    imshow(Y_re(:,(i-1)*56*9+1:i*56*9));
end
   
[m,n] = size(Y_rpca);
Yrpca_re = [];
Raw = [];
for i = 1:n
    image = uint8(255*mat2gray(Y_rpca(:,i)));
    temp = reshape(image,[64,56]);
    Yrpca_re = [Yrpca_re temp];
    
    imageRaw = uint8(255*mat2gray(teA(:,i)));
    tempRaw = reshape(imageRaw,[64,56]);
    Raw = [Raw tempRaw];
end

figure;
title('RPCA');
for i = 1:5
    subplot(5,1,i);
    imshow(Yrpca_re(:,(i-1)*56*9+1:i*56*9));
end

figure;
title('RAW');
for i = 1:5
    subplot(5,1,i);
    imshow(Raw(:,(i-1)*56*9+1:i*56*9));
end

    