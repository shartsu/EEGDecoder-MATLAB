function mainEEGDecoder_dir(directory, Stimulus_duration)

File_TargetCSV     = dir(['./', directory, '/[6] P300-SBE-AllTarget*.csv']);
File_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE-AllNonTarget*.csv']);
File1_TargetCSV     = dir(['./', directory, '/[6] P300-SBE-Target1*.csv']);
File1_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE-NonTarget1*.csv']);
File2_TargetCSV     = dir(['./', directory, '/[6] P300-SBE-Target2*.csv']);
File2_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE-NonTarget2*.csv']);
File3_TargetCSV     = dir(['./', directory, '/[6] P300-SBE-Target3*.csv']);
File3_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE-NonTarget3*.csv']);
File4_TargetCSV     = dir(['./', directory, '/[6] P300-SBE-Target4*.csv']);
File4_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE-NonTarget4*.csv']);

%Firstly choose the target file(s)
[AllTargetData, Sampling_Hz, Electrodes] = fileProcessor_dir(directory, File_TargetCSV);
%Secondly choose the non-target file(s)
[AllNonTargetData] = fileProcessor_dir(directory, File_NonTargetCSV);

%Check how many data acquired
whos AllTargetData;
whos AllNonTargetData;
%Electrodes

Duration_points_256Hz = floor(Sampling_Hz * Stimulus_duration);

%Take BP Filter (5Hz-27Hz)
[AllTargetData_Filtered_P300, AllNonTargetData_Filtered_P300] = ...
    BPFilter(AllTargetData, AllNonTargetData, Electrodes);

%Downsampling (256Hz -> 64Hz)
[AllTargetData_Filtered_P300_DS64Hz, AllNonTargetData_Filtered_P300_DS64Hz, Duration_points_64Hz] = ...
    DownSampling(AllTargetData_Filtered_P300, AllNonTargetData_Filtered_P300, Electrodes, Duration_points_256Hz);

% === Data exploit from files % === 
% -- Raw(16Ch)
%{
[EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, ...
    MeanAllElectrodeTarget1d, SEAllTarget1d, MeanAllElectrodeNonTarget1d, SEAllNonTarget1d] = ...
    getERPfromCSV(AllTargetData_Filtered_P300, AllNonTargetData_Filtered_P300, Duration_points_256Hz);
% -- Raw(8Ch)
[EachElectrodeAveragedTarget2d_8ch, SEEachElectrodeTarget2d_8ch, EachElectrodeAveragedNonTarget2d_8ch, SEEachElectrodeNonTarget2d_8ch, ...
    MeanAllElectrodeTarget1d_8ch, SEAllTarget1d_8ch, MeanAllElectrodeNonTarget1d_8ch, SEAllNonTarget1d_8ch] = ...
    getERPfromCSV(AllTargetData_Filtered_P300(:, 1:8), AllNonTargetData_Filtered_P300(:, 1:8), Duration_points_256Hz);
%}
% -- Downsampled(16Ch)
%{
[EachElectrodeAveragedTarget2d_DS64Hz, SEEachElectrodeTarget2d_DS64Hz, EachElectrodeAveragedNonTarget2d_DS64Hz, SEEachElectrodeNonTarget2d_DS64Hz, ...
    MeanAllElectrodeTarget1d_DS64Hz, SEAllTarget1d_DS64Hz, MeanAllElectrodeNonTarget1d_DS64Hz, SEAllNonTarget1d_DS64Hz] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz, AllNonTargetData_Filtered_P300_DS64Hz, Duration_points_64Hz);
%}
% -- Downsampled(8Ch)
[EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, ...
    MeanAllElectrodeTarget1d_DS64Hz_8ch, SEAllTarget1d_DS64Hz_8ch, MeanAllElectrodeNonTarget1d_DS64Hz_8ch, SEAllNonTarget1d_DS64Hz_8ch] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz(:, 1:8), AllNonTargetData_Filtered_P300_DS64Hz(:, 1:8), Duration_points_64Hz);

% === MeanAveragedGraph % === 
% -- Raw(8Ch)
%{
OV2ERPGraph(MeanAllElectrodeTarget1d_8ch, SEAllTarget1d_8ch, ...
    MeanAllElectrodeNonTarget1d_8ch, SEAllNonTarget1d_8ch, 'AllElectrodesMeanAverage(1-8Ch)', Stimulus_duration, Duration_points_256Hz);
%}
% -- Downsampled(8Ch)
figure
OV2ERPGraph(MeanAllElectrodeTarget1d_DS64Hz_8ch, SEAllTarget1d_DS64Hz_8ch, MeanAllElectrodeNonTarget1d_DS64Hz_8ch,...
    SEAllNonTarget1d_DS64Hz_8ch, 'AllElectrodesMeanAverage(1-8Ch, Downsampled)',Stimulus_duration, Duration_points_64Hz);
filename_Mean = strcat(directory, '/_P3Response-Mean.png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto')
print(filename_Mean,'-dpng','-r0')

% === EachElectrodeGraph % === 
figure
OV2ERPGraph_Electrode_8(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch,...
    EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, Stimulus_duration, Duration_points_64Hz, Electrodes); 
filename_8Ch = strcat(directory, '/_P3Response-8Ch.png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto');
print(filename_8Ch,'-dpng','-r0')

%{
if(length(Electrodes) == 8)
    OV2ERPGraph_Electrode_8(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, Stimulus_duration, Duration_points_256Hz, Electrodes); 
    OV2ERPGraph_Electrode_8(EachElectrodeAveragedTarget2d_DS64Hz, SEEachElectrodeTarget2d_DS64Hz, EachElectrodeAveragedNonTarget2d_DS64Hz, SEEachElectrodeNonTarget2d_DS64Hz, Stimulus_duration, Duration_points_64Hz, Electrodes); 
elseif(length(Electrodes) == 12)
    OV2ERPGraph_Electrode_12(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, Stimulus_duration, Duration_points_256Hz, Electrodes); 
    OV2ERPGraph_Electrode_12(EachElectrodeAveragedTarget2d_DS64Hz, SEEachElectrodeTarget2d_DS64Hz, EachElectrodeAveragedNonTarget2d_DS64Hz, SEEachElectrodeNonTarget2d_DS64Hz, Stimulus_duration, Duration_points_64Hz, Electrodes); 
elseif(length(Electrodes) == 16)
    OV2ERPGraph_Electrode_16(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, Stimulus_duration, Duration_points_256Hz, Electrodes); 
    OV2ERPGraph_Electrode_16(EachElectrodeAveragedTarget2d_DS64Hz, SEEachElectrodeTarget2d_DS64Hz, EachElectrodeAveragedNonTarget2d_DS64Hz, SEEachElectrodeNonTarget2d_DS64Hz, Stimulus_duration, Duration_points_64Hz, Electrodes); 
end
%}
   

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