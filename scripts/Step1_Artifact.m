%Remove segments that contain an artifact

clear;close all;

data_folder = [pwd filesep 'SubjectData'];
subject_all = {'1' '2' '3' '4' '5' '6'};

subject_total = length(subject_all);

remove_AR = 1; %1 = no; 2 = yes
remove_AR_save = {'AR_ignore' 'AR_reject'}; %filename when saving 

for s = 1:subject_total
    subject_current = subject_all{s};
    subject_folder = [data_folder filesep subject_current]; %loc of file
            
    %Initialize EEG
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    
    %Load data
    EEG = pop_loadset('filename', [subject_current '_before.set'], 'filepath', subject_folder);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', [subject_current '_before'], 'gui', 'off');

    if subject_current == '2'
        EEG  = pop_erplabInterpolateElectrodes( EEG , 'displayEEG',  0, 'ignoreChannels',  [5 20 26], 'interpolationMethod', 'spherical', 'replaceChannels', 16);
    elseif subject_current == '4'
        EEG  = pop_erplabInterpolateElectrodes( EEG , 'displayEEG',  0, 'ignoreChannels',  [5 20 26], 'interpolationMethod', 'spherical', 'replaceChannels', [10 11 16]);
    elseif subject_current == '6'
        EEG  = pop_erplabInterpolateElectrodes( EEG , 'displayEEG',  0, 'ignoreChannels',  [5 20 26], 'interpolationMethod', 'spherical', 'replaceChannels', [3 12 16]);
    end

    %Remove trials with artifacts

    EEG  = pop_artextval( EEG , 'Channel',  [1:31], 'Flag', [1 2], 'Threshold', [-85 85], 'Twindow', [-100 600] );
    EEG  = pop_artextval( EEG , 'Channel',  [1 31], 'Flag', [1 3], 'Threshold', [-50 50], 'Twindow', [0 300] );
    EEG  = pop_artextval( EEG , 'Channel',  [5 26], 'Flag', [1 4], 'Threshold', [-30 30], 'Twindow', [0 300] );


    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2, 'setname', [subject_current '_AR_reject'], 'savenew', [subject_folder filesep subject_current '_AR_reject.set'], 'gui', 'off');    

end
