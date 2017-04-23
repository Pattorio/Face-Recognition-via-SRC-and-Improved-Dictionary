path_root = 'CroppedYale/yaleB';

% original size
img_height = 192; 
img_width = 168;
img_size = [img_height, img_width];

% image vector size
img_resize = img_height * img_width;

index_tr = 1;
index_te = 1;

tr_set1 = {'A+000E+00'; 'A-010E+00'; 'A+010E+00'; 'A-005E+10'; 'A+005E+10'; 'A-005E-10'; 'A+005E-10'};

tr_set2 = {'A+000E-20'; 'A-010E-20'; 'A+020E-10'; 'A-025E+00'; 'A-015E+20'; 'A-020E-10'; 'A+000E+20'; 
    'A+010E-20';'A+020E+10'; 'A+025E+00'; 'A+015E+20'; 'A-020E+10'};
te_set1 = {'A-035E-20'; 'A-020E-40'; 'A-035E+40'; 'A-050E+00'; 'A+000E+45'; 'A+035E+15';};
    

for f = 1:13
    folder_img = strcat(path_root, sprintf('%02d', f));
    path_img = fullfile(folder_img, '*.pgm');
    files = dir(path_img);
    num_img = length(files);
    
    for i = 1:num_img
        img_name = files(i).name(12:20);
        path_curr_img = strcat(folder_img, '/', files(i).name);
        temp = imread(path_curr_img);
        img = imresize(imread(path_curr_img), img_size);
        % imshow(img);
        img_vector = reshape(img,img_resize,[]);
        % imshow(reshape(img_vector,img_size));
        
        if ismember(img_name, tr_set1) || ismember(img_name, tr_set2)
            trA(:,index_tr) = img_vector;
            index_tr = index_tr + 1;
        elseif ismember(img_name, te_set1)
            teA(:,index_te) = img_vector;
            % imshow(reshape(teA(:,index_te),img_size));
            index_te = index_te + 1;
        end
    end
end



