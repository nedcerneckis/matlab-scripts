clear variables;

img1 = imread('gull2.bmp');
[rows,cols] = size(img1);
dblImg = double(img1);

lpfilter = generateButterworthFilter(50, 2, rows, cols);

figure;
h = surf(lpfilter);
set(h, 'LineStyle', 'none');

ft1 = fft2(dblImg);
ft1 = fftshift(ft1);

magft1 = abs(ft1);

ft1Spectrum = log(1 + magft1);

img2 = uint8(rescale(ft1Spectrum,0,255));

ft2 = ft1 .* lpfilter;

magft2 = abs(ft2);
ft2Spectrum2 = log(1 + magft2);
img3 = uint8(rescale(ft2Spectrum2,0,255));

ft3 = ifftshift(ft2);
invft = ifft2(ft3);
img4 = uint8(rescale(abs(invft),0,255));

f1 = figure;
subplot(2,2,1), imshow(img1);
subplot(2,2,2), imshow(img2);
subplot(2,2,3), imshow(img3);
subplot(2,2,4), imshow(img4);
impixelinfo(f1);

function [noiseMat] = generateSinNoise(rows, cols, cycles, factor)
    vals = linspace(-cycles*pi, cycles*pi, cols);
    sinWave = sin(vals);
    noiseMat = repmat(sinWave, rows, 1);
    noiseMat = factor*noiseMat;
end

function [noiseMatrix] = generateVertLineNoise(spacing, width, value, rows, cols)
    noiseMatrix = zeros(rows, cols);
    for idx = 1:width
        noiseMatrix(:, idx:spacing:end) = value;
    end
end

function [noiseMatrix] = generateHoriLineNoise(spacing, width, value, rows, cols)
    noiseMatrix = zeros(rows, cols);
    for idx = 1:width
        noiseMatrix(idx:spacing:end, :) = value;
    end
end

function [filter] = generateIdealLPFilter(cutoff, rows, cols)
    x = (1:rows) - (rows / 2);
    y = (1:cols) - (cols / 2);

    [X,Y] = meshgrid(x, y);

    filter = double((X.*X + Y.*Y) < cutoff*cutoff);
end

function [filter] = generateButterworthFilter(cutoff, order, rows, cols)
    x = (1:rows) - (rows / 2);
    y = (1:cols) - (cols / 2);

    [X,Y] = meshgrid(x, y);

    temp = (sqrt(X.*X + Y.*Y)/cutoff) .^ (2*order);
    filter = 1 ./ (1 + temp);
end