function main_Stimulus_4_Graph(directory, Stimulus_duration)

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

File1_TargetCSV     = dir(['./', directory, '/*-no1-target-signal.csv']);
File1_NonTargetCSV  = dir(['./', directory, '/*-no1-nontarget-signal.csv']);
File2_TargetCSV     = dir(['./', directory, '/*-no2-target-signal.csv']);
File2_NonTargetCSV  = dir(['./', directory, '/*-no2-nontarget-signal.csv']);
File3_TargetCSV     = dir(['./', directory, '/*-no3-target-signal.csv']);
File3_NonTargetCSV  = dir(['./', directory, '/*-no3-nontarget-signal.csv']);
File4_TargetCSV     = dir(['./', directory, '/*-no4-target-signal.csv']);
File4_NonTargetCSV  = dir(['./', directory, '/*-no4-nontarget-signal.csv']);

[AllTargetData_no1, Sampling_Hz] = fileProcessor_Stimulus(directory, File1_TargetCSV);
[AllNonTargetData_no1]           = fileProcessor_Stimulus(directory, File1_NonTargetCSV);
[AllTargetData_no2]              = fileProcessor_Stimulus(directory, File2_TargetCSV);
[AllNonTargetData_no2]           = fileProcessor_Stimulus(directory, File2_NonTargetCSV);
[AllTargetData_no3]              = fileProcessor_Stimulus(directory, File3_TargetCSV);
[AllNonTargetData_no3]           = fileProcessor_Stimulus(directory, File3_NonTargetCSV);
[AllTargetData_no4]              = fileProcessor_Stimulus(directory, File4_TargetCSV);
[AllNonTargetData_no4]           = fileProcessor_Stimulus(directory, File4_NonTargetCSV);

%Check how many data acquired
whos AllTargetData_no1;
whos AllNonTargetData_no1;
 
Duration_points = floor(Sampling_Hz * Stimulus_duration);

%Data exploit from files
[MeanAllElectrodeTarget1d_Cmd1, SEAllTarget1d_Cmd1, MeanAllElectrodeNonTarget1d_Cmd1, SEAllNonTarget1d_Cmd1] = getERPfromCSV(AllTargetData_no1, AllNonTargetData_no1, Duration_points);
[MeanAllElectrodeTarget1d_Cmd2, SEAllTarget1d_Cmd2, MeanAllElectrodeNonTarget1d_Cmd2, SEAllNonTarget1d_Cmd2] = getERPfromCSV(AllTargetData_no2, AllNonTargetData_no2, Duration_points);
[MeanAllElectrodeTarget1d_Cmd3, SEAllTarget1d_Cmd3, MeanAllElectrodeNonTarget1d_Cmd3, SEAllNonTarget1d_Cmd3] = getERPfromCSV(AllTargetData_no3, AllNonTargetData_no3, Duration_points);
[MeanAllElectrodeTarget1d_Cmd4, SEAllTarget1d_Cmd4, MeanAllElectrodeNonTarget1d_Cmd4, SEAllNonTarget1d_Cmd4] = getERPfromCSV(AllTargetData_no4, AllNonTargetData_no4, Duration_points);

figure
subplot(2,2,1);
drawSignalGraph(MeanAllElectrodeTarget1d_Cmd1, SEAllTarget1d_Cmd1, MeanAllElectrodeNonTarget1d_Cmd1, SEAllNonTarget1d_Cmd1, 1, 'Stimulus1 - LeftHand', Stimulus_duration, Duration_points);

subplot(2,2,2);
drawSignalGraph(MeanAllElectrodeTarget1d_Cmd2, SEAllTarget1d_Cmd2, MeanAllElectrodeNonTarget1d_Cmd2, SEAllNonTarget1d_Cmd2, 1, 'Stimulus2 - RightHand', Stimulus_duration, Duration_points);

subplot(2,2,3);
drawSignalGraph(MeanAllElectrodeTarget1d_Cmd3, SEAllTarget1d_Cmd3, MeanAllElectrodeNonTarget1d_Cmd3, SEAllNonTarget1d_Cmd3, 1, 'Stimulus3 - LeftLeg', Stimulus_duration, Duration_points);

subplot(2,2,4);
drawSignalGraph(MeanAllElectrodeTarget1d_Cmd4, SEAllTarget1d_Cmd4, MeanAllElectrodeNonTarget1d_Cmd4, SEAllNonTarget1d_Cmd4, 1, 'Stimulus4 - RightLeg', Stimulus_duration, Duration_points);


end

function [AllData, Sampling_Hz] = fileProcessor_Stimulus(directory, File_dir_struct)
   
    AllData = [];
    File_dir_struct.name
    
    for i = 1:length(File_dir_struct)
        allData_struct = importdata(strcat('./', directory, '/', File_dir_struct(i).name));
        AllData = vertcat(AllData, allData_struct.data);
    end
    
    Sampling_Hz = allData_struct.data(1, end);
end