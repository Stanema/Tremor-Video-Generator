%% sinus tremor
clc, clear all;

% Video definition
M=1500; N=1500; %matrix dimensions
m = M/2; n = N/2; %center of square
a=50; %square dimension
fps = 60; %fps
name='Video.avi';

%% sinus definition
t = 0:0.1:8*pi;
y = sin(t);
y = y*100;
y = round(y);

%% Y axis tremor
for i = 1:length(y)
    Array{i} = zeros(M, N, 3);
    Array{i}((m-a/2)-y(i):(m+a/2)-y(i),(n-a/2):(n+a/2), :) = 1;
end

%% X axis tremor
for i = 1:length(y)
    Array{i} = zeros(M, N, 3);
    Array{i}((m-a/2):(m+a/2),(n-a/2)-y(i):(n+a/2)-y(i), :) = 1;
end

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