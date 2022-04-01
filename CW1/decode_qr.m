function [final_array] = decode_qr(input_image)
    qr_length = length(input_image);
    horizontal_ratios = [];
    bw_img = imbinarize(input_image, 0.55);

    for row = 1 : qr_length
        row_line = bw_img(row,:);
        module_length = ratio_finder(row_line);
        horizontal_ratios = cat(2, horizontal_ratios, module_length);
    end

    modulepixel_size = mode(horizontal_ratios);
    module_size = round(length(input_image) / modulepixel_size);
    final_array = decode_qr_module(input_image, module_size);
end

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