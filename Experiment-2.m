clc;
clear;
close all;

Am = 1;
Ac = 1;
fm = 5;
fc = 50;
beta = 5;
fs = 1000;

t = 0:1/fs:1;

m = Am * cos(2*pi*fm*t);

c = Ac * cos(2*pi*fc*t);

fm_sig = Ac * cos(2*pi*fc*t + beta*sin(2*pi*fm*t));

analytic_sig = hilbert(fm_sig);
phase = unwrap(angle(analytic_sig));
inst_freq = [diff(phase) 0] * fs / (2*pi);
demod = (inst_freq - fc) / beta;

N = length(fm_sig);
f = (-N/2:N/2-1) * (fs/N);
FM_FFT = abs(fftshift(fft(fm_sig))) / N;

figure('Name','Frequency Modulation','NumberTitle','off');

subplot(4,1,1);
plot(t,m,'b','LineWidth',1.5);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(4,1,2);
plot(t,c,'r','LineWidth',1.5);
title('Carrier Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(4,1,3);
plot(t,fm_sig,'m','LineWidth',1.2);
title('FM Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(4,1,4);
plot(t,demod,'g','LineWidth',1.2);
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

figure('Name','FM Spectrum','NumberTitle','off');

plot(f,FM_FFT,'k','LineWidth',1.5);
xlim([-100 100]);
title('Frequency Spectrum of FM Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

fprintf('\n');
fprintf('******** FM MODULATION RESULTS ********\n');
fprintf('Message Frequency      = %d Hz\n', fm);
fprintf('Carrier Frequency      = %d Hz\n', fc);
fprintf('Modulation Index       = %.2f\n', beta);
fprintf('Sampling Frequency     = %d Hz\n', fs);
fprintf('***************************************\n');
