function OV2ERPGraph_Electrode_12(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, Stimulus_duration, Duration_points, Electrodes)

%=== Each Electrodes ===
figure
subplot(3,4,1);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 1, Electrodes(1,1), Stimulus_duration, Duration_points);

subplot(3,4,2);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 2, Electrodes(1,2), Stimulus_duration, Duration_points);

subplot(3,4,3);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 3, Electrodes(1,3), Stimulus_duration, Duration_points);

subplot(3,4,4);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 4, Electrodes(1,4), Stimulus_duration, Duration_points);

subplot(3,4,5);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 5, Electrodes(1,5), Stimulus_duration, Duration_points);

subplot(3,4,6);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 6, Electrodes(1,6), Stimulus_duration, Duration_points);

subplot(3,4,7);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 7, Electrodes(1,7), Stimulus_duration, Duration_points);

subplot(3,4,8);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 8, Electrodes(1,8), Stimulus_duration, Duration_points);

subplot(3,4,9);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 9, Electrodes(1,9), Stimulus_duration, Duration_points);

subplot(3,4,10);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 10, Electrodes(1,10), Stimulus_duration, Duration_points);

subplot(3,4,11);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 11, Electrodes(1,11), Stimulus_duration, Duration_points);

subplot(3,4,12);
drawSignalGraph(EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d, 12, Electrodes(1,12), Stimulus_duration, Duration_points);


end