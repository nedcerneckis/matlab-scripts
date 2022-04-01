clear variables;
close all;

% Read in QR_1 image as a matrix of uint8 values
qr_1 = imread('images/QR_1.jpeg');

% Binarize QR image using adaptive thresholding (Code snippet taken from
% function)
Threshold = adaptthresh(qr_1, 1);
bw_img = imbinarize(qr_1, Threshold);

f1 = figure('Name', 'Thresholding applied to matrix');
subplot(1,2,1), imshow(qr_1);
title('Original image');
subplot(1,2,2), imshow(bw_img);
title('After applying adaptive thresholding');

% Convert QR code to binary matrix
qr_1_decoded = decode_qr_module(qr_1, 29);

f2 = figure('Name', 'QR code converted to binary matrix')
subplot(1,2,1), imshow(qr_1);
title('Original image (177x177)');
subplot(1,2,2), imshow(qr_1_decoded);
title('QR_1 converted to a 29x29 binary matrix');

% Show binary matrix of decoded QR Code
f3 = figure('Name', 'QR_1 decoded binary matrix');
imagesc(~qr_1_decoded);
title('Decoded binary matrix (0 = black, 1 = white')
colormap(flipud(gray));
impixelinfo;