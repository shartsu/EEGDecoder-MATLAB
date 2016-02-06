function mainEEGDecoder_Stimulus_4_Graph(directory, Stimulus_duration)

%::::::::::::::: !("~")! Caution !("~")! :::::::::::::::::
%This function is for those who want to output EEG signals in each (4) STIMULUS
% 1,INPUT CSV FILES -- are must be generated from OpenViBETargetSeparatorP300
%                   -- https://github.com/shartsu/OpenViBETargetSeparatorP300
% 2,FILE NAMES -- might be like '[1111.11.11-11.11.11]-no1-target-signal.csv'
% 3,FILE PLACE -- should be put in '/signal' directory

%::::::::::::::: ?(^o^)? Inputs ?(^o^)? :::::::::::::::::
% ARG1 == file directory which include stimulus separated CSV files
% -- ex.) 'signal' of './signal/[1111.11.11-11.11.11]-no1-target-signal.csv'
% ARG2 == Stimulus_duration (this value may 0.8 but depents on its environment) 
%::::: (C) Takumi Kodama, University of Tsukuba, Japan :::::

%{
TargetNum = {'no1', 'no2', 'no3', 'no4'};
TargetONOFF = {'target', 'nontarget'};

for num = 1:4
    for onoff = 1:2
        aho = strcat(identifier, '-', TargetNum{num}, '-', TargetONOFF{onoff}, '-signal.csv' );
   end
end
%} 

% === Old Version
%{
File1_TargetCSV     = dir(['./', directory, '/*-no1-target-signal.csv']);
File1_NonTargetCSV  = dir(['./', directory, '/*-no1-nontarget-signal.csv']);
File2_TargetCSV     = dir(['./', directory, '/*-no2-target-signal.csv']);
File2_NonTargetCSV  = dir(['./', directory, '/*-no2-nontarget-signal.csv']);
File3_TargetCSV     = dir(['./', directory, '/*-no3-target-signal.csv']);
File3_NonTargetCSV  = dir(['./', directory, '/*-no3-nontarget-signal.csv']);
File4_TargetCSV     = dir(['./', directory, '/*-no4-target-signal.csv']);
File4_NonTargetCSV  = dir(['./', directory, '/*-no5-nontarget-signal.csv']);
%}

% === New Version
File1_TargetCSV     = dir(['./', directory, '/[6] P300-SBE-Target1*.csv']);
File1_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE-NonTarget1*.csv']);
File2_TargetCSV     = dir(['./', directory, '/[6] P300-SBE-Target2*.csv']);
File2_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE-NonTarget2*.csv']);
File3_TargetCSV     = dir(['./', directory, '/[6] P300-SBE-Target3*.csv']);
File3_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE-NonTarget3*.csv']);
File4_TargetCSV     = dir(['./', directory, '/[6] P300-SBE-Target4*.csv']);
File4_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE-NonTarget4*.csv']);

[AllTargetData_no1, Sampling_Hz, Electrodes] = fileProcessor_dir(directory, File1_TargetCSV);
[AllNonTargetData_no1]           = fileProcessor_dir(directory, File1_NonTargetCSV);
[AllTargetData_no2]              = fileProcessor_dir(directory, File2_TargetCSV);
[AllNonTargetData_no2]           = fileProcessor_dir(directory, File2_NonTargetCSV);
[AllTargetData_no3]              = fileProcessor_dir(directory, File3_TargetCSV);
[AllNonTargetData_no3]           = fileProcessor_dir(directory, File3_NonTargetCSV);
[AllTargetData_no4]              = fileProcessor_dir(directory, File4_TargetCSV);
[AllNonTargetData_no4]           = fileProcessor_dir(directory, File4_NonTargetCSV);

%Check how many data acquired
whos AllTargetData_no1;
whos AllNonTargetData_no1;
 
Duration_points_256Hz = floor(Sampling_Hz * Stimulus_duration);

%Take BP Filter (5Hz-27Hz)
[AllTargetData_Filtered_P300_no1, AllNonTargetData_Filtered_P300_no1] = BPFilter(AllTargetData_no1, AllNonTargetData_no1, Electrodes);
[AllTargetData_Filtered_P300_no2, AllNonTargetData_Filtered_P300_no2] = BPFilter(AllTargetData_no2, AllNonTargetData_no2, Electrodes);
[AllTargetData_Filtered_P300_no3, AllNonTargetData_Filtered_P300_no3] = BPFilter(AllTargetData_no3, AllNonTargetData_no3, Electrodes);
[AllTargetData_Filtered_P300_no4, AllNonTargetData_Filtered_P300_no4] = BPFilter(AllTargetData_no4, AllNonTargetData_no4, Electrodes);

