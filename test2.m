clear variables;
img37 = imread('images/QR_2.jpeg');
Threshold = adaptthresh(img37, 1);
bw_img = imbinarize(img37, Threshold);

%function out = Mod_Tr_Fn(vector)
%If the vector in is [0 0 1 0 1 1 1 0 0], out = [2 1 1 3 2].
function out = Mod_Tr_Fn(In)
    % allocate with ones
    out = ones(1,length(In));
    k=1;
    
    for i = 1 : length(In)-1
        if (In(i) == In(i+1))
            out(k) = out(k) + 1;
        else
            k = k + 1;
        end
    end

    out = out(1:k);
end

function [out, moduleSize] = checkRatio_Fn(A, Pat)
    % total size of all the pixels in the sequence we looking at
    Size = sum(A);
    
    % size of the modules, ex 7 for the FIP-finder
    pat_Size = sum(Pat);
    
    % if smaller than pattern size, no pattern found
    if(Size < pat_Size)
        out = false;
    end

    % Calculate the size of one module
    Cor_coeff = 0.4;    % Deafaul is 0.4
    moduleSize = (Size / pat_Size);
    
    % how much the pattern can vary and still be acceptable. 
    maxV = moduleSize * Cor_coeff;

    % determine if the vector is good enough
    if(abs( moduleSize .* Pat - A) <= maxV)
        out = true;
    else
        out = false;

    end
end