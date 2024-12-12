%Average the waveform across participants

clear;close all;

data_folder = [pwd filesep 'SubjectData'];
subject_all = {'1' '2' '3' '4' '5' '6'};

subject_total = length(subject_all);

% Create text file of erp files across participants
output_file = 'all_avg_wave.txt'; % Name of the text file
fileID = fopen(output_file, 'w');
for s = 1:subject_total   
    subject_current = subject_all{s};
    subject_folder = [data_folder filesep subject_current]; %loc of file
    fprintf(fileID, '%s\n', [subject_folder filesep subject_current '_AR_reject_diff.erp']);
end
fclose(fileID);

%Create a grand average ERP waveform across subjects
ERP = pop_gaverager(output_file, 'ExcludeNullBin', 'on', 'SEM', 'on' );
ERP = pop_savemyerp(ERP, 'erpname', 'GA_AR_reject_diff', 'filename', 'GA_AR_reject_diff.erp');

