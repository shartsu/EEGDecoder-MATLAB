function OV2ERPGraph(MeanAllElectrodeTarget1d, SEAllTarget1d, MeanAllElectrodeNonTarget1d, SEAllNonTarget1d, Stimulus_duration, Duration_points)

%=== Mean(all) ===
figure
drawSignalGraph(MeanAllElectrodeTarget1d, SEAllTarget1d, MeanAllElectrodeNonTarget1d, SEAllNonTarget1d, 1, 'AllElectrodesMeanAverage', Stimulus_duration, Duration_points);

end