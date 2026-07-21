clc;
clear;
close all;

%% Parameters
Am = 1;          % Message Amplitude (V)
fm = 100;        % Message Frequency (Hz)
Ac = 5;          % Carrier Amplitude (V)
fc = 1000;       % Carrier Frequency (Hz)
fs = 20 * fc;    % Sampling Frequency (Hz)
kp = pi/2;       % Phase Sensitivity (rad/V)

%% Time Vector
t = 0:1/fs:4/fm;

%% Message Signal
m = Am * sin(2*pi*fm*t);

%% Phase Modulated Signal
pm = Ac * cos(2*pi*fc*t + kp*m);

%% Phase Deviation / Modulation Index
beta = kp * Am;

%% FFT
N = length(pm);
f = (-N/2:N/2-1) * (fs/N);

PM_FFT = abs(fftshift(fft(pm))) / N;

%% Power Spectral Density
PSD = (abs(fftshift(fft(pm))).^2) / (N * fs);

%% Estimated Bandwidth (Carson's Rule)
BW = 2 * (beta + 1) * fm;

%% Display Results
fprintf('Message Frequency = %.0f Hz\n', fm);
fprintf('Carrier Frequency = %.0f Hz\n', fc);
fprintf('Phase Deviation = %.2f radians\n', beta);
fprintf('PM Modulation Index = %.2f\n', beta);
fprintf('Estimated Bandwidth = %.2f Hz\n', BW);

%% Plotting
figure('Name','PSD Analysis of PM Signal','NumberTitle','off');

subplot(2,2,1);
plot(t, m, 'LineWidth', 1.5);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude (V)');
grid on;

subplot(2,2,2);
plot(t, pm, 'LineWidth', 1.5);
title('Phase Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude (V)');
grid on;

subplot(2,2,3);
plot(f, PM_FFT, 'LineWidth', 1.5);
title('Frequency Spectrum of PM Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

subplot(2,2,4);
plot(f, PSD, 'LineWidth', 1.5);
title('Power Spectral Density');
xlabel('Frequency (Hz)');
ylabel('PSD');
grid on;
