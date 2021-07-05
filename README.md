# Skellam-Edge-Detector
Background Subtraction and Edge Detection using Skellam Distribution
## Description
Here, we show the usage of Skellam Distribution for Edge Detection in Spatial Domain and Background Subtraction in Temporal Domain. For dataset, we take natural images and videos and also generate images and videos synthetically. We analyse the results of Edge Detection by comparing it with [Canny Edge Detector](https://en.wikipedia.org/wiki/Canny_edge_detector) and Background Subtraction manually.
## Usage
### Edge Detection
* **Natural Image** : Replace the img_path in `pipeline.m` with the path of your image and the result will give three images - the original noisy image, image after applying skellam edge detection, and image after applying canny edge detection
* **Synthetic Image** : Specify the size M by N of the imagein `pipeline.m` and the result will give three images - the synthetic noisy image, image after applying skellam edge detection, and image after applying canny edge detection
### Background Subtraction
* **Natural Video** : Replace the vid_path in `pipeline.m` with the path of your video and the result will give two images - the first frame of the original video, and the background subtracted frame. The background subtracted video is created in the provided output_path
* **Synthetic Video** : Specify the size of each frame M by N and the number of frames T, a synthetic video is created at the path specified by vid_path and the result will give two images - the first frame of the synthetic video, and the background subtracted frame. The background subtracted video is created in the provided output_path
