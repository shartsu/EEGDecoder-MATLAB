function TrainingDecoder_5(directory, Stimulus_duration)

% === Take the datas from CSV files

File_TargetCSV     = dir(['./', directory, '/[5] P300-SBE-AllTarget*.csv']);
File_NonTargetCSV  = dir(['./', directory, '/[5] P300-SBE-AllNonTarget*.csv']);

FileA_TargetCSV       = dir(['./', directory, '/[5] P300-SBE_TargetA*.csv']);
FileA_NonTargetCSV    = dir(['./', directory, '/[5] P300-SBE_NonTargetA*.csv']);
FileB_TargetCSV       = dir(['./', directory, '/[5] P300-SBE_TargetB*.csv']);
FileB_NonTargetCSV    = dir(['./', directory, '/[5] P300-SBE_NonTargetB*.csv']);

TrainSignal_Target1CSV       = dir(['./', directory, '/[5] P300-trainSignal_SlideTarget1*.csv']);
TrainSignal_NonTarget1CSV    = dir(['./', directory, '/[5] P300-trainSignal_SlideNonTarget1*.csv']);
TrainSignal_Target2CSV       = dir(['./', directory, '/[5] P300-trainSignal_SlideTarget2*.csv']);
TrainSignal_NonTarget2CSV    = dir(['./', directory, '/[5] P300-trainSignal_SlideNonTarget2*.csv']);
TrainSignal_Target3CSV       = dir(['./', directory, '/[5] P300-trainSignal_SlideTarget3*.csv']);
TrainSignal_NonTarget3CSV    = dir(['./', directory, '/[5] P300-trainSignal_SlideNonTarget3*.csv']);
TrainSignal_Target4CSV       = dir(['./', directory, '/[5] P300-trainSignal_SlideTarget4*.csv']);
TrainSignal_NonTarget4CSV    = dir(['./', directory, '/[5] P300-trainSignal_SlideNonTarget4*.csv']);

% === Put them into Arrays
[AllTargetData, Sampling_Hz_256, Electrodes] = fileProcessor_dir(directory, File_TargetCSV);
[AllNonTargetData] = fileProcessor_dir(directory, File_NonTargetCSV);

[AllTargetData_clsA]              = fileProcessor_dir(directory, FileA_TargetCSV);
[AllNonTargetData_clsA]           = fileProcessor_dir(directory, FileA_NonTargetCSV);
[AllTargetData_clsB]              = fileProcessor_dir(directory, FileB_TargetCSV);
[AllNonTargetData_clsB]           = fileProcessor_dir(directory, FileB_NonTargetCSV);

[TrainSignal_Target1, Sampling_Hz_64] = fileProcessor_dir(directory, TrainSignal_Target1CSV);
[TrainSignal_NonTarget1]           = fileProcessor_dir(directory, TrainSignal_NonTarget1CSV );
[TrainSignal_Target2]              = fileProcessor_dir(directory, TrainSignal_Target2CSV);
[TrainSignal_NonTarget2]           = fileProcessor_dir(directory, TrainSignal_NonTarget2CSV);
[TrainSignal_Target3]              = fileProcessor_dir(directory, TrainSignal_Target3CSV);
[TrainSignal_NonTarget3]           = fileProcessor_dir(directory, TrainSignal_NonTarget3CSV);
[TrainSignal_Target4]              = fileProcessor_dir(directory, TrainSignal_Target4CSV);
[TrainSignal_NonTarget4]           = fileProcessor_dir(directory, TrainSignal_NonTarget4CSV);

% === Filter and Dowmsampling

%Take BP Filter (5Hz-27Hz)
[AllTargetData_Filtered_P300, AllNonTargetData_Filtered_P300] = BPFilter(AllTargetData, AllNonTargetData, Electrodes);

%Downsampling (256Hz -> 64Hz)
[AllTargetData_Filtered_P300_DS64Hz, AllNonTargetData_Filtered_P300_DS64Hz, Duration_points_256Hz_Downsampled] =...
    DownSampling(AllTargetData_Filtered_P300, AllNonTargetData_Filtered_P300, Electrodes, floor(Sampling_Hz_256 * Stimulus_duration));

