function TrialDecoderP300_6(directory, Stimulus_duration)

% === Take the datas from CSV files

File_TargetCSV     = dir(['./', directory, '/[6] P300-SBE-AllTarget*.csv']);
File_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE-AllNonTarget*.csv']);

FileA_TargetCSV       = dir(['./', directory, '/[6] P300-SBE_TargetA*.csv']);
FileA_NonTargetCSV    = dir(['./', directory, '/[6] P300-SBE_NonTargetA*.csv']);
FileB_TargetCSV       = dir(['./', directory, '/[6] P300-SBE_TargetB*.csv']);
FileB_NonTargetCSV    = dir(['./', directory, '/[6] P300-SBE_NonTargetB*.csv']);

File1_TargetCSV     = dir(['./', directory, '/[6] P300-SBE_Target1*.csv']);
File1_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE_NonTarget1*.csv']);
File2_TargetCSV     = dir(['./', directory, '/[6] P300-SBE_Target2*.csv']);
File2_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE_NonTarget2*.csv']);
File3_TargetCSV     = dir(['./', directory, '/[6] P300-SBE_Target3*.csv']);
File3_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE_NonTarget3*.csv']);
File4_TargetCSV     = dir(['./', directory, '/[6] P300-SBE_Target4*.csv']);
File4_NonTargetCSV  = dir(['./', directory, '/[6] P300-SBE_NonTarget4*.csv']);

% === Put them into Arrays
[AllTargetData, Sampling_Hz_256] = fileProcessor_dir(directory, File_TargetCSV);
[AllNonTargetData] = fileProcessor_dir(directory, File_NonTargetCSV);

[AllTargetData_clsA, Electrodes] = fileProcessor_dir(directory, FileA_TargetCSV);
[AllNonTargetData_clsA]           = fileProcessor_dir(directory, FileA_NonTargetCSV);
[AllTargetData_clsB]              = fileProcessor_dir(directory, FileB_TargetCSV);
[AllNonTargetData_clsB]           = fileProcessor_dir(directory, FileB_NonTargetCSV);

[AllTargetData_no1, Sampling_Hz_64, Electrodes] = fileProcessor_dir(directory, File1_TargetCSV);
[AllNonTargetData_no1]           = fileProcessor_dir(directory, File1_NonTargetCSV);
[AllTargetData_no2]              = fileProcessor_dir(directory, File2_TargetCSV);
[AllNonTargetData_no2]           = fileProcessor_dir(directory, File2_NonTargetCSV);
[AllTargetData_no3]              = fileProcessor_dir(directory, File3_TargetCSV);
[AllNonTargetData_no3]           = fileProcessor_dir(directory, File3_NonTargetCSV);
[AllTargetData_no4]              = fileProcessor_dir(directory, File4_TargetCSV);
[AllNonTargetData_no4]           = fileProcessor_dir(directory, File4_NonTargetCSV);

% === Filter and Dowmsampling

%Take BP Filter (5Hz-27Hz)
[AllTargetData_Filtered_P300, AllNonTargetData_Filtered_P300] = BPFilter(AllTargetData, AllNonTargetData, Electrodes);

[AllTargetData_Filtered_P300_no1, AllNonTargetData_Filtered_P300_no1] = BPFilter(AllTargetData_no1, AllNonTargetData_no1, Electrodes);
[AllTargetData_Filtered_P300_no2, AllNonTargetData_Filtered_P300_no2] = BPFilter(AllTargetData_no2, AllNonTargetData_no2, Electrodes);
[AllTargetData_Filtered_P300_no3, AllNonTargetData_Filtered_P300_no3] = BPFilter(AllTargetData_no3, AllNonTargetData_no3, Electrodes);
[AllTargetData_Filtered_P300_no4, AllNonTargetData_Filtered_P300_no4] = BPFilter(AllTargetData_no4, AllNonTargetData_no4, Electrodes);

