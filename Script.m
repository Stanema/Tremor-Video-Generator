%% Circle
clc, clear all;

M=200; N=200; %matrix dimensions
cx=100; cy=100; %center
r=80;%radius
x=(1:M).'; y=1:N;
A=(x-cx).^2 + (y-cy).^2 <= r^2;
A = bwperim(A); 
A = imdilate(A, strel('disk',0)); %thickness


n = 0;
Array = cell(n, 1);
Array1 = cell(n, 1);

for i = 1:M/2
  for j = N/2:N
    if A(i,j) == 1;
        A1 = zeros(M, N, 3);
        A1(i,j,:) = 1;
        Array{i} = A1;
        A2 = flipdim(A1, 1);
        Array1{i} = flipdim(A2, 2);
    end
  end
end
for i = M/2:M
  for j = N/2:N
    if A(i,j) == 1;
        A1 = zeros(M, N, 3);
        A1(i,j,:) = 1;
        Array{i} = A1;
        A2 = flipdim(A1, 1);
        Array1{i} = flipdim(A2, 2);
    end
  end
end

Array1=Array1(~cellfun('isempty',Array1));
Array=Array(~cellfun('isempty',Array));
Array = cat(1,Array,Array1);
%imshow(A);

%% Line
clc, clear all;

M=500; N=500; %dimentions
%Sx= 250; Sy = 250; %startpoint 
A = zeros(M,N,3);
n = 0 ;
Array = cell(n, 1);
 
for j = 100:400 %width
  for i = 245:255 %height
    A(i,j,:) = 1;
    %A(i,j-10,:) = 0; %block or line
    Array{j} = A; 
  end
end
Array=Array(~cellfun('isempty',Array));
%imshow(A);

%%  Bigger/Smaller
clc, clear all;

M=200; N=200; %matrix dimensions
a=50; %square dimension
x= 1; %dispersion

A = zeros(M, N, 3);
A1=A;
n = 0 ;
Array = cell(n, 1);

A((M/2-a/2):(M/2+a/2),(M/2-a/2):(M/2+a/2), :) = 1;
A1((M/2-a/2)-x:(M/2+a/2)+x,(M/2-a/2)-x:(M/2+a/2)+x, :) = 1;

for i = 1:2:201
    Array{i} = A;
    Array{i+1} = A1;
end

%% Verical tremor
clc, clear all;

M=200; N=200; %matrix dimensions
a=50; %square dimension
x= 5; %dispersion

A = zeros(M, N, 3);
A1=A;
n = 0 ;
Array = cell(n, 1);

A((M/2-a/2):(M/2+a/2),(M/2-a/2):(M/2+a/2), :) = 1;
A1((M/2-a/2):(M/2+a/2),(M/2-a/2)+x:(M/2+a/2)+x, :) = 1;

for i = 1:2:201
    Array{i} = A;
    Array{i+1} = A1;
end

%% Tremor
clc, clear all;

M=200; N=200; %matrix dimensions
a=50; %square dimension
x= 5; %dispersion

A1 = zeros(M, N, 3);
A2=A1;
A3=A1;
A4=A1;
n = 0 ;
Array = cell(n, 1);

A1((M/2-a/2)-x:(M/2+a/2)-x,(M/2-a/2)-x:(M/2+a/2)-x, :) = 1;
A2((M/2-a/2)-x:(M/2+a/2)-x,(M/2-a/2)+x:(M/2+a/2)+x, :) = 1;
A3((M/2-a/2)+x:(M/2+a/2)+x,(M/2-a/2)+x:(M/2+a/2)+x, :) = 1;
A4((M/2-a/2)+x:(M/2+a/2)+x,(M/2-a/2)-x:(M/2+a/2)-x, :) = 1;

for i = 1:4:401
    Array{i} = A1;
    Array{i+1} = A2;
    Array{i+2} = A3;
    Array{i+3} = A4;
end

%% Video creation

video = VideoWriter('video.avi');
open(video);
for i=1:length(Array)
  Frame = im2frame(Array{i});
  writeVideo(video,Frame); %write the image to file
end
close(video);

%% Play video
Frames=zeros(M,N);

for i=1:length(Array)
  Frames(:,:,i) = im2bw(Array{i});
end
implay(Frames);