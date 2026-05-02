clc; clear; close all;

% LOAD DATASET
imds = imageDatastore('dataset', ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

imds.ReadFcn = @(x) imresize(im2gray(imread(x)), [32 32]);

disp(countEachLabel(imds))

% HARDER SPLIT 
[trainDS, testDS] = splitEachLabel(imds, 0.745, 'randomized');

numClasses = numel(categories(trainDS.Labels));

% STRONGER AUGMENTATION
augmenter = imageDataAugmenter( ...
    'RandRotation',[-25 25], ...
    'RandXTranslation',[-5 5], ...
    'RandYTranslation',[-5 5], ...
    'RandXScale',[0.85 1.15], ...
    'RandYScale',[0.85 1.15]);

augTrain = augmentedImageDatastore([32 32 1], trainDS, ...
    'DataAugmentation', augmenter);

augTest = augmentedImageDatastore([32 32 1], testDS);

% CNN 
layers = [
imageInputLayer([32 32 1])

convolution2dLayer(3,16,'Padding','same')
batchNormalizationLayer
reluLayer
maxPooling2dLayer(2,'Stride',2)

convolution2dLayer(3,32,'Padding','same')
batchNormalizationLayer
reluLayer
maxPooling2dLayer(2,'Stride',2)

convolution2dLayer(3,64,'Padding','same')
batchNormalizationLayer
reluLayer

fullyConnectedLayer(numClasses)
dropoutLayer(0.5) 
softmaxLayer
classificationLayer];

% TRAINING OPTIONS (PREVENT OVERFITTING)
options = trainingOptions('adam', ...
    'MaxEpochs', 10, ...            
    'MiniBatchSize', 32, ...
    'InitialLearnRate', 8e-4, ...    
    'Shuffle', 'every-epoch', ...
    'ValidationData', augTest, ...       'ValidationFrequency', 10, ...
    'Verbose', false, ...
    'Plots', 'training-progress');

% TRAIN
net = trainNetwork(augTrain, layers, options);

% TEST
YPred = classify(net, augTest);
YTest = testDS.Labels;

acc = mean(YPred == YTest);
disp(" Accuracy: " + acc*100 + "%")

% SAVE
if ~exist('model','dir')
    mkdir('model');
end

save('model/noiseCNN.mat', 'net');
