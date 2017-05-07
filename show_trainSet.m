% show train set

trA_index = find(tr_index==13);
tr_sample = trA(:,trA_index);
temp = [];
show = [];
for i = 1:length(trA_index)
    tr_image = uint8(255 * mat2gray(trA(:,trA_index(i))));
    temp_tr = reshape(tr_image,[64,56]);
    img_tr = imresize(temp_tr, [192,168]);
    if mod(i,6)~=0
        temp = [temp img_tr];
    else
        show=[show;temp];
        temp=[];
    end
end
figure(1);
imshow(show);