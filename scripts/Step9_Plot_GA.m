%Plot the grand average waveform at four different electrode sites

clear;close all;

data_folder = [pwd filesep 'SubjectData'];
subject_all = {'1' '2' '3' '4' '5' '6'};

subject_total = length(subject_all);

ERP = pop_loaderp('filename', 'GA_AR_reject_diff.erp');
ERP = pop_ploterps(ERP, 3, 2:5 , 'Box', [1 4], 'blc', '-100 0', 'Maximize', 'on', 'Style', 'Classic', 'xscale', [-100 600],  'yscale', [-3 3]);
save2pdf('GA_Waveform.pdf')
