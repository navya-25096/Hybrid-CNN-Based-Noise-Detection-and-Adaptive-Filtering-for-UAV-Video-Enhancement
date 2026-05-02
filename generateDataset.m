clc; clear; close all;

% Delete old dataset
if exist('dataset','dir')
    rmdir('dataset','s');
end

% Create folders (NOW 6 CLASSES)
mkdir('dataset/motion')
mkdir('dataset/impulse')
mkdir('dataset/propeller')
mkdir('dataset/compression')
mkdir('dataset/lowlight')
mkdir('dataset/blur')

video = VideoReader('videos/drone.mp4');

i = 1;
while hasFrame(video) && i <= 2120
    
    frame = readFrame(video);
    gray = imresize(gray,[32 32]);

    h = fspecial('motion',15,0);
    imwrite(imfilter(gray,h), sprintf('dataset/motion/img_%d.png', i));

    imwrite(imnoise(gray,'salt & pepper',0.1), ...
    sprintf('dataset/impulse/img_%d.png', i));

    [X,Y] = meshgrid(1:size(gray,2),1:size(gray,1));
    prop = uint8(20*sin(0.1*X));
    imwrite(prop, ...
    sprintf('dataset/propeller/img_%d.png', i));

    imwrite(gray,'temp.jpg','Quality',randi([5 20]));
    comp = imread('temp.jpg');
    imwrite(comp, ...
    sprintf('dataset/compression/img_%d.png', i));

    low = im2double(gray)*0.6;
    low = low * (0.2 + rand()*0.3);   % darker
    low = imnoise(low,'gaussian',0,0.01);
    imwrite(im2uint8(low), ...
    sprintf('dataset/lowlight/img_%d.png', i));

    blur = imgaussfilt(gray,1.5);
    imwrite(blur, ...
    sprintf('dataset/blur/img_%d.png', i));

    i = i + 1;
end

disp("✅ Dataset with 6 noise types created")
