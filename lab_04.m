%{
figure;

processed_image_3x3 = conv2(img, hAvg3x3);
processed_image_7x7 = conv2(img, hAvg7x7);
processed_image_gaussian = conv2(img, hGaussian);
processed_image_disk = conv2(img, hDisk);

subplot(2,3,1), imshow(img);
subplot(2,3,2), imshow(uint8(processed_image_3x3));
subplot(2,3,3), imshow(uint8(processed_image_7x7));
subplot(2,3,4), imshow(uint8(processed_image_gaussian));
subplot(2,3,5), imshow(uint8(processed_image_disk));


img1 = imread('cameraman.tif');

img1_noise = imnoise(img1, 'salt & pepper', 0.02);
medRes1 = medfilt2(img1_noise, [3, 3]);

figure;

subplot(1,2,1), imshow(img1_noise);
subplot(1,2,2), imshow(medRes1);
%}

sobelH = [1,2,1; 0,0,0; -1,-2,-1];
sobelV = sobelH';