function getEEGfromCSV

EEGFile=importdata('sampleEEG.csv');

%signal averaging over all channels
TimeAveraging(EEGFile, 1, 10, 0.5);

end