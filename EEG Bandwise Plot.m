% Specify the path to your CSV file
csvFilePath = 'E:\Dataset_3\C1\C1_P1.csv';

% Read the CSV file
data = csvread(csvFilePath, 1, 0);

% Assuming the EEG signal is stored in the first column of the CSV file
eegSignal = data(:, 1);
subplot(2, 3, 1)
plot (eegSignal, 'b')
title('Raw Signal')

%Filtered signal
filtered = eegSignal(eegSignal>= 0.15 & eegSignal<= 45);
subplot(2, 3, 2)
plot(filtered, 'y')
title('Filtered Signal(0.5 to 50)')
xlabel('Time')
ylabel('Amplitude')

%PSD using pwelch
Fs = 256;
[PSD, f] = pwelch(eegSignal, hamming(Fs), 0.5*Fs, Fs);
subplot(2, 3, 3)
plot(PSD, 'g')
title('Power Spectrum Density')

%Theta band split
t = bandpass(PSD,[4 8], 256);
t1 = fft(t);
t11 = abs(t1);
subplot(2, 3, 4) 
plot(t11, 'r')
title('Theta Band of FFT')
xlabel('Frequency(Hz)')
ylabel('|P1(f)|')

%Alpha band split
a = bandpass(PSD,[8 13], 256);
a1 = fft(a);
a11 = abs(a1);
subplot(2, 3, 5) 
plot(a11, 'r')
title('Alpha Band of FFT')
xlabel('Frequency(Hz)')
ylabel('|P1(f)|')

%Beta band split
b = bandpass(PSD,[13 30], 256);
b1 = fft(b);
b11 = abs(b1);
subplot(2, 3, 6) 
plot(b11, 'r')
title('Alpha Band of FFT')
xlabel('Frequency(Hz)')
ylabel('|P1(f)|')
