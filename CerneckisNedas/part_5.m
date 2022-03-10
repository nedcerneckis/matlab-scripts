clear variables;
close all;

% Read in QR_2 image as a matrix of uint8 values
qr_2 = imread('images/QR_2.jpeg');

% Convert QR code to binary matrix
qr_2_decoded = decode_qr(qr_2);

% Testing different downscaling on performance of solution
qr_2_500x500 = imresize(qr_2, [500 500]);
qr_2_200x200 = imresize(qr_2, [200 200]);
qr_2_100x100 = imresize(qr_2, [100 100]);
qr_2_37x37 = imresize(qr_2, [37 37]);

qr_2_500x500_decoded = decode_qr(qr_2_500x500);
qr_2_200x200_decoded = decode_qr(qr_2_200x200);
qr_2_100x100_decoded = decode_qr(qr_2_100x100);
qr_2_37x37_decoded = decode_qr(qr_2_37x37);

f1 = figure('Name', 'Thresholding applied to matrix (0 = incorrect, 1 = correct)');
subplot(1,6,1), imshow(qr_2);
title('Original image');
subplot(1,6,2), imshow(qr_2_decoded);
title('QR_2 decoded');
subplot(1,6,3), imshow(qr_2_500x500_decoded);
title(sprintf('500x500 \n %d',isequal(qr_2_decoded, qr_2_500x500_decoded)));
subplot(1,6,4), imshow(qr_2_200x200_decoded);
title(sprintf('200x200 \n %d',isequal(qr_2_decoded, qr_2_200x200_decoded)));
subplot(1,6,5), imshow(qr_2_100x100_decoded);
title(sprintf('100x100 \n %d',isequal(qr_2_decoded, qr_2_100x100_decoded)));
subplot(1,6,6), imshow(qr_2_37x37_decoded);
title(sprintf('37x37 \n %d',isequal(qr_2_decoded, qr_2_37x37_decoded)));