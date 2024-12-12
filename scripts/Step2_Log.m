%Create a file that logs the percentage of segments saved after artifact
%rejection

clear;close all;

data_folder = [pwd filesep 'SubjectData'];
subject_all = {'1' '2' '3' '4' '5' '6'};

subject_total = length(subject_all);


fid = fopen('CountOfTrials.csv', 'w');
fprintf(fid, 'ID, Trial_Total, Trial_Without_Artifact, Trial_Without_Artifact_Percent\n');


for s = 1:subject_total
    subject_current = subject_all{s};
    subject_folder = [data_folder filesep subject_current]; %loc of file
            
    %Initialize EEG
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
            
    %Load file with artifact removed
    EEG = pop_loadset('filename', [subject_current  '_AR_reject.set'], 'filepath', subject_folder);
    
    %Log number of trials 
    trial_total = length(EEG.reject.rejmanual); %total trials  
    total_without_AR = trial_total - sum(EEG.reject.rejmanual); %trials without artifact
    total_without_AR_percent = total_without_AR / trial_total  * 100; %percentage of trials saved

    %Save the log of trials to the .csv file
    fprintf(fid,'%s,%d,%d,%.2f\n',subject_current, trial_total, total_without_AR, total_without_AR_percent);
    
end 
fclose(fid);



