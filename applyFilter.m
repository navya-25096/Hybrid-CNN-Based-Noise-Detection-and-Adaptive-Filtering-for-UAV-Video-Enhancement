function filteredFrames = applyFilter(frames, noiseType)

filteredFrames = cell(size(frames));

for i = 1:length(frames)
    img = frames{i};
    img = im2double(img);
    
    if nargin < 2 || isempty(noiseType)
        type = 'unknown';
    else
        type = lower(noiseType{i});
    end

    switch type
        case 'impulse'
            filtered = medfilt2(img,[3 3]);
        case 'motion'
            h = fspecial('motion',15,45);
            filtered = deconvwnr(img,h,0.001);
        case 'propeller'
            F = fft2(img);
            Fshift = fftshift(F);

            [rows, cols] = size(img);
            mask = ones(rows,cols);
            mask(:, round(cols/2)-4:round(cols/2)+4) = 0;

            Fshift = Fshift .* mask;
            filtered = real(ifft2(ifftshift(Fshift)));
        case 'compression'
            filtered = wiener2(img,[3 3]);
        case 'lowlight'
            filtered = adapthisteq(img,'ClipLimit',0.01);
        case 'blur'
            filtered = imsharpen(img,'Radius',1.5,'Amount',1.5);
        otherwise
            filtered = img;
    end

    filtered = max(min(filtered,1),0);
    filtered = imbilatfilt(filtered);
    filteredFrames{i} = im2uint8(filtered);

end

end
