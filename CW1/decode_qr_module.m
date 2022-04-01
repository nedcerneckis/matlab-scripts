function [final_array] = decode_qr_module(input_image, module_size)
    qr_length = size(input_image, 1);
    modulepixel_size = round(qr_length/module_size);
    max_size = modulepixel_size * module_size;

    Threshold = adaptthresh(input_image, 1);
    bw_img = imbinarize(input_image, Threshold);
    bw_img = imresize(bw_img, [max_size max_size]);
    binary_array = zeros(module_size);
    indexRow = 1;

    for row = 1:modulepixel_size:max_size
        indexCol = 1;
        for col = 1:modulepixel_size:max_size
            portion = bw_img(row:row+(modulepixel_size-1),col:col+(modulepixel_size-1));
            mode_value = mode(portion, 'all');
            binary_array(indexRow, indexCol) = mode_value;
            indexCol = indexCol + 1;
        end
        indexRow = indexRow + 1;
    end

    final_array = binary_array;
end