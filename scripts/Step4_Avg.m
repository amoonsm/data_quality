%Average out segments with and without low-pass filter

clear;close all;

data_folder = [pwd filesep 'SubjectData'];
subject_all = {'1' '2' '3' '4' '5' '6'};

subject_total = length(subject_all);

for s = 1:subject_total
    subject_current = subject_all{s};
    subject_folder = [data_folder filesep subject_current]; %loc of file
            
    %Initialize EEG
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
            
    %Load data after AR
    EEG = pop_loadset('filename', [subject_current  '_AR_reject.set'], 'filepath', subject_folder);

    %Create an averaged ERP waveform (without filter)
    ERP = pop_averager( EEG , 'Criterion', 'good', 'ExcludeBoundary', 'on', 'SEM', 'on');
    ERP = pop_savemyerp( ERP, 'erpname', [subject_current  '_AR_reject_nofilt'], ...
                        'filename', [subject_folder filesep subject_current '_AR_reject_nofilt.erp']);

    %Create difference waveforms (without filter)
    ERP = pop_binoperator(ERP, 'DifferenceWaveform.txt');
    ERP = pop_erpchanoperator( ERP, {  'ch5 = ((ch2 + ch3 + ch4)/3) label Pooled'}); %interpolated channel
    ERP = pop_savemyerp(ERP, 'erpname', [subject_current  '_AR_reject_diff'], 'filename', ...
                        [subject_folder filesep subject_current '_AR_reject_diff_nofilt.erp']);
    
    %Create an averaged ERP waveform (with filter)
    EEG = pop_loadset('filename', [subject_current  '_AR_reject.set'], 'filepath', subject_folder);
    ERP = pop_averager( EEG , 'Criterion', 'good', 'ExcludeBoundary', 'on', 'SEM', 'on');
    ERP = pop_savemyerp( ERP, 'erpname', [subject_current  '_AR_reject'], ...
                        'filename', [subject_folder filesep subject_current '_AR_reject.erp']);
    ERP = pop_filterp( ERP,  1:31, 'Cutoff',  20, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  8 );
    ERP = pop_savemyerp( ERP, 'erpname', [subject_current  '_AR_reject'], 'filename', [subject_folder filesep subject_current '_AR_reject.erp']);

    %Create difference waveforms (with filter)
    ERP = pop_binoperator(ERP, 'DifferenceWaveform.txt');
    ERP = pop_erpchanoperator( ERP, {  'ch5 = ((ch2 + ch3 + ch4)/3) label Pooled'}); %Average multiple channel
    ERP = pop_savemyerp(ERP, 'erpname', [subject_current  '_AR_reject_diff'], 'filename', ...
                        [subject_folder filesep subject_current '_AR_reject_diff.erp']);

end