%Downsampling (256Hz -> 64Hz)
[AllTargetData_Filtered_P300_DS64Hz, AllNonTargetData_Filtered_P300_DS64Hz, Duration_points_256Hz_Downsampled] = DownSampling(AllTargetData_Filtered_P300, AllNonTargetData_Filtered_P300, Electrodes, floor(Sampling_Hz_256 * Stimulus_duration));

[AllTargetData_Filtered_P300_DS64Hz_no1, AllNonTargetData_Filtered_P300_DS64Hz_no1] = DownSampling(AllTargetData_Filtered_P300_no1, AllNonTargetData_Filtered_P300_no1, Electrodes, floor(Sampling_Hz_256 * Stimulus_duration));
[AllTargetData_Filtered_P300_DS64Hz_no2, AllNonTargetData_Filtered_P300_DS64Hz_no2] = DownSampling(AllTargetData_Filtered_P300_no2, AllNonTargetData_Filtered_P300_no2, Electrodes, floor(Sampling_Hz_256 * Stimulus_duration));
[AllTargetData_Filtered_P300_DS64Hz_no3, AllNonTargetData_Filtered_P300_DS64Hz_no3] = DownSampling(AllTargetData_Filtered_P300_no3, AllNonTargetData_Filtered_P300_no3, Electrodes, floor(Sampling_Hz_256 * Stimulus_duration));
[AllTargetData_Filtered_P300_DS64Hz_no4, AllNonTargetData_Filtered_P300_DS64Hz_no4] = DownSampling(AllTargetData_Filtered_P300_no4, AllNonTargetData_Filtered_P300_no4, Electrodes, floor(Sampling_Hz_256 * Stimulus_duration));

% === Data exploit from files % === 
% 1 "All TARGET vs NonTARGET Stimulus(1cls)"
% BP Filter ... MATLAB
% Downsampling ... MATLAB(64Hz)
[EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, ...
    MeanAllElectrodeTarget1d_DS64Hz_8ch, SEAllTarget1d_DS64Hz_8ch, MeanAllElectrodeNonTarget1d_DS64Hz_8ch, SEAllNonTarget1d_DS64Hz_8ch] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz(:, 1:8), AllNonTargetData_Filtered_P300_DS64Hz(:, 1:8), Duration_points_256Hz_Downsampled);

% 2 "All clsA TARGET vs clsB TARGET Stimulus(2cls)"
% BP Filter ... OpenViBE
% Downsampling ... NOT (256Hz, because this result will taken the shape of the ERP response)
[EachElectrodeAveragedTarget2d_DS64Hz_2clsA, SEEachElectrodeTarget2d_DS64Hz_2clsA, EachElectrodeAveragedNonTarget2d_DS64Hz_2clsA, SEEachElectrodeNonTarget2d_DS64Hz_2clsA, ...
    MeanAllElectrodeTarget1d_DS64Hz_2clsA, SEAllTarget1d_DS64Hz_2clsA, MeanAllElectrodeNonTarget1d_DS64Hz_2clsA, SEAllNonTarget1d_DS64Hz_2clsA] = ...
    getERPfromCSV(AllTargetData_clsA(:, 2:9), AllNonTargetData_clsA(:, 2:9), floor(Sampling_Hz_256 * Stimulus_1duration));
[EachElectrodeAveragedTarget2d_DS64Hz_2clsB, SEEachElectrodeTarget2d_DS64Hz_2clsB, EachElectrodeAveragedNonTarget2d_DS64Hz_2clsB, SEEachElectrodeNonTarget2d_DS64Hz_2clsB, ...
    MeanAllElectrodeTarget1d_DS64Hz_2clsB, SEAllTarget1d_DS64Hz_2clsB, MeanAllElectrodeNonTarget1d_DS64Hz_2clsB, SEAllNonTarget1d_DS64Hz_2clsB] = ...
    getERPfromCSV(AllTargetData_clsB(:, 2:9), AllNonTargetData_clsB(:, 2:9), floor(Sampling_Hz_256 * Stimulus_1duration));

