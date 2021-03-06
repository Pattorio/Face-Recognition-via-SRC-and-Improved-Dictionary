path_root = 'CroppedYale/yaleB';

% original size
img_height = 192; 
img_width = 168;
img_size = [img_height, img_width];  
downsample_size = img_size./3;

% image vector size
img_resize = img_height * img_width/9;  % downsampling

index_tr = 1;
index_te = 1;
tr_index = [];
te_index = [];
    
file_set = {'A-005E-10'; 'A-005E+10'; 'A-010E-20'; 'A-010E+00'; ...
        'A-015E+20'; 'A-020E-10'; 'A-020E-40'; 'A-020E+10'; ...
        'A-025E+00'; 'A-035E-20'; 'A-035E+15'; 'A-035E+40'; ...
        'A-035E+65'; 'A-050E-40'; 'A-050E+00'; 'A-060E-20'; ...
        'A-060E+20'; 'A-070E-35'; 'A-070E+00'; 'A-070E+45'; ...
        'A-085E-20'; 'A-085E+20'; 'A-095E+00'; 'A-110E-20'; ...
        'A-110E+15'; 'A-110E+40'; 'A-110E+65'; 'A-120E+00'; ...
        'A-130E+20'; 'A+000E-20'; 'A+000E-35'; 'A+000E+00'; ...
        'A+000E+20'; 'A+000E+45'; 'A+000E+90'; 'A+005E-10'; ...
        'A+005E+10'; 'A+010E-20'; 'A+010E+00'; 'A+015E+20'; ...
        'A+020E-10'; 'A+020E-40'; 'A+020E+10'; 'A+025E+00'; ...
        'A+035E-20'; 'A+035E+15'; 'A+035E+40'; 'A+035E+65'; ...
        'A+050E-40'; 'A+050E+00'; 'A+060E-20'; 'A+060E+20'; ...
        'A+070E-35'; 'A+070E+00'; 'A+070E+45'; 'A+085E-20'; ...
        'A+085E+20'; 'A+095E+00'; 'A+110E-20'; 'A+110E+15'; ...
        'A+110E+40'; 'A+110E+65'; 'A+120E+00'; 'A+130E+20'; };
    trainset = {'A-005E-10'; 'A-005E+10'; 'A-010E-20'; 'A-010E+00'; ...
        'A-015E+20'; 'A-020E-10'; 'A-020E-40'; 'A-020E+10'; ...
        'A-025E+00'; 'A-035E-20'; 'A-035E+15'; 'A-035E+40'; ...
        'A-035E+65'; 'A-050E-40'; 'A-050E+00'; 'A-060E-20'; ...
        'A-060E+20'; 'A-070E-35'; 'A-070E+00'; 'A-070E+45'; ...
        'A-085E-20'; 'A-085E+20'; 'A-095E+00'; 'A-110E-20'; ...
        'A-110E+15'; 'A-110E+40'; 'A-110E+65'; 'A-120E+00'; ...
        'A-130E+20'; 'A+000E-20'; 'A+000E-35'; 'A+000E+00'; ...
        'A+000E+20'; 'A+000E+45'; 'A+000E+90'; };
    testset1 = {'A+005E-10'; ...
        'A+005E+10'; 'A+010E-20'; 'A+010E+00'; 'A+015E+20'; ...
        'A+020E-10'; 'A+020E-40'; 'A+020E+10'; 'A+025E+00'; ...
        'A+035E-20'; 'A+035E+15'; 'A+035E+40'; 'A+035E+65';};
        
    testset2 = {'A+050E-40'; 'A+050E+00'; 'A+060E-20'; 'A+060E+20'; ...
        'A+070E-35'; 'A+070E+00'; 'A+070E+45'; 'A+085E-20'; ...
        'A+085E+20';};
    testset3 = { 'A+095E+00'; 'A+110E-20'; 'A+110E+15'; ...
        'A+110E+40'; 'A+110E+65'; 'A+120E+00'; 'A+130E+20'; };
    testset = {'A+005E-10';'A+020E+10';'A+035E-20';'A+050E-40'; ...
        'A+070E-35';};



for f = 1:38
    folder_img = strcat(path_root, sprintf('%02d', f));
    path_img = fullfile(folder_img, '*.pgm');
    files = dir(path_img);
    num_img = length(files);
    
    for i = 1:num_img
        img_name = files(i).name(12:20);
        path_curr_img = strcat(folder_img, '/', files(i).name);
        temp = imread(path_curr_img);
        img = imresize(imread(path_curr_img), img_size);
        
        % downsample
        img = img(1:3:end,1:3:end);
        img = double(img);
        img = img - min(img(:));
        img = img / max(img(:));
        SNRdB = 40;
       
        v = sqrt(var(img(:))/10^(SNRdB/10));
        
        
        % imshow(img);
        %img_vector = reshape(img,img_resize,[]);
        % imshow(reshape(img_vector,img_size));
        
        if ismember(img_name, trainset)
        %if ismember(img_name, tr_set1) || ismember(img_name, tr_set2)
            img_noisy = imnoise(img, 'gaussian', 0, v);
            img_vector = reshape(img_noisy,img_resize,[]);
            trA(:,index_tr) = img_vector;
            index_tr = index_tr + 1;
            tr_index = [tr_index,f];
            sample_num = length(find(tr_index==1));
        elseif ismember(img_name,testset)
        %elseif ismember(img_name, te_set1)
            img_vector = reshape(img,img_resize,[]);
            teA(:,index_te) = img_vector;
            % imshow(reshape(teA(:,index_te),img_size));
            index_te = index_te + 1;
            te_index = [te_index,f];
        end
    end
end




