# About the database

The database is from a pilot EEG study that I conducted in graduate school. Data from six participants are included in the subfolder 'SubjectData'. Each participant's subfolder starts with a file with segmented EEG data (e.g., '1_before.set'). 

# About the script

All scripts were written in MATLAB R2022b and used the EEGLAB and ERPLAB toolboxes.

Step1_Artifact
-
Removes trials with artifacts (abnormally large signals, blinks, horizontal eye movements) using absolute thresholds.

Step2_Log
-
Creates 'CountOfTrials.csv' that logs the number of trials kept after artifact rejection.

![image](https://github.com/user-attachments/assets/ec5b8479-8875-4f12-9c8a-c3eb2d53c43e)


Step3_Bar_Graph
-
Creates 'TrialsSaved.pdf' that plots the percentage of trials kept after artifact rejection.

![image](https://github.com/user-attachments/assets/7e9b4399-9213-4119-b0ae-5c79dcd5cc95)

Step4_Avg
-
Averages the trials by participant (refers to the 'DifferenceWaveform.txt'). Create one average without low-pass filter and one with.

Step5_Plot_Avg
-
Creates two pdf files by participant (refer to participant's subfolder) that plots the average with and without filter.

**Without filter**
![image](https://github.com/user-attachments/assets/c9d3dc13-5d5a-443a-9de5-cb03872bd210)

**With filter**
![image](https://github.com/user-attachments/assets/ac97c0e4-d5a4-43fa-be13-17eebe6f68d7)

Step6_Simulation
-
Simulate the data using bootstraping and saves the output in '#_boots_amp.mat' (# = ID) and 'all_boots_sd.mat'

![image](https://github.com/user-attachments/assets/917f0df1-5735-4858-8ace-ba150c335ef4)

Step7_Histogram
-
Creates histogram based on '#_boots_amp.mat' (# = ID) made in Step 6 and saves the output in '#_SD_histogram.pdf' (# = ID) (refer to participant's subfolder)

![image](https://github.com/user-attachments/assets/3fcb4330-a3b3-4f38-af1a-0343b176a56d)

Step8_GrandAvg
-
Creates a grand average waveform (average across participant; refers to the 'all_avg_wave.txt').


Step9_Plot_GA
-
Creates 'GA_Waveform.pdf' that plots the grand average waveform at four different electrode sites.

![image](https://github.com/user-attachments/assets/158a1116-342a-4964-a52f-fab97f2a7938)

Step10_MeanAmp
-
Creates 'Mean_Amplitude.txt' that computes the mean amplitude (strength of signal) at four different electrode sites.<br />

![image](https://github.com/user-attachments/assets/61031cee-345e-4d3b-b99d-7b9bc8e9de58)

Creates 'GA_MeanAmp.pdf' that plots the mean amplitude at four different electrode sites.

![image](https://github.com/user-attachments/assets/0a463ce4-d769-4a63-9f5d-2ddb763d8d93)
