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
%% Video

video = VideoWriter('video.avi');
open(video);
for i=1:length(Array)
  Frame = im2frame(Array{i});
  writeVideo(video,Frame); %write the image to file
end
close(video);


 