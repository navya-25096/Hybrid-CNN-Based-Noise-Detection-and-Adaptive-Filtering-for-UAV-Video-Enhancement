function type = detectVideoNoiseCNN(frames)

load('model/noiseCNN.mat');

for i=1:length(frames)
    img = imresize(frames{i},[32 32]);
    img = reshape(img,[32 32 1]);
    label = classify(net,img);
    type{i} = char(label);
end
end
