function main(File1_TargetCSV, File1_NonTargetCSV, Stimulus_duration)

%::::::::::::::: ?(^o^)? Inputs ?(^o^)? :::::::::::::::::
% ARG1 == .csv file which only contains TARGET stimulus 
% ARG2 == .csv file which only contains Non-TARGET stimulus 
%      -- These files could be generated using the dispense patch which issued by me
%      -- https://github.com/shartsu/OpenViBETargetSeparatorP300
% ARG3 == Stimulus_duration (this value may 0.8 but depents on its environment) 
%::::: (C) Takumi Kodama, University of Tsukuba, Japan :::::

%Firstly choose the target file(s)
[AllTargetData, Sampling_Hz, Electrodes] = fileProcessor(File1_TargetCSV);
%Secondly choose the non-target file(s)
[AllNonTargetData] = fileProcessor(File1_NonTargetCSV);

%Check how many data acquired
whos AllTargetData;
whos AllNonTargetData;
Electrodes
 
Duration_points = floor(Sampling_Hz * Stimulus_duration);

%Data exploit from files
[EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d,...
    MeanAllElectrodeTarget1d, SEAllTarget1d, MeanAllElectrodeNonTarget1d, SEAllNonTarget1d] = getERPfromCSV(AllTargetData, AllNonTargetData, Duration_points);

%MeanAverageGraph
OV2ERPGraph(MeanAllElectrodeTarget1d, SEAllTarget1d, MeanAllElectrodeNonTarget1d, SEAllNonTarget1d, Stimulus_duration, Duration_points)

%EachElectrodeGraph
if(length(Electrodes) == 8); OV2ERPGraph_Electrode_8(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, Stimulus_duration, Duration_points, Electrodes); end
if(length(Electrodes) == 12); OV2ERPGraph_Electrode_12(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, Stimulus_duration, Duration_points, Electrodes); end
if(length(Electrodes) == 16); OV2ERPGraph_Electrode_16(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, Stimulus_duration, Duration_points, Electrodes); end

end