% Specify the path to your CSV file
csvFilePath = 'E:\Dataset_3\C1\C1_P1.csv';

% Read the CSV file
data = csvread(csvFilePath, 1, 0);

% Assuming the EEG signal is stored in the first column of the CSV file for book data
condition1 = data(:, 1);
subplot(2, 3, 1)
plot (condition1, 'g')
title('Raw Signal of C1_P1')

%Filtered signal
filtered_1 = condition1(condition1>= -100 & condition1<= 100);
subplot(2, 3, 4)
plot(filtered_1, 'b')
title('Filtered Signal of C1_P1')

t1 = bandpass(filtered_1,[4 8], 256);

% Compute the periodogram for the Theta band for all conditions
Fs = 256; % Sampling frequency
frequencies = 0:0.5:Fs/2; % Define a frequency range
 
% Compute the periodogram for the filtered Theta band for all conditions
[power_1, f_1] = periodogram(t1, [], frequencies, Fs);

 
% Plot the periodogram for the Theta band for all conditions
figure;
subplot(3, 1, 1)
plot(f_1, 10*log10(power_1))
title('Periodogram of Theta Band for C1_P1')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')