function img = gaussian_noise(sigma, input_img)
  noise = randn(size(input_img)) .* sigma;
  disp(noise);
  img = input_img + uint8(noise);
end