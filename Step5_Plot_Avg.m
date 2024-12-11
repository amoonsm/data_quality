%Plot the waveform with low-pass filter and waveform without filter

clear;close all;

data_folder = [pwd filesep 'SubjectData'];
subject_all = {'1' '2' '3' '4' '5' '6'};

subject_total = length(subject_all);

%% Plot avg waveform (with filter) by subject
for s = 1:subject_total
    subject_current = subject_all{s};
    subject_folder = [data_folder filesep subject_current]; %loc of file
            
    %Initialize EEG
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

    %load the averaged diff waveform
    ERP = pop_loaderp('filename', [subject_current  '_AR_reject_diff.erp'], 'filepath', subject_folder);
    ERP = pop_ploterps( ERP, 3, 4 , 'Box', [1 1], 'blc', '-100 0', 'Maximize', 'on', 'Style', 'Classic', 'xscale', [-100 600],  'yscale', [-5 5]);
    save2pdf([subject_folder filesep subject_current '_AvgWaveform.pdf']);
    close all
end

%% Plot avg waveform (without filter) by subject

for s = 1:subject_total
    subject_current = subject_all{s};
    subject_folder = [data_folder filesep subject_current]; %loc of file
            
    %Initialize EEG
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

    %load the averaged diff waveform
    ERP = pop_loaderp('filename', [subject_current  '_AR_reject_diff_nofilt.erp'], 'filepath', subject_folder);
    pop_ploterps( ERP, 3, 4 , 'Box', [1 1], 'blc', '-100 0', 'Maximize', 'on', 'Style', 'Classic', 'xscale', [-100 600],  'yscale', [-5 5]);
    save2pdf([subject_folder filesep subject_current '_AvgWaveform_NoFilter.pdf']);
    close all
end

