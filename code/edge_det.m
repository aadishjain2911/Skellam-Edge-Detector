function [edge_frames] = edge_det(vid_path, start_frame, end_frame)
    % Takes the path to a video, starting frame number and ending frame
    % number as input, and returns the corresponding edge-frames from the video
    % after applying skellam edge detection
    [frames, object] = read_frames(vid_path) ;
    H = object.Height ;
    W = object.Width ;
    num_frames = object.numFrames ;
    
    alpha = 1 - 0.025 ;
    half_patch_size = 2 ;
    edge_frames = zeros(H, W, end_frame - start_frame + 1) ;
    
    % applying the same procedure for every frame
    for i=start_frame:min(num_frames, end_frame)
        frame = reshape(frames(:,i), H, W) ;
    %     frame = imbilatfilt(frame) ;
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
        d_x = padded_x(1:H, 1:W) - frame ;
        d_y = padded_y(1:H, 1:W) - frame ;
        
        % calculating edge measures in each direction
        edge_mask_x = abs(d_x)>I_A;
        edge_mask_y = abs(d_y)>I_A;
        
        % calculating total edge measures by discarding the pixels with zero
        % edge measure for both the directions to get edge image
        edge_img(edge_mask_x(:,:)) = 1;
        edge_img(circshift(edge_mask_x(:,:),-1,2)) = 1;
        
        edge_img(edge_mask_y(:,:)) = 1;
        edge_img(circshift(edge_mask_y(:,:),-1,1)) = 1;
        
        edge_frames(:, :, i - start_frame + 1) = edge_img ;
    end
end






