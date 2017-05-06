function new_img = add_noise(img,img_size)
% Add random noise into picture

noise = randn(20);
noise = uint8(255*mat2gray(noise));
[m_noise, n_noise] = size(noise);
max_position = min(img_size);
max_position = max_position - m_noise;

position = randi(max_position,1,1);

img(position:(position+m_noise-1), position:(position+n_noise-1)) = noise;
new_img = img;

image = uint8(255*mat2gray(new_img));
imshow(new_img);
end
