%Simulate the data using bootstrapping

clear all;clc

data_folder = [pwd filesep 'SubjectData'];
subject_all = {'1' '2' '3' '4' '5' '6'};

subject_total = length(subject_all);

%Initialize EEG
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

%% Set up parameters for simulation

num_of_sim = 5000;
channel = 4; % PO7/PO8
bin = 3; 
% Initialize array by Subjects x Channels X bins
sd_all = zeros(subject_total,1,1);


%% Simulation
for s = 1:subject_total   
    subject_current = subject_all{s};
    subject_folder = [data_folder filesep subject_current]; %loc of file
    
    %load data
    EEG = pop_loadset('filename', [subject_current  '_AR_reject.set'], 'filepath', subject_folder);
    filename = [subject_current '_AR_reject.set'];
    
    %Bootstrap
    ALLERP = make_bootstrap_ERPSETs(EEG,num_of_sim,filename,1); %random sampling of segments with replacement

    %Create avg waveform (with filter) for each bootstrap
    for current_sim = 1:num_of_sim 
        ALLERP(current_sim) = pop_binoperator(ALLERP(current_sim), 'DifferenceWaveform.txt');
        ALLERP(current_sim) = pop_erpchanoperator(ALLERP(current_sim), {  'ch5 = ((ch2 + ch3 + ch4)/3) label Pooled'});
        ALLERP(current_sim) = pop_filterp( ALLERP(current_sim),  4 , 'Cutoff',  20, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  8 );        
    end
    
    %Compute mean amplitude of waveform by bootstrap
    [ALLERP, boots_amp] = pop_geterpvalues( ALLERP, [200 300],  bin,  channel,...
                                           'Baseline',  'pre', 'Erpsets',  1:num_of_sim, 'Measure', 'meanbl');

    save([subject_current '_boots_amp.mat'], 'boots_amp');

    %Get the standard deviation (SD) of mean amplitude across bootstraps
    sd_amp = std(boots_amp,0,3);
    sd_all(s) = sd_amp'; %save the SD by subject
    
end

save('all_boots_sd.mat','sd_all')



