% === Data exploit from files % === 
% 256Hz -> 64Hz (Downsampled in this patch, Downsampling Method)
[EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, ...
    MeanAllElectrodeTarget1d_DS64Hz_8ch, SEAllTarget1d_DS64Hz_8ch, MeanAllElectrodeNonTarget1d_DS64Hz_8ch, SEAllNonTarget1d_DS64Hz_8ch] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz(:, 1:8), AllNonTargetData_Filtered_P300_DS64Hz(:, 1:8), Duration_points_256Hz_Downsampled);

% 256Hz (No dowmsampling because this result will taken the shape of the ERP response)
[EachElectrodeAveragedTarget2d_DS64Hz_2clsA, SEEachElectrodeTarget2d_DS64Hz_2clsA, EachElectrodeAveragedNonTarget2d_DS64Hz_2clsA, SEEachElectrodeNonTarget2d_DS64Hz_2clsA, ...
    MeanAllElectrodeTarget1d_DS64Hz_2clsA, SEAllTarget1d_DS64Hz_2clsA, MeanAllElectrodeNonTarget1d_DS64Hz_2clsA, SEAllNonTarget1d_DS64Hz_2clsA] = ...
    getERPfromCSV(AllTargetData_clsA(:, 2:9), AllNonTargetData_clsA(:, 2:9), floor(Sampling_Hz_256 * Stimulus_duration));
[EachElectrodeAveragedTarget2d_DS64Hz_2clsB, SEEachElectrodeTarget2d_DS64Hz_2clsB, EachElectrodeAveragedNonTarget2d_DS64Hz_2clsB, SEEachElectrodeNonTarget2d_DS64Hz_2clsB, ...
    MeanAllElectrodeTarget1d_DS64Hz_2clsB, SEAllTarget1d_DS64Hz_2clsB, MeanAllElectrodeNonTarget1d_DS64Hz_2clsB, SEAllNonTarget1d_DS64Hz_2clsB] = ...
    getERPfromCSV(AllTargetData_clsB(:, 2:9), AllNonTargetData_clsB(:, 2:9), floor(Sampling_Hz_256 * Stimulus_duration));

% 64Hz (Downsampled in OpenVibe, because slide epoc is complicated to replicate in MATLAB)
[EachElectrodeAveragedTarget2d_DS64Hz_4cls1, SEEachElectrodeTarget2d_DS64Hz_4cls1, EachElectrodeAveragedNonTarget2d_DS64Hz_4cls1, SEEachElectrodeNonTarget2d_DS64Hz_4cls1,...
    MeanAllElectrodeTarget1d_DS64Hz_4cls1, SEAllTarget1d_DS64Hz_4cls1, MeanAllElectrodeNonTarget1d_DS64Hz_4cls1, SEAllNonTarget1d_DS64Hz_4cls1] = ...
    getERPfromCSV(TrainSignal_Target1(:, 2:9), TrainSignal_NonTarget1(:, 2:9), floor(Sampling_Hz_64*0.7));
[EachElectrodeAveragedTarget2d_DS64Hz_4cls2, SEEachElectrodeTarget2d_DS64Hz_4cls2, EachElectrodeAveragedNonTarget2d_DS64Hz_4cls2, SEEachElectrodeNonTarget2d_DS64Hz_4cls2,...
    MeanAllElectrodeTarget1d_DS64Hz_4cls2, SEAllTarget1d_DS64Hz_4cls2, MeanAllElectrodeNonTarget1d_DS64Hz_4cls2, SEAllNonTarget1d_DS64Hz_4cls2] = ...
    getERPfromCSV(TrainSignal_Target2(:, 2:9), TrainSignal_NonTarget2(:, 2:9), floor(Sampling_Hz_64*0.7));
