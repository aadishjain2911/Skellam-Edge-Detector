function [vectorized_gray_frames, video_object] = read_frames(vid)
    % This function takes path of a video as input and returns the
    % vectorized frames in grayscale along with the struct object of video
    video_object = VideoReader(vid) ;
    num_frames = video_object.NumFrames ;
    video_frames = read(video_object, [1 num_frames]) ;
    if (size(video_frames, 3)==3)
        vectorized_gray_frames = zeros(size(video_frames, 1)*size(video_frames, 2), size(video_frames, 4)) ;
        for i=1:size(video_frames, 4)
            temp = rgb2gray(video_frames(:, :, :, i)) ;
            vectorized_gray_frames(:, i) = reshape(temp, [], 1) ;
        end
    else
        vectorized_gray_frames = zeros(size(video_frames, 1)*size(video_frames, 2), size(video_frames, 3)) ;
        for i=1:size(video_frames, 3)
            temp = video_frames(:, :, i) ;
            vectorized_gray_frames(:, i) = reshape(temp, [], 1) ;
        end
    end
    
end

