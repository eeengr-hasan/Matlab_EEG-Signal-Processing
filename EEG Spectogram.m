% Specify the path to your CSV file
csvFilePath = 'E:\Dataset_3\C1\C1_P1.csv';

% Read the CSV file
data = csvread(csvFilePath, 1, 0);

% Assuming the EEG signal is stored in the first column of the CSV file for book data
condition1 = data(:, 1);
subplot(2, 3, 1)
plot (condition1, 'g')
title('Raw Signal of C1_P1')

% Filtered signal
filtered_1 = condition1(condition1 >= -100 & condition1 <= 100);
subplot(2, 3, 2)
plot(filtered_1, 'b')
title('Filtered Signal of condition1')

% Spectrogram for the book condition
subplot(2, 3, 3)
spectrogram(filtered_1, hann(256), 128, 256, 256, 'yaxis');
title('Spectrogram of condition1')
caxis([-30 30]); % Set color axis limits for better visualization
 