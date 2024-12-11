%Create a bar graph showing the percentage of segments saved after artifact
%rejection

clear;close all;

subject_all = {'1' '2' '3' '4' '5' '6'};

%Load the CountOfTrials.csv
filename = 'CountOfTrials.csv';
dataTable = readtable(filename);

%Extract trial numbers and percentage
trials_without_AR = table2array(dataTable(:,3));
percent_without_AR = table2array(dataTable(:,4));

% Create the bar plot
figure;
b = bar(percent_without_AR); %Create side-by-side bars (30,60) for each subject
% b(2).FaceColor = [0.678, 0.847, 0.902]; % RGB for light blue

% Display values next to the bars
for i = 1:length(subject_all)
    % Loop over the bars for each subject 
        % Get the bar data values
        y = b.YData(i);
        
        %Get the trial count from trials_after_combined
        trial_count = trials_without_AR(i);

        % Get the X position of the bars
        xPos = b.XData(i);
        
        % Adjust xPos for the bars (Group 2) to center the text
%         if j == 1
%             xPos = xPos - .15;
%         elseif j == 2
%             xPos = xPos + .15; 
%         end

        % Position text at each bar
        text(xPos, y + 1, num2str(trial_count), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 10);
end



% Add labels to the x-axis
set(gca, 'XTickLabel', subject_all);

% Add title and axis labels
title('% of Trials after Artifact Rejection');
xlabel('Subjects');
ylabel('Trials Saved (%)');
ylim([0 100]);


% Add a legend
% legend(b, {'30μV', '60μV'}, 'Location', 'southeastoutside');

% Save the current figure as a PDF
saveas(gcf, 'TrialsSaved.pdf');

   





