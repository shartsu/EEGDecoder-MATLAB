function OV2ERPGraph(MeanAllElectrodeTarget1d, SEAllTarget1d, MeanAllElectrodeNonTarget1d, SEAllNonTarget1d, GraphTitle, Stimulus_duration, Duration_points, gap)

%=== Mean(all) ===
%figure
drawSignalGraph(MeanAllElectrodeTarget1d, SEAllTarget1d, MeanAllElectrodeNonTarget1d, SEAllNonTarget1d, 1, GraphTitle, Stimulus_duration, Duration_points, gap);

end