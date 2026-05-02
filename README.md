# Hybrid-CNN-Based-Noise-Detection-and-Adaptive-Filtering-for-UAV-Video-Enhancement
A hybrid deep learning + signal processing framework for UAV video enhancement using CNN-based noise classification and adaptive filtering.

## Overview

This project presents a hybrid framework combining deep learning and classical signal processing techniques to enhance UAV video quality. The system first classifies the type of noise using a lightweight CNN and then applies an optimal filter tailored to that specific degradation.

---

## Key Features

* Lightweight CNN for **6-class noise classification**
* Adaptive filtering pipeline for targeted restoration
* Handles multiple UAV-specific degradations:

  * Motion Blur
  * Impulse Noise
  * Periodic (Propeller) Noise
  * Low-Light Noise
  * Fog / Haze
  * Defocus Blur
* Achieves:

  * **PSNR improvement:** ~19 dB → ~30 dB
  * **SSIM improvement:** ~0.61 → ~0.91
* Designed for **real-time UAV deployment**

---
## Methodology

### 1. Dataset Generation
- Synthetic dataset created from clean UAV frames
- Six noise classes with controlled degradation
- Approximately 3000 images
- Train-validation split: 80:20

### 2. CNN-Based Classification
- Lightweight CNN with 3 convolutional blocks
- Filters: 32 → 64 → 128
- Activation: ReLU
- Pooling: MaxPooling
- Optimizer: Adam
- Validation Accuracy: ~96%


### 3. Adaptive Filtering

Each noise type is mapped to an optimal filter:

| Noise Type      | Filter Used          |
| --------------- | -------------------- |
| Impulse Noise   | Median Filter        |
| Motion Blur     | Wiener Deconvolution |
| Periodic Noise  | FFT Notch Filter     |
| Low-Light Noise | CLAHE                |
| Fog / Haze      | Histogram Stretching |
| Defocus Blur    | Unsharp Masking      |

---

## Results
### Evaluation Metrics
The system is evaluated using the following metrics:

- Peak Signal-to-Noise Ratio (PSNR)
- Structural Similarity Index (SSIM)
- Mean Squared Error (MSE)
- Mean Absolute Error (MAE)
- Natural Image Quality Evaluator (NIQE)

### Performance Summary
- Average PSNR improved from ~19.2 dB to ~30.1 dB
- Average SSIM improved from ~0.61 to ~0.91
- Significant reduction in MSE and MAE
- Improved perceptual quality across all noise categories

### Per-Class Performance

- Impulse Noise:
  - PSNR: 18.3 → 29.5
  - SSIM: 0.58 → 0.89

- Motion Blur:
  - PSNR: 18.7 → 32.0
  - SSIM: 0.60 → 0.92

- Periodic Noise:
  - PSNR: 20.1 → 30.8
  - SSIM: 0.55 → 0.93

- Low-Light:
  - PSNR: 19.5 → 28.5
  - SSIM: 0.63 → 0.88

- Fog / Haze:
  - PSNR: 20.4 → 29.7
  - SSIM: 0.64 → 0.90

- Defocus Blur:
  - PSNR: 18.6 → 30.1
  - SSIM: 0.62 → 0.91

---

## Technologies Used

* MATLAB
* CNN (Deep Learning)
* Image Processing Toolbox
* Signal Processing Toolbox

---

## Applications

* UAV Surveillance
* Disaster Monitoring
* Agriculture Imaging
* Environmental Mapping

