Vid_Filename = 'videos/Video1.mp4';
vReader1 = VideoReader(Vid_Filename);
videoPlayer1 = vision.VideoPlayer;
vReader1.FrameRate;

while hasFrame(vReader1)
    frame = readFrame(vReader1);
    videoPlayer1(frame);
    pause(1/vReader1.FrameRate);
end