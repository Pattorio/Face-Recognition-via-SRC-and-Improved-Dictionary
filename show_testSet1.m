% show test set 1
clear test_index;
clear te_sample
test_index = find(te_index_testSet1==13);
%te_sample = teA_testSet1(:,test_index);
temp = [];
show = [];
for i = 1:length(test_index)
    te_image = uint8(255 * mat2gray(teA_testSet1(:,test_index(i))));
    temp_te = reshape(te_image,[64,56]);
    img_te = imresize(temp_te, [192,168]);
    if mod(i,4)~=0
        temp = [temp img_te];
    else
        show=[show;temp];
        temp=[];
    end
end
figure(2);
imshow(show);