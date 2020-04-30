%% sinus tremor
clc, clear all;

% Video definition
M=500; N=500; %matrix dimensions
m = M/2; n = N/2; %center of square
a=50; %square dimension
fps = 60; %fps
d = 2; %duration of video (in seconds)
f = 5; % frequency(in Hz)
r = M/4; %amplitude (recomanded value = axis/4)
name="Video_"+fps+"fps_"+f+"Hz_";

%% sinus definition
ff= f/(fps/(2*pi));
t = 0:ff:fps*ff*d;
y = sin(t);
y = y*r;
y = round(y);

%% Y axis tremor
for i = 1:length(y)
    Array{i} = zeros(M, N, 3);
    Array{i}((m-a/2)-y(i):(m+a/2)-y(i),(n-a/2):(n+a/2), :) = 1;
end
name = name+"Y_axis_tremor.avi";
%% X axis tremor
for i = 1:length(y)
    Array{i} = zeros(M, N, 3);
    Array{i}((m-a/2):(m+a/2),(n-a/2)-y(i):(n+a/2)-y(i), :) = 1;
end
name = name+"X_axis_tremor.avi";

%% Video creation
video = VideoWriter(name);
video.FrameRate = fps;
open(video);
for i=1:length(Array)
  Frame = im2frame(Array{i});
  writeVideo(video,Frame); %write the image to file
end
close(video);

%% Play video
Frames=zeros(M,N);

for i=1:length(Array)
  Frames(:,:,i) = rgb2gray(Array{1,i});
end
implay(Frames);
