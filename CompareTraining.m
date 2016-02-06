function CompareTraining(directory, Stimulus_duration)

TrainSignal_AllTargetCSV     = dir(['./', directory, '/[5] P300-trainSignal_AllTarget*.csv']);
TrainSignal_AllNonTargetCSV  = dir(['./', directory, '/[5] P300-trainSignal_AllNonTarget*.csv']);
TrainSignal_TargetACSV       = dir(['./', directory, '/[5] P300-trainSignal_TargetA*.csv']);
TrainSignal_NonTargetACSV    = dir(['./', directory, '/[5] P300-trainSignal_NonTargetA*.csv']);
TrainSignal_TargetBCSV       = dir(['./', directory, '/[5] P300-trainSignal_TargetB*.csv']);
TrainSignal_NonTargetBCSV    = dir(['./', directory, '/[5] P300-trainSignal_NonTargetB*.csv']);
TrainSignal_Target1CSV       = dir(['./', directory, '/[5] P300-trainSignal_Target1*.csv']);
TrainSignal_NonTarget1CSV    = dir(['./', directory, '/[5] P300-trainSignal_NonTarget1*.csv']);
TrainSignal_Target2CSV       = dir(['./', directory, '/[5] P300-trainSignal_Target2*.csv']);
TrainSignal_NonTarget2CSV    = dir(['./', directory, '/[5] P300-trainSignal_NonTarget2*.csv']);
TrainSignal_Target3CSV       = dir(['./', directory, '/[5] P300-trainSignal_Target3*.csv']);
TrainSignal_NonTarget3CSV    = dir(['./', directory, '/[5] P300-trainSignal_NonTarget3*.csv']);
TrainSignal_Target4CSV       = dir(['./', directory, '/[5] P300-trainSignal_Target4*.csv']);
TrainSignal_NonTarget4CSV    = dir(['./', directory, '/[5] P300-trainSignal_NonTarget4*.csv']);

[TrainSignal_AllTarget, Sampling_Hz, Electrodes] = fileProcessor_dir(directory, TrainSignal_AllTargetCSV);
[TrainSignal_AllNonTarget]           = fileProcessor_dir(directory, TrainSignal_AllNonTargetCSV);
[TrainSignal_TargetA]              = fileProcessor_dir(directory, TrainSignal_TargetACSV);
[TrainSignal_NonTargetA]           = fileProcessor_dir(directory, TrainSignal_NonTargetACSV);
[TrainSignal_TargetB]              = fileProcessor_dir(directory, TrainSignal_TargetBCSV);
[TrainSignal_NonTargetB]           = fileProcessor_dir(directory, TrainSignal_NonTargetBCSV);
[TrainSignal_Target1]              = fileProcessor_dir(directory, TrainSignal_Target1CSV);
[TrainSignal_NonTarget1]           = fileProcessor_dir(directory, TrainSignal_NonTarget1CSV );
[TrainSignal_Target2]              = fileProcessor_dir(directory, TrainSignal_Target2CSV);
[TrainSignal_NonTarget2]           = fileProcessor_dir(directory, TrainSignal_NonTarget2CSV);
[TrainSignal_Target3]              = fileProcessor_dir(directory, TrainSignal_Target3CSV);
[TrainSignal_NonTarget3]           = fileProcessor_dir(directory, TrainSignal_NonTarget3CSV);
[TrainSignal_Target4]              = fileProcessor_dir(directory, TrainSignal_Target4CSV);
[TrainSignal_NonTarget4]           = fileProcessor_dir(directory, TrainSignal_NonTarget4CSV);

Duration_points_64Hz = floor(Sampling_Hz * Stimulus_duration);

% === Data exploit from files % === 
% -- Raw(8Ch)

[MeanAllElectrodeTarget1d_DS64Hz_1cls, SEAllTarget1d_DS64Hz_1cls, MeanAllElectrodeNonTarget1d_DS64Hz_1cls, SEAllNonTarget1d_DS64Hz_1cls] = ...
    getERPfromCSV(TrainSignal_AllTarget(:, 2:9), TrainSignal_AllNonTarget(:, 2:9), Duration_points_64Hz);
[MeanAllElectrodeTarget1d_DS64Hz_2clsA, SEAllTarget1d_DS64Hz_2clsA, MeanAllElectrodeNonTarget1d_DS64Hz_2clsA, SEAllNonTarget1d_DS64Hz_2clsA] = ...
    getERPfromCSV(TrainSignal_TargetA(:, 2:9), TrainSignal_NonTargetA(:, 2:9), Duration_points_64Hz);
[MeanAllElectrodeTarget1d_DS64Hz_2clsB, SEAllTarget1d_DS64Hz_2clsB, MeanAllElectrodeNonTarget1d_DS64Hz_2clsB, SEAllNonTarget1d_DS64Hz_2clsB] = ...
    getERPfromCSV(TrainSignal_TargetB(:, 2:9), TrainSignal_NonTargetB(:, 2:9), Duration_points_64Hz);
