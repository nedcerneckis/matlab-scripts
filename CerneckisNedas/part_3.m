clear variables;
close all;

% Read in QR_1 image as a matrix of uint8 values
qr_1 = imread('images/QR_1.jpeg');
correct_matrix = decode_qr_module(qr_1, 29);

blurry_1 = imgaussfilt(qr_1, 1);
blurry_2 = imgaussfilt(qr_1, 2);
blurry_3 = imgaussfilt(qr_1, 3);
blurry_4 = imgaussfilt(qr_1, 4);

f1 = figure('Name', 'Gaussian blur applied to QR_1');
subplot(1,5,1), imshow(qr_1);
title('Original Image');
subplot(1,5,2), imshow(blurry_1);
title('\sigma = 1');
subplot(1,5,3), imshow(blurry_2);
title('\sigma = 2');
subplot(1,5,4), imshow(blurry_3);
title('\sigma = 3');
subplot(1,5,5), imshow(blurry_4);
title('\sigma = 4');

% Experiment 1
kernel_1 = [-1, -1, -1; -1, 8, -1; -1, -1, -1]/ 9;
original_sharpened = conv2(double(qr_1), kernel_1, 'same');
blurry_1_sharpened = conv2(double(blurry_1), kernel_1, 'same');
blurry_2_sharpened = conv2(double(blurry_2), kernel_1, 'same');
blurry_3_sharpened = conv2(double(blurry_3), kernel_1, 'same');
blurry_4_sharpened = conv2(double(blurry_4), kernel_1, 'same');

original_sharpened_decoded = decode_qr_module(original_sharpened, 29);
blurry_1_sharpened_decoded = decode_qr_module(blurry_1_sharpened, 29);
blurry_2_sharpened_decoded = decode_qr_module(blurry_2_sharpened, 29);
blurry_3_sharpened_decoded = decode_qr_module(blurry_3_sharpened, 29);
blurry_4_sharpened_decoded = decode_qr_module(blurry_4_sharpened, 29);

f2 = figure('Name', 'Sharpening filter applied to different gaussian blurs (0 = incorrect, 1 = correct)');
subplot(2,5,1), imshow(original_sharpened);
title('Original Image');
subplot(2,5,2), imshow(blurry_1_sharpened);
title('\sigma = 1 ');
subplot(2,5,3), imshow(blurry_2_sharpened);
title('\sigma = 2');
subplot(2,5,4), imshow(blurry_3_sharpened);
title('\sigma = 3');
subplot(2,5,5), imshow(blurry_4_sharpened);
title('\sigma = 4');
subplot(2,5,6), imshow(original_sharpened_decoded);
title(sprintf('Original image \n %d', isequal(correct_matrix, original_sharpened_decoded)));
subplot(2,5,7), imshow(blurry_1_sharpened_decoded);
title(sprintf('\\sigma = 1 \n %d', isequal(correct_matrix, blurry_1_sharpened_decoded)));
subplot(2,5,8), imshow(blurry_2_sharpened_decoded);
title(sprintf('\\sigma = 2 \n %d', isequal(correct_matrix, blurry_2_sharpened_decoded)));
subplot(2,5,9), imshow(blurry_3_sharpened_decoded);
title(sprintf('\\sigma = 3 \n %d', isequal(correct_matrix, blurry_3_sharpened_decoded)));
subplot(2,5,10), imshow(blurry_4_sharpened_decoded);
title(sprintf('\\sigma = 4 \n %d', isequal(correct_matrix, blurry_4_sharpened_decoded)));

% Experiment 2
PSF = fspecial('gaussian',5,5);
original_sharpened = deconvlucy(qr_1, PSF, 5);
blurry_1_sharpened = deconvlucy(blurry_1, PSF, 5);
blurry_2_sharpened = deconvlucy(blurry_2, PSF, 5);
blurry_3_sharpened = deconvlucy(blurry_1, PSF, 5);
blurry_4_sharpened = deconvlucy(blurry_1, PSF, 5);

original_sharpened_decoded = decode_qr_module(original_sharpened, 29);
blurry_1_sharpened_decoded = decode_qr_module(blurry_1_sharpened, 29);
blurry_2_sharpened_decoded = decode_qr_module(blurry_2_sharpened, 29);
blurry_3_sharpened_decoded = decode_qr_module(blurry_3_sharpened, 29);
blurry_4_sharpened_decoded = decode_qr_module(blurry_4_sharpened, 29);

f3 = figure('Name', 'Lucy-Richardson deblurring applied to different gaussian blurs (0 = incorrect, 1 = correct)');
subplot(2,5,1), imshow(original_sharpened);
title('Original Image');
subplot(2,5,2), imshow(blurry_1_sharpened);
title('\sigma = 1 ');
subplot(2,5,3), imshow(blurry_2_sharpened);
title('\sigma = 2');
subplot(2,5,4), imshow(blurry_3_sharpened);
title('\sigma = 3');
subplot(2,5,5), imshow(blurry_4_sharpened);
title('\sigma = 4');
subplot(2,5,6), imshow(original_sharpened_decoded);
title(sprintf('Original image \n %d', isequal(correct_matrix, original_sharpened_decoded)));
subplot(2,5,7), imshow(blurry_1_sharpened_decoded);
title(sprintf('\\sigma = 1 \n %d', isequal(correct_matrix, blurry_1_sharpened_decoded)));
subplot(2,5,8), imshow(blurry_2_sharpened_decoded);
title(sprintf('\\sigma = 2 \n %d', isequal(correct_matrix, blurry_2_sharpened_decoded)));
subplot(2,5,9), imshow(blurry_3_sharpened_decoded);
title(sprintf('\\sigma = 3 \n %d', isequal(correct_matrix, blurry_3_sharpened_decoded)));
subplot(2,5,10), imshow(blurry_4_sharpened_decoded);
title(sprintf('\\sigma = 4 \n %d', isequal(correct_matrix, blurry_4_sharpened_decoded)));