%DownSampling
[AllTargetData_Filtered_P300_DS64Hz_no1, AllNonTargetData_Filtered_P300_DS64Hz_no1, Duration_points_64Hz] = DownSampling(AllTargetData_Filtered_P300_no1, AllNonTargetData_Filtered_P300_no1, Electrodes, Duration_points_256Hz);
[AllTargetData_Filtered_P300_DS64Hz_no2, AllNonTargetData_Filtered_P300_DS64Hz_no2, Duration_points_64Hz] = DownSampling(AllTargetData_Filtered_P300_no2, AllNonTargetData_Filtered_P300_no2, Electrodes, Duration_points_256Hz);
[AllTargetData_Filtered_P300_DS64Hz_no3, AllNonTargetData_Filtered_P300_DS64Hz_no3, Duration_points_64Hz] = DownSampling(AllTargetData_Filtered_P300_no3, AllNonTargetData_Filtered_P300_no3, Electrodes, Duration_points_256Hz);
[AllTargetData_Filtered_P300_DS64Hz_no4, AllNonTargetData_Filtered_P300_DS64Hz_no4, Duration_points_64Hz] = DownSampling(AllTargetData_Filtered_P300_no4, AllNonTargetData_Filtered_P300_no4, Electrodes, Duration_points_256Hz);

%Data exploit from files

[MeanAllElectrodeTarget1d_8ch_Cmd1, SEAllTarget1d_8ch_Cmd1, MeanAllElectrodeNonTarget1d_8ch_Cmd1, SEAllNonTarget1d_8ch_Cmd1] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz_no1(:, 1:8), AllNonTargetData_Filtered_P300_DS64Hz_no1(:, 1:8), Duration_points_64Hz);
[MeanAllElectrodeTarget1d_8ch_Cmd2, SEAllTarget1d_8ch_Cmd2, MeanAllElectrodeNonTarget1d_8ch_Cmd2, SEAllNonTarget1d_8ch_Cmd2] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz_no2(:, 1:8), AllNonTargetData_Filtered_P300_DS64Hz_no2(:, 1:8), Duration_points_64Hz);
[MeanAllElectrodeTarget1d_8ch_Cmd3, SEAllTarget1d_8ch_Cmd3, MeanAllElectrodeNonTarget1d_8ch_Cmd3, SEAllNonTarget1d_8ch_Cmd3] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz_no3(:, 1:8), AllNonTargetData_Filtered_P300_DS64Hz_no3(:, 1:8), Duration_points_64Hz);
[MeanAllElectrodeTarget1d_8ch_Cmd4, SEAllTarget1d_8ch_Cmd4, MeanAllElectrodeNonTarget1d_8ch_Cmd4, SEAllNonTarget1d_8ch_Cmd4] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz_no4(:, 1:8), AllNonTargetData_Filtered_P300_DS64Hz_no4(:, 1:8), Duration_points_64Hz);

figure
subplot(2,2,1);
drawSignalGraph(MeanAllElectrodeTarget1d_8ch_Cmd1, SEAllTarget1d_8ch_Cmd1, MeanAllElectrodeNonTarget1d_8ch_Cmd1, SEAllNonTarget1d_8ch_Cmd1, 1, 'Stimulus1 - LeftHand', Stimulus_duration, Duration_points_64Hz);

subplot(2,2,2);
drawSignalGraph(MeanAllElectrodeTarget1d_8ch_Cmd2, SEAllTarget1d_8ch_Cmd2, MeanAllElectrodeNonTarget1d_8ch_Cmd2, SEAllNonTarget1d_8ch_Cmd2, 1, 'Stimulus2 - RightHand', Stimulus_duration, Duration_points_64Hz);

subplot(2,2,3);
drawSignalGraph(MeanAllElectrodeTarget1d_8ch_Cmd3, SEAllTarget1d_8ch_Cmd3, MeanAllElectrodeNonTarget1d_8ch_Cmd3, SEAllNonTarget1d_8ch_Cmd3, 1, 'Stimulus3 - LeftLeg', Stimulus_duration, Duration_points_64Hz);

subplot(2,2,4);
drawSignalGraph(MeanAllElectrodeTarget1d_8ch_Cmd4, SEAllTarget1d_8ch_Cmd4, MeanAllElectrodeNonTarget1d_8ch_Cmd4, SEAllNonTarget1d_8ch_Cmd4, 1, 'Stimulus4 - RightLeg', Stimulus_duration, Duration_points_64Hz);

filename_4Stimulus = strcat(directory, '/_P3Response-4Stimulus.png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto');
print(filename_4Stimulus,'-dpng','-r0')


end

function [AllData, Sampling_Hz, Electrodes] = fileProcessor_dir(directory, File_dir_struct)
   
    AllData = [];
    File_dir_struct.name
    
    for i = 1:length(File_dir_struct)
        allData_struct = importdata(strcat('./', directory, '/', File_dir_struct(i).name));
        AllData = vertcat(AllData, allData_struct.data);
    end
    
    Sampling_Hz = allData_struct.data(1, end);
    Electrodes = allData_struct.textdata(1, 2:(end-1));
end