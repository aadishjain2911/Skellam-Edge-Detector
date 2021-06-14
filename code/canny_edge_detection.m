function [canny] = canny_edge_detection(frames, H, W) 
% This function takes vectorized video frames as input and applies
% canny edge detection on every frame 
    canny = zeros(H, W, size(frames, 2)) ;
    for i=1:size(frames, 2)
        canny(:,:,i) = edge(reshape(frames(:,i), H, W), 'canny');
    end
end