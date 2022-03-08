img = imread('images/QR_2.jpeg');
%Threshold = adaptthresh(img, 1);
%bw_img = imbinarize(img, Threshold);
%kernel = [-1, -1, -1; -1, 17, -1; -1, -1, -1]/ 9;
%bw_img = conv2(double(bw_img), kernel, 'same');
%imshow(bw_img);

%for row = 1 : 178 
%    Tr_Line = BW(row,:)
%    length_modules = ratio_finder(Tr_Line)
%end

binary_matrix_test = decode_qr(img2, 37);
figure;
subplot(1,2,1), imshow(img);
subplot(1,2,2), imshow(binary_matrix_test);

function [ratio_array] = ratio_finder(in_array)
    ratio_array = ones(1, length(in_array));
    k=1;
    for i = 1 : length(in_array)-1
        if(in_array(i) == in_array(i+1))
            ratio_array(k) = ratio_array(k) + 1;
        else
            k = k + 1;
        end
    end

    ratio_array = out(1:k);
end