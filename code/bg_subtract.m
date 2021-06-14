function [fg_frames] = bg_subtract(vid_frames, H, W)
    % Takes the grayscale frames of the video and size of each frame as input, and returns the foreground
    % frames i.e. frames created after subtracting the background
    frames = zeros(H*W, 1) ;
    for i=1:size(vid_frames, 3)
        frames(:,i) = reshape(vid_frames(:,:,i), [], 1) ;
    end
    inten_diff = frames ;
    
    % inten_diff denotes the absolute difference between the current frame
    % and the background 
    for i=1:size(frames, 2)-1
        inten_diff(:,i+1) = abs(frames(:,i+1) - frames(:,1)) ;
    end
    
    inten_diff = inten_diff(:, 2:end) ;
    
    % denotes the pixel-wise statistics of the difference distribution
    mu_s = mean(inten_diff, 2) ;
    var_s = var(inten_diff, 0, 2) ;
    % Here we assumed that the object is present in only some of the frames
    % of the original video
    
    % u1, u2 denote the pixel-wise skellam parameters
    u1 = (mu_s+var_s)/2 ;
    u2 = (-mu_s+var_s)/2 ;
    
    p = zeros(256*2 - 1, size(u1, 1)) ;
    diff = -255:1:255 ;
    thr_int = ones(size(u1)) ;
    alpha = 1 - 1e-5 ;
   
    % calculating the noise distribution using the skellam paramaters
    for i=1:size(p)
        p(i,:) = exp(-u1-u2).*(u1./u2).^(diff(i)/2).*besseli(abs(diff(i)), 2*sqrt(u1.*u2)) ;
    end
    
    for j=1:size(u1,1)
        % F is analogous to the cdf of noise distribution
        F = cumsum(p(:,j)) ;
        for i=1:255
            if (F(256+i) - F(256-i) < alpha)
                % threshold intensity denotes the maximum intensity
                % difference with probability of occurrence alpha
                thr_int(j) = i;
            end
        end
    end
    
    fg_masks = false(size(frames)) ;
    fg_frames = false(H, W, size(frames, 2)-1) ;
    
    for i=1:size(inten_diff, 2)
        % If the intensity difference at a given point is greater than the
        % threshold intensity, it should be part of the foreground
        fg_masks(:,i) = inten_diff(:,i)>thr_int ;
        fg_frames(:,:,i) = reshape(fg_masks(:,i), H, W) ;
    end
end




