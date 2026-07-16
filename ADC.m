clc;
clear;
close all;

% Load Signal Package (Required for hilbert())
pkg load signal;

% Message Signal Parameters
Am = 1;
fm = 500;

% Carrier Signal Parameters
Ac = 5;
fc = 5000;

% Sampling Frequency
fs = 20 * fc;

% Time Vector
t = 0:1/fs:4/fm;

% Message Signal
m = Am * sin(2*pi*fm*t);

% Carrier Signal
c = Ac * sin(2*pi*fc*t);

% Modulation Index
mu = Am / Ac;

% AM Signal
am = Ac * (1 + mu * sin(2*pi*fm*t)) .* sin(2*pi*fc*t);

% Envelope Detection (Demodulation)
dem = abs(hilbert(am));
dem = dem - mean(dem);

% FFT Analysis
N = length(am);
f = (-N/2:N/2-1) * (fs/N);
AM_FFT = abs(fftshift(fft(am))) / N;

% Sideband Frequencies
USB = fc + fm;
LSB = fc - fm;

% Power Calculations
Pc = Ac^2 / 2;
Psb = (mu^2 * Pc) / 4;

% Display Results
figure('Name','AM Modulation','NumberTitle','off');

subplot(3,2,1);
plot(t,m,'b');
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,2,2);
plot(t,c,'r');
title('Carrier Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,2,3);
plot(t,am,'m');
title('AM Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,2,4);
plot(t,dem,'g');
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,2,5);
plot(f,AM_FFT,'k');
xlim([fc-3*fm fc+3*fm]);
title('AM Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

subplot(3,2,6);
bar([Pc Psb Psb]);
set(gca,'XTick',1:3);
set(gca,'XTickLabel',{'Carrier','USB','LSB'});
title('Power Distribution');
ylabel('Power (W)');
grid on;

% Print Results
fprintf('\n');
fprintf('******** AM MODULATION RESULTS ********\n');
fprintf('Modulation Index (mu) = %.2f\n', mu);
fprintf('Carrier Frequency      = %d Hz\n', fc);
fprintf('Message Frequency      = %d Hz\n', fm);
fprintf('Upper Sideband         = %d Hz\n', USB);
fprintf('Lower Sideband         = %d Hz\n', LSB);
fprintf('Carrier Power          = %.2f W\n', Pc);
fprintf('Each Sideband Power    = %.3f W\n', Psb);
fprintf('***************************************\n');
