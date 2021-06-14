M = 300 ;
N = 300 ;
T = 300 ;
fps = 20 ;
img_path = 'orig5.png' ;
noisy_img = imread(img_path) ;

% [img, noisy_img] = create_img(M, N, img_path) ;
% edge_img = edge_det_img(noisy_img) ;
% 
% figure(1);
% imshow(noisy_img./256);
% 
% figure(2);
% imshow(edge_img);
% 
% figure(3);
% imshow(edge(noisy_img, 'canny')) ;

vid_path = './sample_videos/syn_vid1.avi';
output_path = 'syn1_out.avi';

[frames, vid] = create_vid(M, N, T, vid_path);
fg_frames = bg_subtract(frames, M, N) ;
figure(1);
imshow(frames(:,:,1)./256) ;
figure(2);
imshow(fg_frames(:,:,1)) ;

% [frames, object] = read_frames(vid_path) ;
% M = object.Height ;
% N = object.Width ;
% T = object.numFrames ;
% fr = zeros(M, N, T) ;
% for i=1:T
%     fr(:, :, i) = reshape(frames(:,i), M, N) ; 
% end
% fg_frames = bg_subtract(fr, M, N) ;
% figure(1) ;
% imshow(fr(:,:,1)./256) ;
% figure(2) ;
% imshow(fg_frames(:,:,1)) ;

vid = write_vid(output_path, fps, fg_frames) ;