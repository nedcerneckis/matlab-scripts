%Threshold = adaptthresh(img, 1);
%bw_img = imbinarize(img, Threshold);
%kernel = [-1, -1, -1; -1, 17, -1; -1, -1, -1]/ 9;
%bw_img = conv2(double(bw_img), kernel, 'same');
%imshow(bw_img);
clear variables;
img37 = imread('images/QR_2.jpeg');
img29 = imread('images/QR_2.jpeg');
horizontal_ratios = [];
bw_img = imbinarize(img37, 0.55);
for row = 1 : 178
    Tr_Line = bw_img(row,:);
    length_modules = ratio_finder(Tr_Line);
    horizontal_ratios = cat(2,horizontal_ratios,length_modules);
end

module_size = mode(horizontal_ratios);
disp(module_size);

decoded_qr = decode_qr_module(img29, module_size);
imshow(decoded_qr);

function [ratio_array] = ratio_finder(in_array)
    vector_length = length(in_array);
    ratio_array = ones(1, vector_length);
    k = 1;

    for i = 1 : vector_length-1
        if(in_array(i) == in_array(i+1))
            ratio_array(k) = ratio_array(k) + 1;
        else
            k = k + 1;
        end
    end

    ratio_array = ratio_array(1:k);
end