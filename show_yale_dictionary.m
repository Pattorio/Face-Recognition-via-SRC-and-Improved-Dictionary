for j = 1:13

    A2 = []; A1 = []; A0 = [];
    
    temp_index = find(tr_index == j);

    for i = 1:length(temp_index)
        image = uint8(255 * mat2gray(trA(:,temp_index(1)-1+i)));
        temp0 = reshape(image,[64,56]);
        img0 = imresize(temp0, [192,168]);
        A0 = [A0 img0];

        image = uint8(255 * mat2gray(A_rpca(:,temp_index(1)-1+i)));
        temp1 = reshape(image,[64,56]);
        img1 = imresize(temp1, [192,168]);
        A1 = [A1 img1];

        image = uint8(255 * mat2gray(E_rpca(:,temp_index(1)-1+i)));
        temp2 = reshape(image,[64,56]);
        img2 = imresize(temp2, [192,168]);
        A2 = [A2 img2];
    end
    
    figure
    subplot(3,1,1);
    imshow(A0);
    subplot(3,1,2);
    imshow(A2);
    subplot(3,1,3);
    imshow(A1);
end