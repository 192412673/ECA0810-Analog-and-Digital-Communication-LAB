clc;
clear;
close all;
% PN sequence lengths
PN_length = [7 15 31 63 127 255 511 1023];
% Processing Gain (Linear)
PG_linear = PN_length;
% Processing Gain in dB
PG_dB = 10*log10(PG_linear);
% Display table
T = table(PN_length',PG_dB',...
'VariableNames',{'PN_Length','Processing_Gain_dB'});
disp('Processing Gain Table');
disp(T);
% Plot
figure;
stem(PN_length,PG_dB,'filled');
grid on;
xlabel('PN Sequence Length');
ylabel('Processing Gain (dB)');
title('Spread Spectrum: Processing Gain vs PN Sequence Length');
