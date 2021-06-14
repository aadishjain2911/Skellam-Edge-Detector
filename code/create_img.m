function [img, noisy_img] = create_img(m, n, path)
% Takes the size m \times n as input, and returns two grayscale images - one with
% noise and one without noise which are generated in a random manner
    img = zeros(m, n) ;
    % frame contains some patches with a fixed size
    patch_size = m/4 ;
    % set the noise scale to be added
    scale = 1/10 ;
    % Set the intensity value of each patch randomly, a single patch has a
    % constant intensity throughout
    for i=1:patch_size:m
        for j=1:patch_size:n
            img(i:i+patch_size-1, j:j+patch_size-1) = randi([0 255])*ones(patch_size, patch_size) ;
        end
    end
    % Add poisson random noise to the image 
    noisy_img = img + poissrnd(scale*img) - scale*img;
    imwrite(uint8(noisy_img), path) ;
end