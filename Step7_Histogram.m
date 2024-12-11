%Plot the simulated data from Step 6

clear all;clc

data_folder = [pwd filesep 'SubjectData'];
subject_all = {'1' '2' '3' '4' '5' '6'};

subject_total = length(subject_all);

%plot histogram
for s = 1:subject_total   
    subject_current = subject_all{s};
    subject_folder = [data_folder filesep subject_current]; %loc of file
    
    load([subject_current '_boots_amp.mat'])
    histogram(boots_amp)
    xlim([-5 5])
    ylim([0 600])
    save2pdf([subject_folder filesep subject_current '_SD_histogram.pdf'])
end





















