function P300Decoder_Filter4cls2cls(directory, Stimulus_1duration, Stimulus_2duration, header)
% ===
% header ... [5] or [6] (Training or Trial)
header_str = num2str(header);
% Caution! Now version is only for the file 6 for now (Filterling setting or so)

% === Take the datas from CSV files

File_TargetCSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE-AllTarget*.csv')]);
File_NonTargetCSV  = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE-AllNonTarget*.csv')]);

FileA_TargetCSV       = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_TargetA*.csv')]);
FileA_NonTargetCSV    = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_NonTargetA*.csv')]);
FileB_TargetCSV       = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_TargetB*.csv')]);
FileB_NonTargetCSV    = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_NonTargetB*.csv')]);

% TrainSignal_Target1CSV       = dir(['./', directory, horzcat('/[', header_str, '] P300-trainSignal_BlockTarget1*.csv']);
% TrainSignal_NonTarget1CSV    = dir(['./', directory, horzcat('/[', header_str, '] P300-trainSignal_BlockNonTarget1*.csv']);
% TrainSignal_Target2CSV       = dir(['./', directory, horzcat('/[', header_str, '] P300-trainSignal_BlockTarget2*.csv']);
% TrainSignal_NonTarget2CSV    = dir(['./', directory, horzcat('/[', header_str, '] P300-trainSignal_BlockNonTarget2*.csv']);
% TrainSignal_Target3CSV       = dir(['./', directory, horzcat('/[', header_str, '] P300-trainSignal_BlockTarget3*.csv']);
% TrainSignal_NonTarget3CSV    = dir(['./', directory, horzcat('/[', header_str, '] P300-trainSignal_BlockNonTarget3*.csv']);
% TrainSignal_Target4CSV       = dir(['./', directory, horzcat('/[', header_str, '] P300-trainSignal_BlockTarget4*.csv']);
% TrainSignal_NonTarget4CSV    = dir(['./', directory, horzcat('/[', header_str, '] P300-trainSignal_BlockNonTarget4*.csv']);

File1_TargetCSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_Target1*.csv')]);
File1_NonTargetCSV  = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_NonTarget1*.csv')]);
File2_TargetCSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_Target2*.csv')]);
File2_NonTargetCSV  = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_NonTarget2*.csv')]);
File3_TargetCSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_Target3*.csv')]);
File3_NonTargetCSV  = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_NonTarget3*.csv')]);
File4_TargetCSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_Target4*.csv')]);
File4_NonTargetCSV  = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_NonTarget4*.csv')]);

% === Put them into Arrays
[AllTargetData, Sampling_Hz_256, Electrodes_16] = fileProcessor_dir(directory, File_TargetCSV);
[AllNonTargetData] = fileProcessor_dir(directory, File_NonTargetCSV);

[AllTargetData_clsA, Sampling_Hz_256, Electrodes_8]  = fileProcessor_dir(directory, FileA_TargetCSV);
[AllNonTargetData_clsA]           = fileProcessor_dir(directory, FileA_NonTargetCSV);
[AllTargetData_clsB]              = fileProcessor_dir(directory, FileB_TargetCSV);
[AllNonTargetData_clsB]           = fileProcessor_dir(directory, FileB_NonTargetCSV);

[AllTargetData_no1] = fileProcessor_dir(directory, File1_TargetCSV);
[AllNonTargetData_no1]           = fileProcessor_dir(directory, File1_NonTargetCSV);
[AllTargetData_no2]              = fileProcessor_dir(directory, File2_TargetCSV);
[AllNonTargetData_no2]           = fileProcessor_dir(directory, File2_NonTargetCSV);
[AllTargetData_no3]              = fileProcessor_dir(directory, File3_TargetCSV);
[AllNonTargetData_no3]           = fileProcessor_dir(directory, File3_NonTargetCSV);
[AllTargetData_no4]              = fileProcessor_dir(directory, File4_TargetCSV);
[AllNonTargetData_no4]           = fileProcessor_dir(directory, File4_NonTargetCSV);

% === Filter and Dowmsampling

%Take BP Filter (5Hz-27Hz)
[AllTargetData_Filtered_P300, AllNonTargetData_Filtered_P300] = BPFilter(AllTargetData, AllNonTargetData, Electrodes_8);

[AllTargetData_clsA_Filtered_P300, AllNonTargetData_clsA_Filtered_P300] = BPFilter(AllTargetData_clsA, AllNonTargetData_clsA, Electrodes_8);
[AllTargetData_clsB_Filtered_P300, AllNonTargetData_clsB_Filtered_P300] = BPFilter(AllTargetData_clsB, AllNonTargetData_clsB, Electrodes_8);

[AllTargetData_no1_Filtered_P300, AllNonTargetData_no1_Filtered_P300] = BPFilter(AllTargetData_no1, AllNonTargetData_no1, Electrodes_8);
[AllTargetData_no2_Filtered_P300, AllNonTargetData_no2_Filtered_P300] = BPFilter(AllTargetData_no2, AllNonTargetData_no2, Electrodes_8);
[AllTargetData_no3_Filtered_P300, AllNonTargetData_no3_Filtered_P300] = BPFilter(AllTargetData_no3, AllNonTargetData_no3, Electrodes_8);
[AllTargetData_no4_Filtered_P300, AllNonTargetData_no4_Filtered_P300] = BPFilter(AllTargetData_no4, AllNonTargetData_no4, Electrodes_8);

%Downsampling (256Hz -> 64Hz)
[AllTargetData_Filtered_P300_DS64Hz, AllNonTargetData_Filtered_P300_DS64Hz, Duration_points_256Hz_Downsampled] =...
    DownSampling(AllTargetData_Filtered_P300, AllNonTargetData_Filtered_P300, Electrodes_8, floor(Sampling_Hz_256 * Stimulus_2duration));

%(Not for All clsA TARGET vs clsB TARGET Stimulus(2cls))

[AllTargetData_no1_Filtered_P300_DS64Hz, AllNonTargetData_no1_Filtered_P300_DS64Hz, Duration_points_256Hz_Downsampled] =...
    DownSampling(AllTargetData_no1_Filtered_P300, AllNonTargetData_no1_Filtered_P300, Electrodes_8, floor(Sampling_Hz_256 * Stimulus_2duration));
[AllTargetData_no2_Filtered_P300_DS64Hz, AllNonTargetData_no2_Filtered_P300_DS64Hz, Duration_points_256Hz_Downsampled] =...
    DownSampling(AllTargetData_no2_Filtered_P300, AllNonTargetData_no2_Filtered_P300, Electrodes_8, floor(Sampling_Hz_256 * Stimulus_2duration));
[AllTargetData_no3_Filtered_P300_DS64Hz, AllNonTargetData_no3_Filtered_P300_DS64Hz, Duration_points_256Hz_Downsampled] =...
    DownSampling(AllTargetData_no3_Filtered_P300, AllNonTargetData_no3_Filtered_P300, Electrodes_8, floor(Sampling_Hz_256 * Stimulus_2duration));
[AllTargetData_no4_Filtered_P300_DS64Hz, AllNonTargetData_no4_Filtered_P300_DS64Hz, Duration_points_256Hz_Downsampled] =...
    DownSampling(AllTargetData_no4_Filtered_P300, AllNonTargetData_no4_Filtered_P300, Electrodes_8, floor(Sampling_Hz_256 * Stimulus_2duration));

% === Data exploit from files % === 
% 1 "All TARGET vs NonTARGET Stimulus(1cls)"
% BP Filter ... MATLAB
% Downsampling ... MATLAB(64Hz)
[EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, ...
    MeanAllElectrodeTarget1d_DS64Hz_8ch, SEAllTarget1d_DS64Hz_8ch, MeanAllElectrodeNonTarget1d_DS64Hz_8ch, SEAllNonTarget1d_DS64Hz_8ch] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz(:, 1:8), AllNonTargetData_Filtered_P300_DS64Hz(:, 1:8), Duration_points_256Hz_Downsampled);

% 2 "All clsA TARGET vs clsB TARGET Stimulus(2cls)"
% BP Filter ... MATLAB
% Downsampling ... NOT (256Hz, because this result will taken the shape of the ERP response)
[EachElectrodeAveragedTarget2d_DS64Hz_2clsA, SEEachElectrodeTarget2d_DS64Hz_2clsA, EachElectrodeAveragedNonTarget2d_DS64Hz_2clsA, SEEachElectrodeNonTarget2d_DS64Hz_2clsA, ...
     MeanAllElectrodeTarget1d_DS64Hz_2clsA, SEAllTarget1d_DS64Hz_2clsA, MeanAllElectrodeNonTarget1d_DS64Hz_2clsA, SEAllNonTarget1d_DS64Hz_2clsA] = ...
     getERPfromCSV(AllTargetData_clsA_Filtered_P300(:, 1:8), AllNonTargetData_clsA_Filtered_P300(:, 1:8), floor(Sampling_Hz_256 * Stimulus_1duration));
[EachElectrodeAveragedTarget2d_DS64Hz_2clsB, SEEachElectrodeTarget2d_DS64Hz_2clsB, EachElectrodeAveragedNonTarget2d_DS64Hz_2clsB, SEEachElectrodeNonTarget2d_DS64Hz_2clsB, ...
     MeanAllElectrodeTarget1d_DS64Hz_2clsB, SEAllTarget1d_DS64Hz_2clsB, MeanAllElectrodeNonTarget1d_DS64Hz_2clsB, SEAllNonTarget1d_DS64Hz_2clsB] = ...
     getERPfromCSV(AllTargetData_clsB_Filtered_P300(:, 1:8), AllNonTargetData_clsB_Filtered_P300(:, 1:8), floor(Sampling_Hz_256 * Stimulus_1duration));

% 3 "TARGET vs NonTARGET Stimuli at each posiions(4cls)"
% BP Filter ... MATLAB
% Downsampling ... MATLAB(64Hz)
[EachElectrodeAveragedTarget2d_DS64Hz_4cls1, SEEachElectrodeTarget2d_DS64Hz_4cls1, EachElectrodeAveragedNonTarget2d_DS64Hz_4cls1, SEEachElectrodeNonTarget2d_DS64Hz_4cls1,...
    MeanAllElectrodeTarget1d_DS64Hz_4cls1, SEAllTarget1d_DS64Hz_4cls1, MeanAllElectrodeNonTarget1d_DS64Hz_4cls1, SEAllNonTarget1d_DS64Hz_4cls1] = ...
    getERPfromCSV(AllTargetData_no1_Filtered_P300_DS64Hz(:, 1:8), AllNonTargetData_no1_Filtered_P300_DS64Hz(:, 1:8), Duration_points_256Hz_Downsampled);
[EachElectrodeAveragedTarget2d_DS64Hz_4cls2, SEEachElectrodeTarget2d_DS64Hz_4cls2, EachElectrodeAveragedNonTarget2d_DS64Hz_4cls2, SEEachElectrodeNonTarget2d_DS64Hz_4cls2,...
    MeanAllElectrodeTarget1d_DS64Hz_4cls2, SEAllTarget1d_DS64Hz_4cls2, MeanAllElectrodeNonTarget1d_DS64Hz_4cls2, SEAllNonTarget1d_DS64Hz_4cls2] = ...
    getERPfromCSV(AllTargetData_no2_Filtered_P300_DS64Hz(:, 1:8), AllNonTargetData_no2_Filtered_P300_DS64Hz(:, 1:8), Duration_points_256Hz_Downsampled);
[EachElectrodeAveragedTarget2d_DS64Hz_4cls3, SEEachElectrodeTarget2d_DS64Hz_4cls3, EachElectrodeAveragedNonTarget2d_DS64Hz_4cls3, SEEachElectrodeNonTarget2d_DS64Hz_4cls3,...
    MeanAllElectrodeTarget1d_DS64Hz_4cls3, SEAllTarget1d_DS64Hz_4cls3, MeanAllElectrodeNonTarget1d_DS64Hz_4cls3, SEAllNonTarget1d_DS64Hz_4cls3] = ...
    getERPfromCSV(AllTargetData_no3_Filtered_P300_DS64Hz(:, 1:8), AllNonTargetData_no3_Filtered_P300_DS64Hz(:, 1:8), Duration_points_256Hz_Downsampled);
[EachElectrodeAveragedTarget2d_DS64Hz_4cls4, SEEachElectrodeTarget2d_DS64Hz_4cls4, EachElectrodeAveragedNonTarget2d_DS64Hz_4cls4, SEEachElectrodeNonTarget2d_DS64Hz_4cls4,...
    MeanAllElectrodeTarget1d_DS64Hz_4cls4, SEAllTarget1d_DS64Hz_4cls4, MeanAllElectrodeNonTarget1d_DS64Hz_4cls4, SEAllNonTarget1d_DS64Hz_4cls4] = ...
    getERPfromCSV(AllTargetData_no4_Filtered_P300_DS64Hz(:, 1:8), AllNonTargetData_no4_Filtered_P300_DS64Hz(:, 1:8), Duration_points_256Hz_Downsampled);

% === MeanAveragedGraph % === 
% -- SBE
figure
subplot(3, 4, [1, 2, 3, 4])
drawSignalGraph(MeanAllElectrodeTarget1d_DS64Hz_8ch, SEAllTarget1d_DS64Hz_8ch, MeanAllElectrodeNonTarget1d_DS64Hz_8ch,...
    SEAllNonTarget1d_DS64Hz_8ch, 1, 'SBE-AllElectrodesMeanAverage(1-8Ch, Downsampled)', Stimulus_2duration, Duration_points_256Hz_Downsampled, 0.0, 2.0, -2.0);

% -- 2cls / 3Channels Graph concering primary motor cortex 
gap = 0.0;
Ymax = 7.0; Ymin = -7.0; 
subplot(3, 4, [5, 6])
drawSignalGraph_clsAB_TARGETDif(EachElectrodeAveragedTarget2d_DS64Hz_2clsA, SEEachElectrodeTarget2d_DS64Hz_2clsA,...
     EachElectrodeAveragedNonTarget2d_DS64Hz_2clsA, SEEachElectrodeNonTarget2d_DS64Hz_2clsA, [1 5 6], '2clsA of Cz,C3,C4 Target ve NonTargetSignals(DSed)',...
     Stimulus_1duration, floor(Sampling_Hz_256 * Stimulus_1duration), gap, Ymax, Ymin);

subplot(3, 4, [7, 8])
drawSignalGraph_clsAB_TARGETDif(EachElectrodeAveragedTarget2d_DS64Hz_2clsB, SEEachElectrodeTarget2d_DS64Hz_2clsB,...
     EachElectrodeAveragedNonTarget2d_DS64Hz_2clsB, SEEachElectrodeNonTarget2d_DS64Hz_2clsB, [1 5 6], '2clsB of Cz,C3,C4 Target ve NonTargetSignals(DSed)',...
     Stimulus_1duration, floor(Sampling_Hz_256 * Stimulus_1duration), gap, Ymax, Ymin);
 
% -- 4cls
subplot(3, 4, 9)
drawSignalGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls1, SEAllTarget1d_DS64Hz_4cls1, MeanAllElectrodeNonTarget1d_DS64Hz_4cls1,...
    SEAllNonTarget1d_DS64Hz_4cls1, 1, '4cls 1Leftarm Ave(1-8Ch, DSed)', Stimulus_2duration, Duration_points_256Hz_Downsampled, 0.0, 5.0, -5.0);
subplot(3, 4, 10)
drawSignalGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls2, SEAllTarget1d_DS64Hz_4cls2, MeanAllElectrodeNonTarget1d_DS64Hz_4cls2,...
    SEAllNonTarget1d_DS64Hz_4cls2, 1, '4cls 2Rightarm Ave(1-8Ch, DSed)', Stimulus_2duration, Duration_points_256Hz_Downsampled, 0.0, 5.0, -5.0)
subplot(3, 4, 11)
drawSignalGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls3, SEAllTarget1d_DS64Hz_4cls3, MeanAllElectrodeNonTarget1d_DS64Hz_4cls3,...
    SEAllNonTarget1d_DS64Hz_4cls3, 1, '4cls 3Leftleg Ave(1-8Ch, DSed)', Stimulus_2duration, Duration_points_256Hz_Downsampled, 0.0, 5.0, -5.0)
subplot(3, 4, 12)
drawSignalGraph(MeanAllElectrodeTarget1d_DS64Hz_4cls4, SEAllTarget1d_DS64Hz_4cls4, MeanAllElectrodeNonTarget1d_DS64Hz_4cls4,...
    SEAllNonTarget1d_DS64Hz_4cls4, 1, '4cls 4Rightleg Ave(1-8Ch, DSed)', Stimulus_2duration, Duration_points_256Hz_Downsampled, 0.0, 5.0, -5.0)

filename_Mean = strcat(directory, '/_[5]P3Training1-MeanSBE&2clsSBE&4clsSlideSBE.png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto')
print(filename_Mean,'-dpng','-r0')


% === EachElectrodeGraph % === 
figure
subplot(2, 4, 1)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 1, Electrodes_8(1,1), Stimulus_2duration, Duration_points_256Hz_Downsampled, 0.0, 2.0, -2.0);
subplot(2, 4, 2)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 2, Electrodes_8(1,2), Stimulus_2duration, Duration_points_256Hz_Downsampled, 0.0, 2.0, -2.0);
subplot(2, 4, 3)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 3, Electrodes_8(1,3), Stimulus_2duration, Duration_points_256Hz_Downsampled, 0.0, 2.0, -2.0);
subplot(2, 4, 4)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 4, Electrodes_8(1,4), Stimulus_2duration, Duration_points_256Hz_Downsampled, 0.0, 2.0, -2.0);
subplot(2, 4, 5)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 5, Electrodes_8(1,5), Stimulus_2duration, Duration_points_256Hz_Downsampled, 0.0, 2.0, -2.0);
subplot(2, 4, 6)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 6, Electrodes_8(1,6), Stimulus_2duration, Duration_points_256Hz_Downsampled, 0.0, 2.0, -2.0);
subplot(2, 4, 7)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 7, Electrodes_8(1,7), Stimulus_2duration, Duration_points_256Hz_Downsampled, 0.0, 2.0, -2.0);
subplot(2, 4, 8)
drawSignalGraph(EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, 8, Electrodes_8(1,8), Stimulus_2duration, Duration_points_256Hz_Downsampled, 0.0, 2.0, -2.0);

filename_8ch = strcat(directory, '/_[5]P3Training2-8Chs.png');
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto')
print(filename_8ch,'-dpng','-r0')
end

function [AllData, Sampling_Hz, Electrodes] = fileProcessor_dir(directory, File_dir_struct)
   
    AllData = [];
    
    for i = 1:length(File_dir_struct)
        allData_struct = importdata(strcat('./', directory, '/', File_dir_struct(i).name));
        AllData = vertcat(AllData, allData_struct.data);
    end
    
    Sampling_Hz = allData_struct.data(1, end);
    Electrodes = allData_struct.textdata(1, 2:(end-1));
end