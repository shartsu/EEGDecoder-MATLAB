function OV2ERPGraph_Stimulus_6(filedir, year, month, day, hour, min, sec)

%These value must be set on 0.8 and 256 unless you use same patch
Stimulus_duration = 0.8;
Sampling_Hz = 256;
Duration_points = floor(Sampling_Hz * Stimulus_duration);

identifier = strcat(filedir, '[', num2str(year) , '.', num2str(month), '.', num2str(day), '-', num2str(hour), '.', num2str(min), '.', num2str(sec), ']');

%=== Each Stimulus ===
[MeanAllElectrodeTarget1d_Ch1, SEAllTarget1d_Ch1, MeanAllElectrodeNonTarget1d_Ch1, SEAllNonTarget1d_Ch1] = getERPfromCSV(strcat(identifier, '-no1'), Duration_points);
[MeanAllElectrodeTarget1d_Ch2, SEAllTarget1d_Ch2, MeanAllElectrodeNonTarget1d_Ch2, SEAllNonTarget1d_Ch2] = getERPfromCSV(strcat(identifier, '-no2'), Duration_points);
[MeanAllElectrodeTarget1d_Ch3, SEAllTarget1d_Ch3, MeanAllElectrodeNonTarget1d_Ch3, SEAllNonTarget1d_Ch3] = getERPfromCSV(strcat(identifier, '-no3'), Duration_points);
[MeanAllElectrodeTarget1d_Ch4, SEAllTarget1d_Ch4, MeanAllElectrodeNonTarget1d_Ch4, SEAllNonTarget1d_Ch4] = getERPfromCSV(strcat(identifier, '-no4'), Duration_points);
[MeanAllElectrodeTarget1d_Ch5, SEAllTarget1d_Ch5, MeanAllElectrodeNonTarget1d_Ch5, SEAllNonTarget1d_Ch5] = getERPfromCSV(strcat(identifier, '-no5'), Duration_points);
[MeanAllElectrodeTarget1d_Ch6, SEAllTarget1d_Ch6, MeanAllElectrodeNonTarget1d_Ch6, SEAllNonTarget1d_Ch6] = getERPfromCSV(strcat(identifier, '-no6'), Duration_points);

figure
subplot(2,3,1);
drawSignalGraph(MeanAllElectrodeTarget1d_Ch1, SEAllTarget1d_Ch1, MeanAllElectrodeNonTarget1d_Ch1, SEAllNonTarget1d_Ch1, 1, 'Stimulus1 - LeftHand', Stimulus_duration, Duration_points);

subplot(2,3,3);
drawSignalGraph(MeanAllElectrodeTarget1d_Ch2, SEAllTarget1d_Ch2, MeanAllElectrodeNonTarget1d_Ch2, SEAllNonTarget1d_Ch2, 1, 'Stimulus2 - RightHand', Stimulus_duration, Duration_points);

subplot(2,3,2);
drawSignalGraph(MeanAllElectrodeTarget1d_Ch3, SEAllTarget1d_Ch3, MeanAllElectrodeNonTarget1d_Ch3, SEAllNonTarget1d_Ch3, 1, 'Stimulus3 - Shoulder', Stimulus_duration, Duration_points);

subplot(2,3,5);
drawSignalGraph(MeanAllElectrodeTarget1d_Ch4, SEAllTarget1d_Ch4, MeanAllElectrodeNonTarget1d_Ch4, SEAllNonTarget1d_Ch4, 1, 'Stimulus4 - Waist', Stimulus_duration, Duration_points);

subplot(2,3,4);
drawSignalGraph(MeanAllElectrodeTarget1d_Ch5, SEAllTarget1d_Ch5, MeanAllElectrodeNonTarget1d_Ch5, SEAllNonTarget1d_Ch5, 1, 'Stimulus5 - LeftLeg', Stimulus_duration, Duration_points);

subplot(2,3,6);
drawSignalGraph(MeanAllElectrodeTarget1d_Ch6, SEAllTarget1d_Ch6, MeanAllElectrodeNonTarget1d_Ch6, SEAllNonTarget1d_Ch6, 1, 'Stimulus6 - RightLeg', Stimulus_duration, Duration_points);


end