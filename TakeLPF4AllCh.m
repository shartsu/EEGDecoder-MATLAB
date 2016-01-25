function [AllTargetData_Filtered_P300_DownSampled_64Hz, AllNonTargetData_Filtered_P300_DownSampled_64Hz, Duration_points_64Hz] = ...
    TakeLPF4AllCh(AllTargetData, AllNonTargetData, Electrodes, Duration_points)

figure
for i = 2:length(Electrodes)+1
    subplot(length(Electrodes),1,i-1); 
    plot([1:length(AllTargetData)], AllTargetData(:,i));
end

% === Exploit only signals % === 
for i = 2:length(Electrodes)+1
    AllTargetData_ExploitedSignals(:, i-1) = AllTargetData(:, i);
    AllNonTargetData_ExploitedSignals(:, i-1) = AllNonTargetData(:, i);
end

whos AllTargetData_ExploitedSignals
whos AllNonTargetData_ExploitedSignals

% === Filter % === 
Hd_P300 = Filter_P300;
for i = 1:length(Electrodes)
    AllTargetData_Filtered_P300(:, i) = filter(Hd_P300, AllTargetData_ExploitedSignals(:, i));
    AllNonTargetData_Filtered_P300(:, i) = filter(Hd_P300, AllNonTargetData_ExploitedSignals(:, i));
end

% === Downsampling % === 

Duration_points_64Hz = ceil(Duration_points/4);
% for TARGET
for i = 1:length(Electrodes) %for 1-16Chs
    for j = 1:(length(AllTargetData_Filtered_P300)/Duration_points) %1-40 Targets
        AllTargetData_Filtered_P300_DownSampled_64Hz(1+Duration_points_64Hz*(j-1):Duration_points_64Hz*j,i) =...
            decimate(AllTargetData_Filtered_P300(1+Duration_points*(j-1):Duration_points*j, i), 4);
        %1+ceil(Duration_points/4)*(j-1)
    end
end

% for NonTARGET
for i = 1:length(Electrodes) %for 1-16Chs
    for j = 1:(length(AllNonTargetData)/Duration_points) %1-160 NonTargets
        AllNonTargetData_Filtered_P300_DownSampled_64Hz(1+Duration_points_64Hz*(j-1):Duration_points_64Hz*j,i) =...
            decimate(AllNonTargetData_Filtered_P300(1+Duration_points*(j-1):Duration_points*j, i), 4);
    end
end

%Check how many data acquired
whos AllTargetData_Filtered_P300_DownSampled_64Hz
whos AllNonTargetData_Filtered_P300_DownSampled_64Hz

% === Join filtered signals to return % === 
%{
for i = 1:length(Electrodes)
    AllTargetData_Filtered_P300_RET(:, i) = AllTargetData_Filtered_P300_DownSampled_64Hz(:, i);
    AllNonTargetData_Filtered_P300_RET(:, i) = AllNonTargetData_Filtered_P300_DownSampled_64Hz(:, i);
end

whos AllTargetData_Filtered_P300_RET

% === Finally assign Time Array to column 1 % === 
%AllTargetData_Filtered_P300_RET(:, 1) = decimate(AllTargetData(:, 1), 4);
%AllNonTargetData_Filtered_P300_RET(:, 1) = decimate(AllNonTargetData(:,1), 4);

% === Then put Frequency to the end of row 1 (256 or 64) % === 
AllTargetData_Filtered_P300_RET(1, length(Electrodes)+1) = AllTargetData(1, length(Electrodes)+2)/4;
AllNonTargetData_Filtered_P300_RET(1, length(Electrodes)+1) = AllNonTargetData(1, length(Electrodes)+2)/4;
%}

end