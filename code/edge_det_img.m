function [edge_img] = edge_det_img(frame)
    % Takes the path to an image as input and returns the corresponding
    % edge-frame after applying skellam edge detection
    if size(frame, 3)==3
        frame = rgb2gray(frame) ;
    end
%     frame = imbilatfilt(frame) ;
    H = size(frame, 1) ;
    W = size(frame, 2) ;
    
    alpha = 1 - 1e-5 ;
    % Every patch will be of size (2*half_patch_size+1) by (2*half_patch_size+1)
    half_patch_size = 2 ;
    
    mu_s = zeros(H, W) ;
    var_s = zeros(H, W) ;
    
    for h=1:H
        for w=1:W
            % For every pixel, construct the patch of given size in such a
            % way that the pixel is at the center of the patch
            patch = frame(max(h-half_patch_size, 1):min(h+half_patch_size,H), max(w-half_patch_size, 1):min(w+half_patch_size,W)) ;
            % get the statistics of the skellam distribution for that patch
            [mu_s(h,w), var_s(h,w)] = get_mu_s(patch);
        end
    end
    
    % calculating the skellam parameters
    u1 = (mu_s+var_s)/2;
    u2 = (-mu_s+var_s)/2;
    
    % calculating the intensity acceptance values
    I_A = get_Ia(reshape(u1, [], 1), reshape(u2, [], 1), alpha) ;
    I_A = reshape(I_A, H, W) ;
    
    
    padded_x = padarray(frame, [0,1,0], 0, 'pre');
    padded_y = padarray(frame, [1,0,0], 0, 'pre');
    
    edge_img = zeros(H, W);
    edge_img = logical(edge_img ~= 0);
    
    % calculating derivatives in horizontal and vertical directions
    % pixel-wise
    d_x = abs(padded_x(1:H, 1:W) - frame) ;
    d_y = abs(padded_y(1:H, 1:W) - frame) ;
    
    % calculating edge measures in each direction
    edge_mask_x = d_x>I_A;
    edge_mask_y = d_y>I_A;
    
    % calculating total edge measures by discarding the pixels with zero
    % edge measure for both the directions to get edge image
    edge_img(edge_mask_x(:,:)) = 1;
    edge_img(circshift(edge_mask_x(:,:),-1,2)) = 1;
    
    edge_img(edge_mask_y(:,:)) = 1;
    edge_img(circshift(edge_mask_y(:,:),-1,1)) = 1;
end





