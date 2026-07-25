clc;
clear;
close all;

Am = 1;
fm = 500;

Ac = 5;
fc = 5000;

fs = 20 * fc;

t = 0:1/fs:4/fm;

m = Am * sin(2*pi*fm*t);

c = Ac * sin(2*pi*fc*t);

mu = Am / Ac;

am = Ac * (1 + mu * sin(2*pi*fm*t)) .* sin(2*pi*fc*t);

dem = abs(hilbert(am));
dem = dem - mean(dem);

N = length(am);
f = (-N/2:N/2-1) * (fs/N);
AM_FFT = abs(fftshift(fft(am))) / N;

USB = fc + fm;
LSB = fc - fm;

Pc = Ac^2 / 2;
Psb = (mu^2 * Pc) / 4;

figure('Name','AM Modulation','NumberTitle','off');

subplot(3,2,1);
plot(t,m,'b','LineWidth',1.5);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,2,2);
plot(t,c,'r','LineWidth',1.5);
title('Carrier Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,2,3);
plot(t,am,'m','LineWidth',1.5);
title('AM Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,2,4);
plot(t,dem,'g','LineWidth',1.5);
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,2,5);
plot(f,AM_FFT,'k','LineWidth',1.5);
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

fprintf('\n');
fprintf('******** AM MODULATION RESULTS ********\n');
fprintf('Modulation Index (mu) = %.2f\n', mu);
fprintf('Carrier Frequency      = %d Hz\n', fc);
fprintf('Message Frequency      = %d Hz\n', fm);
fprintf('Upper Sideband         = %d Hz\n', USB);
fprintf('Lower Sideband         = %d Hz\n', LSB);
fprintf('Carrier Power          = %.2f W\n', Pc);
fprintf('Each Sideband Power    = %.3f W\n', Psb);
fprintf('Total Power            = %.3f W\n', Pc + 2*Psb);
fprintf('***************************************\n');
