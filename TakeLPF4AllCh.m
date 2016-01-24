function [AllTargetData_Filtered_P300, AllNonTargetData_Filtered_P300] = TakeLPF4AllCh(AllTargetData, AllNonTargetData, Electrodes)

figure
for i = 2:length(Electrodes)+1
    subplot(length(Electrodes),1,i-1); plot([1:length(AllTargetData)], AllTargetData(:,i));
end

% === Exploit only signals % === 
for i = 2:length(Electrodes)
    AllTargetData_ExploitedSignals(:, i) = AllTargetData(:, i);
    AllNonTargetData_ExploitedSignals(:, i) = AllNonTargetData(:, i);
end

whos AllTargetData_ExploitedSignals
whos AllNonTargetData_ExploitedSignals

% === Downsampling % === 
for i = 1:length(Electrodes)
    AllTargetData_DownSampled_64Hz(:, i) = decimate(AllTargetData_ExploitedSignals(:, i), 4);
    AllNonTargetData_DownSampled_64Hz(:, i) = decimate(AllNonTargetData_ExploitedSignals(:, i), 4);
end

% === Filter % === 
Hd_P300 = Filter_P300;
for i = 1:length(Electrodes)
    AllTargetData_Filtered_P300(:, i) = filter(Hd_P300, AllTargetData_DownSampled_64Hz(:, i));
    AllNonTargetData_Filtered_P300(:, i) = filter(Hd_P300, AllNonTargetData_DownSampled_64Hz(:, i));
end

%Check how many data acquired
whos AllTargetData_Filtered_P300
whos AllNonTargetData_Filtered_P300


% === Join filtered signals to return % === 
for i = 2:length(Electrodes)
    AllTargetData_Filtered_P300(:, i+1) = AllTargetData_Filtered_P300(:, i);
    AllNonTargetData_Filtered_P300(:, i+1) = AllNonTargetData_Filtered_P300(:, i);
end

% === Finally assign Time Array to column 1 % === 
AllTargetData_Filtered_P300(:, 1) = decimate(AllTargetData(:, 1), 4);
AllNonTargetData_Filtered_P300(:, 1) = decimate(AllNonTargetData(:,1), 4);

% === Then put Frequency to the end of row 1 (256? 64?)% === 
AllTargetData_Filtered_P300(1, length(Electrodes)+2) = AllTargetData(1, length(Electrodes)+2)/4;
AllNonTargetData_Filtered_P300(1, length(Electrodes)+2) = AllNonTargetData(1, length(Electrodes)+2)/4;

end