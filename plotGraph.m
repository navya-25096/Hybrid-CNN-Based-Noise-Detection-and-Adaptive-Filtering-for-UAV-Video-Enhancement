function plotGraph(psnrVal, ssimVal, mseVal, maeVal, entropyVal, niqeVal)

figure('Name','Quality Metrics','NumberTitle','off')

% PSNR
subplot(3,2,1)
plot(psnrVal,'LineWidth',2)
title('PSNR vs Frame')
xlabel('Frame Number')
ylabel('PSNR (dB)')
grid on

% SSIM
subplot(3,2,2)
plot(ssimVal,'LineWidth',2)
title('SSIM vs Frame')
xlabel('Frame Number')
ylabel('SSIM')
grid on

% MSE
subplot(3,2,3)
plot(mseVal,'LineWidth',2)
title('MSE vs Frame')
xlabel('Frame Number')
ylabel('MSE')
grid on

% MAE
subplot(3,2,4)
plot(maeVal,'LineWidth',2)
title('MAE vs Frame')
xlabel('Frame Number')
ylabel('MAE')
grid on

% Entropy
subplot(3,2,5)
plot(entropyVal,'LineWidth',2)
title('Entropy vs Frame')
xlabel('Frame Number')
ylabel('Entropy')
grid on

% NIQE
subplot(3,2,6)
plot(niqeVal,'LineWidth',2)
title('NIQE vs Frame')
xlabel('Frame Number')
ylabel('NIQE')
grid on
sgtitle('Performance Evaluation Metrics')

end
