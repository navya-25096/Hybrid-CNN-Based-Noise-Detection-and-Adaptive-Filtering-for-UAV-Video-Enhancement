clc; clear; close all;

addpath('functions')
addpath('model')

if ~exist('output','dir')
    mkdir('output');
end

disp("=== UAV VIDEO NOISE REDUCTION STARTED ===")

%LOAD VIDEO
frames = loadVideo('videos/drone.mp4');

% CONVERT TO GRAYSCALE
grayFrames = cell(size(frames));
for i = 1:length(frames)
    grayFrames{i} = im2gray(frames{i});
end

% ADD NOISE
noisyFrames = addNoise(grayFrames);

% DETECT NOISE USING CNN
noiseType = detectVideoNoiseCNN(noisyFrames);

% APPLY FILTER
filteredFrames = applyFilter(noisyFrames, noiseType);

% QUALITY EVALUATION (ALL METRICS)
[psnrVal, mseVal, ssimVal, maeVal, entropyVal, niqeVal] = ...
    evaluateQuality(filteredFrames, grayFrames);

% DISPLAY AVERAGE VALUES
disp("----- QUALITY METRICS -----")
disp("PSNR (dB): " + mean(psnrVal))
disp("SSIM: " + mean(ssimVal))
disp("MSE: " + mean(mseVal))
disp("MAE: " + mean(maeVal))
disp("Entropy: " + mean(entropyVal))
disp("NIQE: " + mean(niqeVal))

% SAVE VIDEO
v = VideoWriter('output/clean_video.avi');
open(v)

for i = 1:length(filteredFrames)
    frame = filteredFrames{i};

    if isa(frame,'double')
        frame = im2uint8(frame);
    end

    writeVideo(v, frame);
end

close(v)

disp("Video saved in output folder")

%PLOTTING ALL GRAPHS


figure('Name','Quality Metrics','NumberTitle','off')

subplot(3,2,1)
plot(psnrVal,'LineWidth',2)
title('PSNR vs Frame')
xlabel('Frame Number')
ylabel('PSNR (dB)')
grid on

subplot(3,2,2)
plot(ssimVal,'LineWidth',2)
title('SSIM vs Frame')
xlabel('Frame Number')
ylabel('SSIM')
grid on

subplot(3,2,3)
plot(mseVal,'LineWidth',2)
title('MSE vs Frame')
xlabel('Frame Number')
ylabel('MSE')
grid on

subplot(3,2,4)
plot(maeVal,'LineWidth',2)
title('MAE vs Frame')
xlabel('Frame Number')
ylabel('MAE')
grid on

subplot(3,2,5)
plot(entropyVal,'LineWidth',2)
title('Entropy vs Frame')
xlabel('Frame Number')
ylabel('Entropy')
grid on

subplot(3,2,6)
plot(niqeVal,'LineWidth',2)
title('NIQE vs Frame')
xlabel('Frame Number')
ylabel('NIQE')
grid on

sgtitle('Performance Evaluation Metrics')
