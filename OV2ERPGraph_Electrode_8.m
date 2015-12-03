function OV2ERPGraph_Electrode_8(filedir, year, month, day, hour, min, sec)

%These value must be set on 0.8 and 256 unless you use same patch
Stimulus_duration = 0.8;
Sampling_Hz = 256;
Duration_points = floor(Sampling_Hz * Stimulus_duration);
electrodes = {'Cz','CPz','P3','P4','C3','C4','CP5','CP6'};

identifier = strcat(filedir, '[', num2str(year) , '.', num2str(month), '.', num2str(day), '-', num2str(hour), '.', num2str(min), '.', num2str(sec), ']');

%=== Mean(all) ===
%=== Each Electrode ===
[EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d,...
    MeanAllElectrodeTarget1d, SEAllTarget1d, MeanAllElectrodeNonTarget1d, SEAllNonTarget1d] = getERPfromCSV(strcat(identifier, '-all'), Duration_points);

figure
subplot(3,3,8);
drawSignalGraph(MeanAllElectrodeTarget1d, SEAllTarget1d, MeanAllElectrodeNonTarget1d, SEAllNonTarget1d, 1, 'AllElectrodes', Stimulus_duration, Duration_points);

subplot(3,3,2);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 1, electrodes(1,1), Stimulus_duration, Duration_points);

subplot(3,3,5);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 2, electrodes(1,2), Stimulus_duration, Duration_points);

subplot(3,3,7);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 3, electrodes(1,3), Stimulus_duration, Duration_points);

subplot(3,3,9);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 4, electrodes(1,4), Stimulus_duration, Duration_points);

subplot(3,3,1);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 5, electrodes(1,5), Stimulus_duration, Duration_points);

subplot(3,3,3);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 6, electrodes(1,6), Stimulus_duration, Duration_points);

subplot(3,3,4);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 7, electrodes(1,7), Stimulus_duration, Duration_points);

subplot(3,3,6);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 8, electrodes(1,8), Stimulus_duration, Duration_points);

end