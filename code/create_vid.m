function [frames, vid] = create_vid(m, n, T, path)
    % Takes the size m \times n and the number of frames T as input, and
    % generates an avi video in a random manner, returning its frames and
    % its struct object
    fps = 20 ;
    frames = zeros(m, n, T) ;
    img = zeros(m, n) ;
    % every frame contains some patches with a fixed size
    patch_size = m/4 ; 
    % set the noise scale to be added
    scale = 1/50 ; 
    % Set the intensity value of each patch randomly, a single patch has a
    % constant intensity throughout
    for i=1:patch_size:m
        for j=1:patch_size:n
            img(i:i+patch_size-1, j:j+patch_size-1) = randi([0 255])*ones(patch_size, patch_size) ;
        end
    end
    % Add an object of size x times y
    x = uint16(m/10) ;
    y = uint16(n/10) ;
    object = zeros(x, y) ;
    % (start_x, start_y) denotes the starting position of the object
    start_y = uint16(randi([2*y 8*y])) ;
    start_x = uint16(1) ;
    % construct the video frame-by-frame
    for i=1:T
        frames(:, :, i) = img ;
        if (i>=(T/2)) && (i<(11*T/20))
            % Change the starting position of object to simulate a moving
            % object, the intensity where the object is placed becomes 0
            start_x = uint16(start_x + uint16(18*m/T)) ; 
            frames(start_x:(start_x+x-1), start_y:(start_y+y-1), i) = object ;
        end
        % Add poisson random noise to the image 
        frames(:,:,i) = frames(:,:,i) + poissrnd(scale*frames(:,:,i)) - scale*frames(:,:,i);
    end
    
    obj = write_vid(path, fps, frames) ;
    vid = VideoReader(path) ;
end