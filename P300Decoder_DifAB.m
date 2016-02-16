function P300Decoder_DifAB(directory, Stimulus_1duration, Stimulus_2duration, header)
% ===
% header ... [5] or [6] (Training or Trial)
header_str = num2str(header);

% === Take the datas from CSV files

if (header == 6)
    
    % For Trial
    %{
    File1_TargetCSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_Target1*.csv')]);
    File2_TargetCSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_Target2*.csv')]);
    File3_NonTargetCSV  = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_NonTarget3*.csv')]);
    File4_NonTargetCSV  = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_NonTarget4*.csv')]);

    File1_NonTargetCSV  = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_NonTarget1*.csv')]);
    File2_NonTargetCSV  = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_NonTarget2*.csv')]);
    File3_TargetCSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_Target3*.csv')]);
    File4_TargetCSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_Target4*.csv')]);
    %}
    File1_CSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-trialSignal_Label1(0.1-0.3)*.csv')]);
    File2_CSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-trialSignal_Label2(0.1-0.3)*.csv')]);
    File3_CSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-trialSignal_Label3(0.1-0.3)*.csv')]);
    File4_CSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-trialSignal_Label4(0.1-0.3)*.csv')]);

    % === Put them into Arrays
    %{
    [AllTargetData_no1, Sampling_Hz_256, Electrodes_8]              = fileProcessor_dir(directory, File1_TargetCSV);
    [AllTargetData_no2]              = fileProcessor_dir(directory, File2_TargetCSV);
    [AllNonTargetData_no3]           = fileProcessor_dir(directory, File3_NonTargetCSV);
    [AllNonTargetData_no4]           = fileProcessor_dir(directory, File4_NonTargetCSV);

    [AllNonTargetData_no1]           = fileProcessor_dir(directory, File1_NonTargetCSV);
    [AllNonTargetData_no2]           = fileProcessor_dir(directory, File2_NonTargetCSV);
    [AllTargetData_no3]              = fileProcessor_dir(directory, File3_TargetCSV);
    [AllTargetData_no4]              = fileProcessor_dir(directory, File4_TargetCSV);
    %}
    [Label1, Sampling_Hz_256, Electrodes_8] = fileProcessor_dir(directory, File1_CSV);
    [Label2] = fileProcessor_dir(directory, File2_CSV);
    [Label3] = fileProcessor_dir(directory, File3_CSV);
    [Label4] = fileProcessor_dir(directory, File4_CSV);
    
    Label1_Duration12 = Label1(1:510, :); Label2_Duration12 = Label2(1:510, :);
    Label3_Duration12 = Label3(1:510, :); Label4_Duration12 = Label4(1:510, :);
    Label1_Duration34 = Label1(511:1020, :); Label2_Duration34 = Label2(511:1020, :);
    Label3_Duration34 = Label3(511:1020, :); Label4_Duration34 = Label4(511:1020, :);
    
    % === Concentration & Average of each responses
    %{
    ClassA = vertcat((AllTargetData_no1+AllTargetData_no2)/2, (AllNonTargetData_no1+AllNonTargetData_no2)/2);
    ClassB = vertcat((AllTargetData_no3+AllTargetData_no3)/2, (AllNonTargetData_no4+AllNonTargetData_no4)/2);

    TargetA    = (AllTargetData_no1    + AllTargetData_no2)/2;
    NonTargetB = (AllNonTargetData_no3 + AllNonTargetData_no4)/2;

    NonTargetA = (AllNonTargetData_no1 + AllNonTargetData_no2)/2;
    TargetB    = (AllTargetData_no3    + AllTargetData_no4)/2;
    %}
    
    ClassA = (Label1+Label2)/2;
    ClassB = (Label3+Label4)/2;
    
    %duration 1&2
    TargetA = (Label1_Duration12+Label2_Duration12)/2;
    NonTargetB = (Label3_Duration12+Label4_Duration12)/2;
    
    %duration 3&4
    NonTargetA = (Label1_Duration34+Label2_Duration34)/2;
    TargetB = (Label3_Duration34+Label4_Duration34)/2;
    
    %Stimulus_duration = Stimulus_2duration;
    %gap = 0.0;
    Stimulus_duration = 0.2;
    gap = 0.1;
    %filename = '/_[6]2clsAB-Trial.png';
    filename = '/_[6]2clsAB-Sti1&2vsSti3&4inDur1&2-Sti1&2vsSti3&4inDur3&4.png';
    Ymax = 10.0; Ymin = -10.0;

elseif (header == 5)
    
    % For Training
    FileA_TargetCSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_TargetA*.csv')]);
    FileB_NonTargetCSV  = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_NonTargetB*.csv')]);
    
    FileA_NonTargetCSV  = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_NonTargetA*.csv')]);
    FileB_TargetCSV     = dir(['./', directory, horzcat('/[', header_str, '] P300-SBE_TargetB*.csv')]);

    % === Put them into Arrays
    [AllTargetData_clsA, Sampling_Hz_256, Electrodes_8]              = fileProcessor_dir(directory, FileA_TargetCSV);
    [AllNonTargetData_clsB]           = fileProcessor_dir(directory, FileB_NonTargetCSV);

    [AllNonTargetData_clsA]           = fileProcessor_dir(directory, FileA_NonTargetCSV);
    [AllTargetData_clsB]              = fileProcessor_dir(directory, FileB_TargetCSV);

    % === Concentration & Average of each responses
    ClassA = vertcat(AllTargetData_clsA, AllNonTargetData_clsA);
    ClassB = vertcat(AllTargetData_clsB, AllNonTargetData_clsB);
 
    TargetA    = AllTargetData_clsA;
    NonTargetB = AllNonTargetData_clsB;

    NonTargetA = AllNonTargetData_clsA;
    TargetB    = AllTargetData_clsB;
    
    % === Stimulus duration
    Stimulus_duration = Stimulus_1duration;
    gap = 0.0;
    filename = '/_[5]2clsAB-Training.png';
    Ymax = 7.0; Ymin = -7.0;