% 3 "TARGET vs NonTARGET Stimuli at each posiions(4cls)"
% BP Filter ... OpenViBE
% Downsampling ... OpenViBE (64Hz, because slide epoc is complicated to replicate in MATLAB)
[EachElectrodeAveragedTarget2d_DS64Hz_4cls1, SEEachElectrodeTarget2d_DS64Hz_4cls1, EachElectrodeAveragedNonTarget2d_DS64Hz_4cls1, SEEachElectrodeNonTarget2d_DS64Hz_4cls1,...
    MeanAllElectrodeTarget1d_DS64Hz_4cls1, SEAllTarget1d_DS64Hz_4cls1, MeanAllElectrodeNonTarget1d_DS64Hz_4cls1, SEAllNonTarget1d_DS64Hz_4cls1] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz_no1(:, 1:8), AllNonTargetData_Filtered_P300_DS64Hz_no1(:, 1:8),  Duration_points_256Hz_Downsampled);
[EachElectrodeAveragedTarget2d_DS64Hz_4cls2, SEEachElectrodeTarget2d_DS64Hz_4cls2, EachElectrodeAveragedNonTarget2d_DS64Hz_4cls2, SEEachElectrodeNonTarget2d_DS64Hz_4cls2,...
    MeanAllElectrodeTarget1d_DS64Hz_4cls2, SEAllTarget1d_DS64Hz_4cls2, MeanAllElectrodeNonTarget1d_DS64Hz_4cls2, SEAllNonTarget1d_DS64Hz_4cls2] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz_no2(:, 1:8), AllNonTargetData_Filtered_P300_DS64Hz_no2(:, 1:8),  Duration_points_256Hz_Downsampled);
[EachElectrodeAveragedTarget2d_DS64Hz_4cls3, SEEachElectrodeTarget2d_DS64Hz_4cls3, EachElectrodeAveragedNonTarget2d_DS64Hz_4cls3, SEEachElectrodeNonTarget2d_DS64Hz_4cls3,...
    MeanAllElectrodeTarget1d_DS64Hz_4cls3, SEAllTarget1d_DS64Hz_4cls3, MeanAllElectrodeNonTarget1d_DS64Hz_4cls3, SEAllNonTarget1d_DS64Hz_4cls3] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz_no3(:, 1:8), AllNonTargetData_Filtered_P300_DS64Hz_no3(:, 1:8),  Duration_points_256Hz_Downsampled);
[EachElectrodeAveragedTarget2d_DS64Hz_4cls4, SEEachElectrodeTarget2d_DS64Hz_4cls4, EachElectrodeAveragedNonTarget2d_DS64Hz_4cls4, SEEachElectrodeNonTarget2d_DS64Hz_4cls4,...
    MeanAllElectrodeTarget1d_DS64Hz_4cls4, SEAllTarget1d_DS64Hz_4cls4, MeanAllElectrodeNonTarget1d_DS64Hz_4cls4, SEAllNonTarget1d_DS64Hz_4cls4] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz_no4(:, 1:8), AllNonTargetData_Filtered_P300_DS64Hz_no4(:, 1:8),  Duration_points_256Hz_Downsampled);

% === MeanAveragedGraph % === 
figure
% -- SBE
subplot(3, 4, [1, 2, 3, 4])
drawSignalGraph(MeanAllElectrodeTarget1d_DS64Hz_8ch, SEAllTarget1d_DS64Hz_8ch, MeanAllElectrodeNonTarget1d_DS64Hz_8ch,...
    SEAllNonTarget1d_DS64Hz_8ch, 1, 'SBE-AllElectrodesMeanAverage(1-8Ch, Downsampled)', Stimulus_duration, Duration_points_256Hz_Downsampled, 0.0);

