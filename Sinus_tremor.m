%% sinus tremor
clc, clear all;

% Video definition
M=500; N=500; %matrix dimensions
m = 100; n = 100; %center of square (default values = m = M/2, n = N/2)
a=50; %object dimension
fps = 60; %fps
d = 2; %duration of video (in seconds)
f = 5; % frequency(in Hz)
amp = M/4; %amplitude (default value = axis/4)
noise = 0.001; %noise (0 = no noise, default noise = 0.001)
noise_type = 'gaussian'; % ('salt & pepper' or 'gaussian')
name="Video_"+fps+"fps_"+f+"Hz_";

%% sinus definition
ff= f/(fps/(2*pi));
t = 0:ff:fps*ff*d;
sinus = sin(t);
sinus = sinus*amp;
sinus = round(sinus);

%% Y axis square tremor
try
    for i = 1:length(sinus)
        Array{i} = zeros(M, N, 3);
        Array{i} = imnoise(Array{i},noise_type,noise);
        Array{i}((m-a/2)-sinus(i):(m+a/2)-sinus(i),(n-a/2):(n+a/2), :) = 1;
    end
    name = name+"Y_axis_square_tremor.avi";
catch
    warning('Problem using function.  Setting to default values');
    m = M/2; n = N/2; %center of square (default values = m = M/2, n = N/2)
    a=50; %object dimension
    amp = M/4;
end
%% X axis square tremor
try
for i = 1:length(sinus)
    Array{i} = zeros(M, N, 3);
    Array{i} = imnoise(Array{i},noise_type,noise);
    Array{i}((m-a/2):(m+a/2),(n-a/2)-sinus(i):(n+a/2)-sinus(i), :) = 1;
end
name = name+"X_axis_square_tremor.avi";
catch
    warning('Problem using function.  Setting to default values');
    m = M/2; n = N/2; %center of square (default values = m = M/2, n = N/2)
    a=50; %object dimension
    amp = M/4;
end
%% Y axis circle tremor
try
x=(1:M).';
y=1:N;
for i = 1:length(sinus)
    r=a/2;
    A = zeros(M, N, 3);
    A=(x-(m - sinus(i))).^2 + (y-n).^2 <= r^2; 
    A = 255 * repmat(uint8(A), 1, 1, 3);
    Array{i} = A;
    Array{i} = imnoise(Array{i},noise_type,noise);
end
name = name+"Y_axis_circle_tremor.avi";
catch
    warning('Problem using function.  Setting to default values');
    m = M/2; n = N/2; %center of square (default values = m = M/2, n = N/2)
    a=50; %object dimension
    amp = M/4;
end
%% X axis circle tremor
try
x=(1:M).';
y=1:N;
for i = 1:length(sinus)
    r=a/2;
    A = zeros(M, N, 3);
    A=(x-m).^2 + (y-(n - sinus(i))).^2 <= r^2;  
    A = 255 * repmat(uint8(A), 1, 1, 3);
    Array{i} = A;
    Array{i} = imnoise(Array{i},noise_type,noise);
end
name = name+"X_axis_circle_tremor.avi";
catch
    warning('Problem using function.  Setting to default values');
    m = M/2; n = N/2; %center of square (default values = m = M/2, n = N/2)
    a=50; %object dimension
    amp = M/4;
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
implay(Frames, fps);