end

% === Filter and Dowmsampling
%Take BP Filter (0.1Hz-9Hz)
[ClassA_Filtered_P300, ClassB_Filtered_P300] = BPFilter(ClassA, ClassB, Electrodes_8);
[TargetA_Filtered_P300, NonTargetB_Filtered_P300] = BPFilter(TargetA, NonTargetB, Electrodes_8);
[NonTargetA_Filtered_P300, TargetB_Filtered_P300] = BPFilter(NonTargetA, TargetB, Electrodes_8);

%Downsampling (256Hz -> 64Hz)
%[ClassA_Filtered_P300_DS64Hz, ClassB_Filtered_P300_DS64Hz, Duration_points_256Hz_Downsampled] =...
%    DownSampling(ClassA_Filtered_P300, ClassB_Filtered_P300, Electrodes_8, floor(Sampling_Hz_256 * Stimulus_1duration));

% === Data exploit from files % === 
[EachElectrodeAveraged2d_2clsA, SEEachElectrode2d_2clsA, EachElectrodeAveraged2d_2clsB, SEEachElectrode2d_2clsB, ...
     MeanAllElectrode1d_2clsA, SEAll1d_2clsA, MeanAllElectrode1d_2clsB, SEAll1d_2clsB] = ...
     getERPfromCSV(ClassA_Filtered_P300(:, 1:8), ClassB_Filtered_P300(:, 1:8), floor(Sampling_Hz_256* Stimulus_duration));

[EachElectrodeAveraged2d_TargetA, SEEachElectrode2d_TargetA, EachElectrodeAveraged2d_NonTargetB, SEEachElectrode2d_NonTargetB, ...
     MeanAllElectrode1d_TargetA, SEAll1d_TargetA, MeanAllElectrode1d_NonTargetB, SEAll1d_NonTargetB] = ...
     getERPfromCSV(TargetA_Filtered_P300(:, 1:8), NonTargetB_Filtered_P300(:, 1:8), floor(Sampling_Hz_256* Stimulus_duration));

 [EachElectrodeAveraged2d_NonTargetA, SEEachElectrode2d_NonTargetA, EachElectrodeAveraged2d_TargetB, SEEachElectrode2d_TargetB, ...
     MeanAllElectrode1d_NonTargetA, SEAll1d_NonTargetA, MeanAllElectrode1d_TargetB, SEAll1d_TargetB] = ...
     getERPfromCSV(NonTargetA_Filtered_P300(:, 1:8), TargetB_Filtered_P300(:, 1:8), floor(Sampling_Hz_256* Stimulus_duration));

% === MeanAveragedGraph % === 
% -- SBE
figure
% -- 2cls / 3Channels Graph concering primary motor cortex 
subplot(3, 4, [1, 2, 3, 4])
drawSignalGraph_clsAB_TARGETDif(EachElectrodeAveraged2d_2clsA, SEEachElectrode2d_2clsA,...
     EachElectrodeAveraged2d_2clsB, SEEachElectrode2d_2clsB, [1 5 6], '2clsA vs 2clsB in Cz,C3,C4 AveragedSignals(DSed)',...
     Stimulus_duration, floor(Sampling_Hz_256* Stimulus_duration), gap, Ymax, Ymin);

subplot(3, 4, [5, 6, 7, 8])
drawSignalGraph_clsAB_TARGETDif(EachElectrodeAveraged2d_TargetA, SEEachElectrode2d_TargetA,...
     EachElectrodeAveraged2d_NonTargetB, SEEachElectrode2d_NonTargetB, [1 5 6], '2clsTargetA vs 2clsNonTargetB in Cz,C3,C4 AveragedSignals(DSed)',...
     Stimulus_duration, floor(Sampling_Hz_256* Stimulus_duration), gap, Ymax, Ymin);
 
subplot(3, 4, [9, 10, 11, 12])
drawSignalGraph_clsAB_TARGETDif(EachElectrodeAveraged2d_NonTargetA, SEEachElectrode2d_NonTargetA,...
     EachElectrodeAveraged2d_TargetB, SEEachElectrode2d_TargetB, [1 5 6], '2clsNonTargetA vs 2clsTargetB in Cz,C3,C4 AveragedSignals(DSed)',...
     Stimulus_duration, floor(Sampling_Hz_256* Stimulus_duration), gap, Ymax, Ymin);

filename_Mean = strcat(directory, filename);
set(gcf,'Position', [0 0 1920 1080], 'PaperPositionMode', 'auto')
print(filename_Mean,'-dpng','-r0')

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