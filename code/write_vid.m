function [vid] = write_vid(path, fps, frames)
    % Takes the frames as input and rolls them into a video with the given
    % fps speed and saves the video at the specified path
    vid = VideoWriter(path);
    vid.FrameRate = fps;
    % open the video writer
    open(vid);
    % write the frames to the video
    for i=1:size(frames, 3)
         % convert the image to a frame
         frame = im2frame(uint8(frames(:, :, i)), gray);
         writeVideo(vid, frame);
     end
     % close the video object
     close(vid);
end