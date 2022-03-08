function [final_array] = decode_qr(input_image)
    % work out module size
    % example below is hard-coded
    module_size = 29;
    final_array = decode_qr_module(input_image, module_size);
end