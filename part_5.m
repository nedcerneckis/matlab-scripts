clear variables;
close all;

% Read in QR_2 image as a matrix of uint8 values
qr_2 = imread('images/QR_2.jpeg');

% Convert QR code to binary matrix
qr_2_decoded = decode_qr(qr_2);

% Testing different downscaling on performance of the solution
qr_2_520x520 = imresize(qr_2, [520 520]);
qr_2_370x370 = imresize(qr_2, [370 370]);
qr_2_260x260 = imresize(qr_2, [260 260]);
qr_2_100x100 = imresize(qr_2, [100 100]);

qr_2_520x520_decoded = decode_qr(qr_2_520x520);
qr_2_370x370_decoded = decode_qr(qr_2_370x370);
qr_2_260x260_decoded = decode_qr(qr_2_260x260);
qr_2_100x100_decoded = decode_qr(qr_2_100x100);

f1 = figure('Name', 'Different QR_2 resolutions decoded (0 = incorrect, 1 = correct)');
subplot(1,6,1), imshow(qr_2);
title('Original image');
subplot(1,6,2), imshow(qr_2_decoded);
title('QR_2 decoded');
subplot(1,6,3), imshow(qr_2_520x520_decoded);
title(sprintf('520x520 \n %d',isequal(qr_2_decoded, qr_2_520x520_decoded)));
subplot(1,6,4), imshow(qr_2_370x370_decoded);
title(sprintf('370x370 \n %d',isequal(qr_2_decoded, qr_2_370x370_decoded)));
subplot(1,6,5), imshow(qr_2_260x260_decoded);
title(sprintf('260x260 \n %d',isequal(qr_2_decoded, qr_2_260x260_decoded)));
subplot(1,6,6), imshow(qr_2_100x100_decoded);
title(sprintf('100x100 \n %d',isequal(qr_2_decoded, qr_2_100x100_decoded)));
