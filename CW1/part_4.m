clear variables;
close all;

% Read in QR_2 image as a matrix of uint8 values
qr_2 = imread('images/QR_2.jpeg');

% Binarize QR image using thresholding (Code snippet taken from
% function)
bw_img_55 = imbinarize(qr_2, 0.55);
bw_img_50 = imbinarize(qr_2, 0.50);
bw_img_60 = imbinarize(qr_2, 0.60);

f1 = figure('Name', 'Thresholding applied to matrix');
subplot(2,4,1), imshow(qr_2);
title('Original image');
subplot(2,4,2), imshow(bw_img_50);
title('0.50 thresholding');
subplot(2,4,3), imshow(bw_img_55);
title('0.55 thresholding');
subplot(2,4,4), imshow(bw_img_60);
title('0.60 thresholding');

% Convert QR code to binary matrix
qr_2_decoded = decode_qr(qr_2);

f2 = figure('Name', 'QR_2 decoded with no module size as input')
subplot(1,2,1), imshow(qr_2);
subplot(1,2,2), imshow(qr_2_decoded);

% Show binary matrix of decoded QR Code
f3 = figure('Name', 'QR_2 decoded binary matrix');
imagesc(~qr_2_decoded);
title('Decoded binary matrix (0 = black, 1 = white')
colormap(flipud(gray));
impixelinfo;