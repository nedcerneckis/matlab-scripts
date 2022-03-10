clear variables;
close all;

% Read in QR_1 image as a matrix of uint8 values
qr_1 = imread('images/QR_1.jpeg');
correct_matrix = decode_qr_module(qr_1, 29);

% Apply noise to QR code
noisy_1 = imnoise(qr_1,'salt & pepper', 0.05);
noisy_2 = imnoise(qr_1, 'salt & pepper', 0.20);
noisy_3 = imnoise(qr_1, 'salt & pepper', 0.35);
noisy_4 = imnoise(qr_1, 'salt & pepper', 0.50);
noisy_5 = imnoise(qr_1, 'salt & pepper', 0.65);

f1 = figure('Name', 'Salt & Pepper noise applied to QR_1');
subplot(2,3,1), imshow(qr_1);
title('Original Image');
subplot(2,3,2), imshow(noisy_1);
title('Noise Density = 0.05');
subplot(2,3,3), imshow(noisy_2);
title('Noise Density = 0.20');
subplot(2,3,4), imshow(noisy_3);
title('Noise Density = 0.35');
subplot(2,3,5), imshow(noisy_4);
title('Noise Density = 0.50');
subplot(2,3,6), imshow(noisy_5);
title('Noise Density = 0.65');

noisy_1_decoded = decode_qr_module(noisy_1, 29);
noisy_2_decoded = decode_qr_module(noisy_2, 29);
noisy_3_decoded = decode_qr_module(noisy_3, 29);
noisy_4_decoded = decode_qr_module(noisy_4, 29);
noisy_5_decoded = decode_qr_module(noisy_5, 29);

f2 = figure('Name', 'Noisy QR codes decoded, no spatial filters (0 = incorrect, 1 = correct)');
subplot(2,3,1), imshow(qr_1);
title('Original Image');
subplot(2,3,2), imshow(noisy_1_decoded);
title(sprintf('Noise Density = 0.05 \n %d',isequal(correct_matrix, noisy_1_decoded)));
subplot(2,3,3), imshow(noisy_2_decoded);
title(sprintf('Noise Density = 0.20 \n %d',isequal(correct_matrix, noisy_2_decoded)));
subplot(2,3,4), imshow(noisy_3_decoded);
title(sprintf('Noise Density = 0.35 \n %d',isequal(correct_matrix, noisy_3_decoded)));
subplot(2,3,5), imshow(noisy_4_decoded);
title(sprintf('Noise Density = 0.50 \n %d',isequal(correct_matrix, noisy_4_decoded)));
subplot(2,3,6), imshow(noisy_5_decoded);
title(sprintf('Noise Density = 0.65 \n %d',isequal(correct_matrix, noisy_5_decoded)));

noisy_3_filtered_33 = medfilt2(noisy_3, [3 3]);
noisy_4_filtered_33 = medfilt2(noisy_4, [3 3]);

noisy_3_decoded = decode_qr_module(noisy_3_filtered_33, 29);
noisy_3_diff = correct_matrix - noisy_3_decoded;

noisy_4_decoded = decode_qr_module(noisy_4_filtered_33, 29);
noisy_4_diff = correct_matrix - noisy_4_decoded;

f3 = figure('Name', 'Noisy QR codes decoded with spatial filters (0 = incorrect, 1 = correct)');
subplot(1,3,1), imshow(qr_1);
title('Original Image');
subplot(1,3,2), imshow(noisy_3_decoded);
title(sprintf('Noise Density = 0.35 \n %d',isequal(correct_matrix, noisy_3_decoded)));
subplot(1,3,3), imshow(noisy_4_decoded);
title(sprintf('Noise Density = 0.50 \n %d',isequal(correct_matrix, noisy_4_decoded)));

% Show binary matrix of decoded QR Code
f4 = figure('Name', 'QR_1 difference in correct matrix vs matrix with spatial filters');
imagesc(noisy_3_diff);
title('0.35 noise density - Decoded binary matrix (0 = same cell, 1 = different cell')
colormap(flipud(gray));
impixelinfo;

% Show binary matrix of decoded QR Code
f5 = figure('Name', 'QR_1 difference in correct matrix vs matrix with spatial filters');
imagesc(noisy_4_diff);
title('0.50 noise density - Decoded binary matrix (0 = same cell, 1 = different cell')
colormap(flipud(gray));
impixelinfo;