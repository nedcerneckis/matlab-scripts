im0 = imread('images/NewKuba_stereo_im0.png');
im1 = imread('images/NewKuba_stereo_im1.png');

L = rgb2gray(im0);
R = rgb2gray(im1);

subplot(2,2,1), imshow(im0);
subplot(2,2,2), imshow(im1);
subplot(2,2,3), imshow(L);
subplot(2,2,4), imshow(R);

[sx, sy, sz ] = size(L);
cxr = 141;
cyr = 351;
dx = 34;
dy = 34;

Rpatch = R(cxr:cxr+dx, cyr:cyr+dy);
cx = 141;
cy = 351;
inc = 1;
[max_nc, index_nc] = max(ncc(:));

Disp = zeros(sx, sy);
cxr = 1;
cyr = 1;
i = 1;
j = 1;

dx = 34;
dy = 34;
step = 35;
inc = 1;

cxr = 1;
i = 1;

while((cxr+dx) < (sx+1))
    cyr = 1;
    j = 1;

    while((cyr + dy) < (sy+1))
        Rpatch = R(cxr:cxr+dx, cyr:cyr+dx);
        cx = cxr;
        cy = cyr;
        k = 1;

        while((cyr+dy) < (sy+1))
            Lpatch = L(cx:cx+dx, cy:cy+dy)
            k = k + 1;
            cy = cy+inc;
        end
        [max_nc, index_nc] = max(ncc(:));
        Corr_max(i, j) = max_nc;
        Disp(i:i+dx, j+j+dy) = index_nc-1;
        ncc(:) = 0;
        j = j+step;
        cyr = cyr+step;
    end
i = i + step;
cxr = cxr + step;
end

baseline = 203.047;
f = 998.834;
doffs = 16;

Depth = f*baseline*ones(sx, sy) ./ (Disp+doffs);
figure, imshow(Depth, []);