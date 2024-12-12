%Calculate and plot the mean amplitude of each grand average

clear;close all;

data_folder = [pwd filesep 'SubjectData'];
subject_all = {'1' '2' '3' '4' '5' '6'};

output_file = 'all_avg_wave.txt'; % Name of the text file with subject files (made in Step 8)

% Create a txt file with the mean amp by subjects (record) and electrodes (field)
ERP = pop_geterpvalues(output_file, [200 300], 3, 2:5, 'Baseline', '-100 0', 'Measure', 'meanbl',... 
                        'Filename', 'Mean_Amplitude.txt', 'Binlabel', 'on', 'FileFormat', 'wide',... 
                        'InterpFactor',  1,  'Resolution', 3);

% Create a bar graph of the mean amp
data = readtable('Mean_Amplitude.txt', 'FileType', 'text');
channels = {'P3 & P4', 'P7 & P8', 'PO7 & PO8', 'Pooled'};  % Relabel column headers
mean_amplitudes = table2array(data(:, 1:end-1));  % Convert to array, excluding the ERPset column
mean_amplitude_values = mean(mean_amplitudes, 1); % Calculate the mean across subjects

% Plot a bar graph of mean amplitude for each channel
figure;
bar(mean_amplitude_values, 'FaceColor', [0.4, 0.6, 0.8]);  % Green color for bars
set(gca, 'XTickLabel', channels, 'XTick', 1:length(channels));  % Label the x-axis with channel names
xlabel('Channel');
ylabel('Mean Amplitude (µV)');
title('Mean Amplitude per Channel');
xtickangle(45);

save2pdf('GA_MeanAmp.pdf')

