%% sinus tremor
clc, clear all;

M=200; N=200; %matrix dimensions
m = M/2; n = N/2; %center of square
a=50; %square dimension
x= 5; %dispersion of tremor
tf = 240; %total of frames
fps = 5; %fps


Array = cell(0, 1);
A1 = zeros(M, N, 3);
A2=A1;
A3=A1;
A4=A1;

A1((m-a/2)-x:(m+a/2)-x,(n-a/2)-x:(n+a/2)-x, :) = 1;
A2((m-a/2)-x:(m+a/2)-x,(n-a/2)+x:(n+a/2)+x, :) = 1;
A3((m-a/2)+x:(m+a/2)+x,(n-a/2)+x:(n+a/2)+x, :) = 1;
A4((m-a/2)+x:(m+a/2)+x,(n-a/2)-x:(n+a/2)-x, :) = 1;

for i = 1:4:(tf+1)
    Array{i} = A1;
    Array{i+1} = A2;
    Array{i+2} = A3;   
    Array{i+3} = A4;
end

%% Video creation

video = VideoWriter('video.avi');
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