% -- 2cls / 3Channels Graph concering primary motor cortex 
subplot(3, 4, [5, 6, 7, 8])
drawSignalGraph_clsAB_TARGETDif(EachElectrodeAveragedTarget2d_DS64Hz_2clsA, SEEachElectrodeTarget2d_DS64Hz_2clsA,...
    EachElectrodeAveragedTarget2d_DS64Hz_2clsB, SEEachElectrodeTarget2d_DS64Hz_2clsB, [1 5 6], '2clsA/B vs Cz,C3,C4 TargetSignals(DSed)',...
    Stimulus_duration, floor(Sampling_Hz_256 * Stimulus_duration));

% -- 4cls
subplot(3, 4, 9)
drawSignalGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls1, SEAllTarget1d_DS64Hz_4cls1, MeanAllElectrodeNonTarget1d_DS64Hz_4cls1,...
    SEAllNonTarget1d_DS64Hz_4cls1, 1, '4cls1 SlideAve(1-8Ch, DSed)', Stimulus_duration, Duration_points_256Hz_Downsampled, 0.0);
subplot(3, 4, 10)
drawSignalGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls2, SEAllTarget1d_DS64Hz_4cls2, MeanAllElectrodeNonTarget1d_DS64Hz_4cls2,...
    SEAllNonTarget1d_DS64Hz_4cls2, 1, '4cls2 SlideAve(1-8Ch, DSed)', Stimulus_duration, Duration_points_256Hz_Downsampled, 0.0);
subplot(3, 4, 11)
drawSignalGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls3, SEAllTarget1d_DS64Hz_4cls3, MeanAllElectrodeNonTarget1d_DS64Hz_4cls3,...
    SEAllNonTarget1d_DS64Hz_4cls3, 1, '4cls3 SlideAve(1-8Ch, DSed)', Stimulus_duration, Duration_points_256Hz_Downsampled, 0.0);
subplot(3, 4, 12)
drawSignalGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls4, SEAllTarget1d_DS64Hz_4cls4, MeanAllElectrodeNonTarget1d_DS64Hz_4cls4,...
    SEAllNonTarget1d_DS64Hz_4cls4, 1, '4cls4 SlideAve(1-8Ch, DSed)', Stimulus_duration, Duration_points_256Hz_Downsampled, 0.0);

filename_Mean = strcat(directory, '/_[6]P3Response1-MeanSBE&2clsSBE&4clsSBE.png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto')
print(filename_Mean,'-dpng','-r0')


% === EachElectrodeGraph % === 
figure
subplot(2, 4, 1)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 1, Electrodes(1,1), Stimulus_duration, Duration_points_256Hz_Downsampled, 0.0);
subplot(2, 4, 2)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 2, Electrodes(1,2), Stimulus_duration, Duration_points_256Hz_Downsampled, 0.0);
subplot(2, 4, 3)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 3, Electrodes(1,3), Stimulus_duration, Duration_points_256Hz_Downsampled, 0.0);
subplot(2, 4, 4)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 4, Electrodes(1,4), Stimulus_duration, Duration_points_256Hz_Downsampled, 0.0);
subplot(2, 4, 5)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 5, Electrodes(1,5), Stimulus_duration, Duration_points_256Hz_Downsampled, 0.0);
subplot(2, 4, 6)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 6, Electrodes(1,6), Stimulus_duration, Duration_points_256Hz_Downsampled, 0.0);
subplot(2, 4, 7)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 7, Electrodes(1,7), Stimulus_duration, Duration_points_256Hz_Downsampled, 0.0);
subplot(2, 4, 8)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 8, Electrodes(1,8), Stimulus_duration, Duration_points_256Hz_Downsampled, 0.0);

filename_8ch = strcat(directory, '/_[6]P3Response2-8Chs.png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto')
print(filename_8ch,'-dpng','-r0')
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