[MeanAllElectrodeTarget1d_DS64Hz_4cls1, SEAllTarget1d_DS64Hz_4cls1, MeanAllElectrodeNonTarget1d_DS64Hz_4cls1, SEAllNonTarget1d_DS64Hz_4cls1] = ...
    getERPfromCSV(TrainSignal_Target1(:, 2:9), TrainSignal_NonTarget1(:, 2:9), Duration_points_64Hz);
[MeanAllElectrodeTarget1d_DS64Hz_4cls2, SEAllTarget1d_DS64Hz_4cls2, MeanAllElectrodeNonTarget1d_DS64Hz_4cls2, SEAllNonTarget1d_DS64Hz_4cls2] = ...
    getERPfromCSV(TrainSignal_Target2(:, 2:9), TrainSignal_NonTarget2(:, 2:9), Duration_points_64Hz);
[MeanAllElectrodeTarget1d_DS64Hz_4cls3, SEAllTarget1d_DS64Hz_4cls3, MeanAllElectrodeNonTarget1d_DS64Hz_4cls3, SEAllNonTarget1d_DS64Hz_4cls3] = ...
    getERPfromCSV(TrainSignal_Target3(:, 2:9), TrainSignal_NonTarget3(:, 2:9), Duration_points_64Hz);
[MeanAllElectrodeTarget1d_DS64Hz_4cls4, SEAllTarget1d_DS64Hz_4cls4, MeanAllElectrodeNonTarget1d_DS64Hz_4cls4, SEAllNonTarget1d_DS64Hz_4cls4] = ...
    getERPfromCSV(TrainSignal_Target4(:, 2:9), TrainSignal_NonTarget4(:, 2:9), Duration_points_64Hz);


% === MeanAveragedGraph % === 
% -- 1cls
figure
subplot(3, 4, [1, 2, 3, 4])
OV2ERPGraph(MeanAllElectrodeTarget1d_DS64Hz_1cls, SEAllTarget1d_DS64Hz_1cls, MeanAllElectrodeNonTarget1d_DS64Hz_1cls,...
    SEAllNonTarget1d_DS64Hz_1cls, '1cls(1-8Ch, Downsampled)',Stimulus_duration, Duration_points_64Hz);

% -- 2cls
subplot(3, 4, [5, 6])
OV2ERPGraph(MeanAllElectrodeTarget1d_DS64Hz_2clsA, SEAllTarget1d_DS64Hz_2clsA, MeanAllElectrodeNonTarget1d_DS64Hz_2clsA,...
    SEAllNonTarget1d_DS64Hz_2clsA, '2clsA(1-8Ch, Downsampled)',Stimulus_duration, Duration_points_64Hz);
subplot(3, 4, [7, 8])
OV2ERPGraph(MeanAllElectrodeTarget1d_DS64Hz_2clsB, SEAllTarget1d_DS64Hz_2clsB, MeanAllElectrodeNonTarget1d_DS64Hz_2clsB,...
    SEAllNonTarget1d_DS64Hz_2clsB, '2clsB(1-8Ch, Downsampled)',Stimulus_duration, Duration_points_64Hz);

% -- 4cls
subplot(3, 4, 9)
OV2ERPGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls1, SEAllTarget1d_DS64Hz_4cls1, MeanAllElectrodeNonTarget1d_DS64Hz_4cls1,...
    SEAllNonTarget1d_DS64Hz_4cls1, '4cls1(1-8Ch, Downsampled)',Stimulus_duration, Duration_points_64Hz);
subplot(3, 4, 10)
OV2ERPGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls2, SEAllTarget1d_DS64Hz_4cls2, MeanAllElectrodeNonTarget1d_DS64Hz_4cls2,...
    SEAllNonTarget1d_DS64Hz_4cls2, '4cls2(1-8Ch, Downsampled)',Stimulus_duration, Duration_points_64Hz);
subplot(3, 4, 11)
OV2ERPGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls3, SEAllTarget1d_DS64Hz_4cls3, MeanAllElectrodeNonTarget1d_DS64Hz_4cls3,...
    SEAllNonTarget1d_DS64Hz_4cls3, '4cls3(1-8Ch, Downsampled)',Stimulus_duration, Duration_points_64Hz);
subplot(3, 4, 12)
OV2ERPGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls4, SEAllTarget1d_DS64Hz_4cls4, MeanAllElectrodeNonTarget1d_DS64Hz_4cls4,...
    SEAllNonTarget1d_DS64Hz_4cls4, '4cls4(1-8Ch, Downsampled)',Stimulus_duration, Duration_points_64Hz);

filename_Mean = strcat(directory, '/_P3Training.png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto')
print(filename_Mean,'-dpng','-r0')


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