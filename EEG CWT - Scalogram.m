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
a1 = bandpass(filtered_1,[8 13], 256);
b1 = bandpass(filtered_1,[13 30], 256);

% Define the parameters for the CWT
waveletName = 'morl';  % Wavelet name, for example, 'morl' (Morlet wavelet)
Fs = 256;              % Sampling frequency (change to your actual value)
 
% Calculate the CWT for the Theta band signal (e.g., t1)
cwt_theta = cwtft({t1,1/Fs},'wavelet',waveletName);
cfs1 = abs(cwt_theta.cfs);
frequencies1 = cwt_theta.frequencies;
 
% Calculate the CWT for the Alpha band signal (e.g., a1)
cwt_alpha = cwtft({a1,1/Fs},'wavelet',waveletName);
cfs2 = abs(cwt_alpha.cfs);
frequencies2 = cwt_alpha.frequencies;
 
% Calculate the CWT for the Beta band signal (e.g., b1)
cwt_beta = cwtft({b1,1/Fs},'wavelet',waveletName);
cfs3 = abs(cwt_beta.cfs);
frequencies3 = cwt_beta.frequencies;
 
% Create a figure for the scalogram with larger scaling
figure;
 
% Plot the scalogram for the Theta band signal
subplot(3, 1, 1);
imagesc(1:length(t1), frequencies1, 10*log10(cfs1)); % Scale for better visibility
colormap('jet');  % Choose the colormap you prefer
title('Scalogram - Theta Band');
xlabel('Time (samples)');
ylabel('Frequency (Hz)');
colorbar;
 
% Plot the scalogram for the Alpha band signal
subplot(3, 1, 2);
imagesc(1:length(a1), frequencies2, 10*log10(cfs2)); % Scale for better visibility
colormap('jet');  % Choose the colormap you prefer
title('Scalogram - Alpha Band');
xlabel('Time (samples)');
ylabel('Frequency (Hz)');
colorbar;
 
% Plot the scalogram for the Beta band signal
subplot(3, 1, 3);
imagesc(1:length(b1), frequencies3, 10*log10(cfs3)); % Scale for better visibility
colormap('jet');  % Choose the colormap you prefer
title('Scalogram - Beta Band');
xlabel('Time (samples)');
ylabel('Frequency (Hz)');
colorbar;
 
% Adjust the y-axis limits for a better view
subplot(3, 1, 1);
ylim([20, 100]);  % Adjust the frequency range as needed
subplot(3, 1, 2);
ylim([0, 100]);  % Adjust the frequency range as needed
subplot(3, 1, 3);
ylim([0, 100]);  % Adjust the frequency range as needed

