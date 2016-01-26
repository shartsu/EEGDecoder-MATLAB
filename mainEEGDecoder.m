function mainEEGDecoder(AllCh_TargetCSV, AllCh_NonTargetCSV, Stimulus_duration)

%::::::::::::::: ?(^o^)? Inputs ?(^o^)? :::::::::::::::::
% ARG1 == .csv file which only contains TARGET stimulus 
% ARG2 == .csv file which only contains Non-TARGET stimulus 
%      -- These files could be generated using the dispense patch which issued by me
%      -- https://github.com/shartsu/OpenViBETargetSeparatorP300
% ARG3 == Stimulus_duration (this value may 0.8 but depents on its environment) 
%::::: (C) Takumi Kodama, University of Tsukuba, Japan :::::

%Firstly choose the target file(s)
[AllTargetData, Sampling_Hz, Electrodes] = fileProcessor(AllCh_TargetCSV);
%Secondly choose the non-target file(s)
[AllNonTargetData] = fileProcessor(AllCh_NonTargetCSV);

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
[EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, ...
    MeanAllElectrodeTarget1d, SEAllTarget1d, MeanAllElectrodeNonTarget1d, SEAllNonTarget1d] = ...
    getERPfromCSV(AllTargetData_Filtered_P300, AllNonTargetData_Filtered_P300, Duration_points_256Hz);
% -- Raw(8Ch)
[EachElectrodeAveragedTarget2d_8ch, SEEachElectrodeTarget2d_8ch, EachElectrodeAveragedNonTarget2d_8ch, SEEachElectrodeNonTarget2d_8ch, ...
    MeanAllElectrodeTarget1d_8ch, SEAllTarget1d_8ch, MeanAllElectrodeNonTarget1d_8ch, SEAllNonTarget1d_8ch] = ...
    getERPfromCSV(AllTargetData_Filtered_P300(:, 1:8), AllNonTargetData_Filtered_P300(:, 1:8), Duration_points_256Hz);
% -- Downsampled(16Ch)
[EachElectrodeAveragedTarget2d_DS64Hz, SEEachElectrodeTarget2d_DS64Hz, EachElectrodeAveragedNonTarget2d_DS64Hz, SEEachElectrodeNonTarget2d_DS64Hz, ...
    MeanAllElectrodeTarget1d_DS64Hz, SEAllTarget1d_DS64Hz, MeanAllElectrodeNonTarget1d_DS64Hz, SEAllNonTarget1d_DS64Hz] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz, AllNonTargetData_Filtered_P300_DS64Hz, Duration_points_64Hz);
% -- Downsampled(8Ch)
[EachElectrodeAveragedTarget2d_DS64Hz_8ch, SEEachElectrodeTarget2d_DS64Hz_8ch, EachElectrodeAveragedNonTarget2d_DS64Hz_8ch, SEEachElectrodeNonTarget2d_DS64Hz_8ch, ...
    MeanAllElectrodeTarget1d_DS64Hz_8ch, SEAllTarget1d_DS64Hz_8ch, MeanAllElectrodeNonTarget1d_DS64Hz_8ch, SEAllNonTarget1d_DS64Hz_8ch] = ...
    getERPfromCSV(AllTargetData_Filtered_P300_DS64Hz(:, 1:8), AllNonTargetData_Filtered_P300_DS64Hz(:, 1:8), Duration_points_64Hz);

% === MeanAveragedGraph % === 
% -- Raw(8Ch)
OV2ERPGraph(MeanAllElectrodeTarget1d_8ch, SEAllTarget1d_8ch, ...
    MeanAllElectrodeNonTarget1d_8ch, SEAllNonTarget1d_8ch, 'AllElectrodesMeanAverage(1-8Ch)', Stimulus_duration, Duration_points_256Hz);
% -- Downsampled(8Ch)
OV2ERPGraph(MeanAllElectrodeTarget1d_DS64Hz_8ch, SEAllTarget1d_DS64Hz_8ch, ...
    MeanAllElectrodeNonTarget1d_DS64Hz_8ch, SEAllNonTarget1d_DS64Hz_8ch, 'AllElectrodesMeanAverage(1-8Ch, Downsampled)',Stimulus_duration, Duration_points_64Hz);

% === EachElectrodeGraph % === 

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

end