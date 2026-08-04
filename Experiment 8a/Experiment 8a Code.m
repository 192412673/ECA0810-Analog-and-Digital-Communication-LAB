clc;
clear;
close all;
%% Objective 1: Generate BPSK symbols
N = 1000; % Number of bits
data = randi([0 1], N, 1); % Random binary sequence
% BPSK Mapping
bpsk_symbols = 2*data - 1;
%% Objective 2: Plot BPSK Signal Constellation
figure;
subplot(1,2,1);
scatter(real(bpsk_symbols), imag(bpsk_symbols), ...
30, 'filled');
hold on;
xline(0,'k','LineWidth',1.5);
yline(0,'k','LineWidth',1.5);
grid on;
axis equal;
xlim([-1.5 1.5]);
ylim([-1 1]);
xlabel('In-Phase (I)');
ylabel('Quadrature (Q)');
title('Ideal BPSK Constellation');
%% Objective 3: Add Noise and Evaluate Performance
SNR = 5; % Signal-to-Noise Ratio (dB)
rx_signal = awgn(bpsk_symbols, SNR, 'measured');

subplot(1,2,2);
scatter(real(rx_signal), imag(rx_signal), ...
15, 'filled');
hold on;
xline(0,'k','LineWidth',1.5);
yline(0,'k','LineWidth',1.5);
grid on;
axis equal;
xlim([-2.5 2.5]);
ylim([-2 2]);
xlabel('In-Phase (I)');
ylabel('Quadrature (Q)');
title(['Noisy BPSK Constellation (SNR = ', num2str(SNR), ' dB)']);
%% Symbol Detection
detected_bits = real(rx_signal) > 0;
% Calculate Errors
num_errors = sum(data ~= detected_bits);
BER = num_errors/N;
fprintf('Number of Transmitted Bits : %d\n', N);
fprintf('Number of Bit Errors : %d\n', num_errors);
fprintf('Bit Error Rate (BER) : %f\n', BER);