[EachElectrodeAveragedTarget2d_DS64Hz_4cls3, SEEachElectrodeTarget2d_DS64Hz_4cls3, EachElectrodeAveragedNonTarget2d_DS64Hz_4cls3, SEEachElectrodeNonTarget2d_DS64Hz_4cls3,...
    MeanAllElectrodeTarget1d_DS64Hz_4cls3, SEAllTarget1d_DS64Hz_4cls3, MeanAllElectrodeNonTarget1d_DS64Hz_4cls3, SEAllNonTarget1d_DS64Hz_4cls3] = ...
    getERPfromCSV(TrainSignal_Target3(:, 2:9), TrainSignal_NonTarget3(:, 2:9), floor(Sampling_Hz_64*0.7));
[EachElectrodeAveragedTarget2d_DS64Hz_4cls4, SEEachElectrodeTarget2d_DS64Hz_4cls4, EachElectrodeAveragedNonTarget2d_DS64Hz_4cls4, SEEachElectrodeNonTarget2d_DS64Hz_4cls4,...
    MeanAllElectrodeTarget1d_DS64Hz_4cls4, SEAllTarget1d_DS64Hz_4cls4, MeanAllElectrodeNonTarget1d_DS64Hz_4cls4, SEAllNonTarget1d_DS64Hz_4cls4] = ...
    getERPfromCSV(TrainSignal_Target4(:, 2:9), TrainSignal_NonTarget4(:, 2:9), floor(Sampling_Hz_64*0.7));

% === MeanAveragedGraph % === 
% -- SBE
figure
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
    SEAllNonTarget1d_DS64Hz_4cls1, 1, '4cls1 SlideAve(1-8Ch, DSed)', 0.7, floor(Sampling_Hz_64*0.7), 0.1);
subplot(3, 4, 10)
drawSignalGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls2, SEAllTarget1d_DS64Hz_4cls2, MeanAllElectrodeNonTarget1d_DS64Hz_4cls2,...
    SEAllNonTarget1d_DS64Hz_4cls2, 1, '4cls2 SlideAve(1-8Ch, DSed)', 0.7, floor(Sampling_Hz_64*0.7), 0.1);
subplot(3, 4, 11)
drawSignalGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls3, SEAllTarget1d_DS64Hz_4cls3, MeanAllElectrodeNonTarget1d_DS64Hz_4cls3,...
    SEAllNonTarget1d_DS64Hz_4cls3, 1, '4cls3 SlideAve(1-8Ch, DSed)', 0.7, floor(Sampling_Hz_64*0.7), 0.1);
subplot(3, 4, 12)
drawSignalGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls4, SEAllTarget1d_DS64Hz_4cls4, MeanAllElectrodeNonTarget1d_DS64Hz_4cls4,...
    SEAllNonTarget1d_DS64Hz_4cls4, 1, '4cls4 SlideAve(1-8Ch, DSed)', 0.7, floor(Sampling_Hz_64*0.7), 0.1);

filename_Mean = strcat(directory, '/_[5]P3Training1-MeanSBE&2clsSBE&4clsSlideSBE.png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto')
print(filename_Mean,'-dpng','-r0')


% === EachElectrodeGraph % === 
figure
subplot(2, 4, 1)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 1, Electrodes(1,1), 0.7, Duration_points_256Hz_Downsampled, 0.1);
subplot(2, 4, 2)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 2, Electrodes(1,2), 0.7, Duration_points_256Hz_Downsampled, 0.1);
subplot(2, 4, 3)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 3, Electrodes(1,3), 0.7, Duration_points_256Hz_Downsampled, 0.1);
subplot(2, 4, 4)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 4, Electrodes(1,4), 0.7, Duration_points_256Hz_Downsampled, 0.1);
subplot(2, 4, 5)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 5, Electrodes(1,5), 0.7, Duration_points_256Hz_Downsampled, 0.1);
subplot(2, 4, 6)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 6, Electrodes(1,6), 0.7, Duration_points_256Hz_Downsampled, 0.1);
subplot(2, 4, 7)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 7, Electrodes(1,7), 0.7, Duration_points_256Hz_Downsampled, 0.1);
subplot(2, 4, 8)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 8, Electrodes(1,8), 0.7, Duration_points_256Hz_Downsampled, 0.1);

filename_8ch = strcat(directory, '/_[5]P3Training2-8Chs.png');
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