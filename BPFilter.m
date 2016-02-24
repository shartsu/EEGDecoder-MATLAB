function [AllTargetData_Filtered_P300, AllNonTargetData_Filtered_P300] = BPFilter(AllTargetData, AllNonTargetData, Electrodes)

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

end