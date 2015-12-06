function OV2ERPGraph_Stimulus_6()

%=== Each Stimulus ===
[MeanAllElectrodeTarget1d_Cmd1, SEAllTarget1d_Cmd1, MeanAllElectrodeNonTarget1d_Cmd1, SEAllNonTarget1d_Cmd1] = getERPfromCSV(strcat(identifier, '-no1'), Duration_points);
[MeanAllElectrodeTarget1d_Cmd2, SEAllTarget1d_Cmd2, MeanAllElectrodeNonTarget1d_Cmd2, SEAllNonTarget1d_Cmd2] = getERPfromCSV(strcat(identifier, '-no2'), Duration_points);
[MeanAllElectrodeTarget1d_Cmd3, SEAllTarget1d_Cmd3, MeanAllElectrodeNonTarget1d_Cmd3, SEAllNonTarget1d_Cmd3] = getERPfromCSV(strcat(identifier, '-no3'), Duration_points);
[MeanAllElectrodeTarget1d_Cmd4, SEAllTarget1d_Cmd4, MeanAllElectrodeNonTarget1d_Cmd4, SEAllNonTarget1d_Cmd4] = getERPfromCSV(strcat(identifier, '-no4'), Duration_points);
[MeanAllElectrodeTarget1d_Cmd5, SEAllTarget1d_Cmd5, MeanAllElectrodeNonTarget1d_Cmd5, SEAllNonTarget1d_Cmd5] = getERPfromCSV(strcat(identifier, '-no5'), Duration_points);
[MeanAllElectrodeTarget1d_Cmd6, SEAllTarget1d_Cmd6, MeanAllElectrodeNonTarget1d_Cmd6, SEAllNonTarget1d_Cmd6] = getERPfromCSV(strcat(identifier, '-no6'), Duration_points);

figure
subplot(2,3,1);
drawSignalGraph(MeanAllElectrodeTarget1d_Cmd1, SEAllTarget1d_Cmd1, MeanAllElectrodeNonTarget1d_Cmd1, SEAllNonTarget1d_Cmd1, 1, 'Stimulus1 - LeftHand', Stimulus_duration, Duration_points);

subplot(2,3,3);
drawSignalGraph(MeanAllElectrodeTarget1d_Cmd2, SEAllTarget1d_Cmd2, MeanAllElectrodeNonTarget1d_Cmd2, SEAllNonTarget1d_Cmd2, 1, 'Stimulus2 - RightHand', Stimulus_duration, Duration_points);

subplot(2,3,2);
drawSignalGraph(MeanAllElectrodeTarget1d_Cmd3, SEAllTarget1d_Cmd3, MeanAllElectrodeNonTarget1d_Cmd3, SEAllNonTarget1d_Cmd3, 1, 'Stimulus3 - Shoulder', Stimulus_duration, Duration_points);

subplot(2,3,5);
drawSignalGraph(MeanAllElectrodeTarget1d_Cmd4, SEAllTarget1d_Cmd4, MeanAllElectrodeNonTarget1d_Cmd4, SEAllNonTarget1d_Cmd4, 1, 'Stimulus4 - Waist', Stimulus_duration, Duration_points);

subplot(2,3,4);
drawSignalGraph(MeanAllElectrodeTarget1d_Cmd5, SEAllTarget1d_Cmd5, MeanAllElectrodeNonTarget1d_Cmd5, SEAllNonTarget1d_Cmd5, 1, 'Stimulus5 - LeftLeg', Stimulus_duration, Duration_points);

subplot(2,3,6);
drawSignalGraph(MeanAllElectrodeTarget1d_Cmd6, SEAllTarget1d_Cmd6, MeanAllElectrodeNonTarget1d_Cmd6, SEAllNonTarget1d_Cmd6, 1, 'Stimulus6 - RightLeg', Stimulus_duration, Duration_points);


end