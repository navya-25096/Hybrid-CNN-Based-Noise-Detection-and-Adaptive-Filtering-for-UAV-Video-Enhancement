function noisyFrames = addNoise(frames)

noisyFrames = cell(size(frames));

for i = 1:length(frames)

    img = frames{i};

    % Convert to double for safe operations
    img_d = im2double(img);

    % Random noise type (1–6)
    r = randi(6);

    switch r
        case 1
            noisy = imnoise(img_d,'salt & pepper',0.01);
        case 2
            len = randi([10 20]);
            theta = randi([0 180]);
            h = fspecial('motion',len,theta);
            noisy = imfilter(img_d,h,'replicate');
        case 3
            [X,Y] = meshgrid(1:size(img,2),1:size(img,1));
            noisy = img_d + 0.05*sin(0.2*X + 0.3*Y);
        case 4
            imwrite(im2uint8(img_d),'temp.jpg','Quality',randi([5 20]));
            noisy = im2double(imread('temp.jpg'));
        case 5
            scale = 0.6 + rand()*0.2;   % darkness
            noisy = img_d * scale;
            noisy = imnoise(noisy,'gaussian',0,0.01);
        case 6
            sigma = 2 + rand()*2;
            noisy = imgaussfilt(img_d,sigma);

    end

    % Convert back to uint8
    noisyFrames{i} = im2uint8(noisy);

end

end
