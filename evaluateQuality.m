function [psnrVal,mseVal,ssimVal,maeVal,entropyVal,niqeVal] = evaluateQuality(filtered, original)

n = length(filtered);

psnrVal = zeros(1,n);
mseVal = zeros(1,n);
ssimVal = zeros(1,n);
maeVal = zeros(1,n);
entropyVal = zeros(1,n);
niqeVal = zeros(1,n);

for i = 1:n
    
    f = filtered{i};
    o = original{i};

    f = im2double(f);
    o = im2double(o);

    psnrVal(i) = psnr(f,o);
    mseVal(i)  = immse(f,o);
    ssimVal(i) = ssim(f,o);
    maeVal(i) = mean(abs(f(:)-o(:)));
    entropyVal(i) = entropy(f);
    niqeVal(i) = niqe(f);

end

end
