function [EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d,...
    MeanAllElectrodeTarget1d, SEAllTarget1d, MeanAllElectrodeNonTarget1d, SEAllNonTarget1d]=getERPfromCSV(identifier, Duration_points)

TargetFileName = strcat(identifier, '-target-signal.csv');
NonTargetFileName = strcat(identifier, '-nontarget-signal.csv');

allTarget=importdata(TargetFileName);
allNonTarget=importdata(NonTargetFileName);

%Just put as a log
TargetFileName
NonTargetFileName 

%Sampling_Hz = allTarget.data(1, 10);
%Duration_points = floor(Sampling_Hz * Stimulus_duration);
SeparatedTargetNum = dot(size(allTarget.data(:,1))/Duration_points,[1 0]);
SeparatedNonTargetNum = dot(size(allNonTarget.data(:,1))/Duration_points,[1 0]);

SeparatedTargetNum
SeparatedNonTargetNum

%initiallize
SeparatedTarget3d = zeros(Duration_points, 8, SeparatedTargetNum);
SeparatedNonTarget3d  = zeros(Duration_points, 8, SeparatedNonTargetNum);
EachElectrodeAveragedTarget2d = zeros(Duration_points, 8);
EachElectrodeAveragedNonTarget2d = zeros(Duration_points, 8);
MeanAllElectrodeTarget1d = zeros(Duration_points, 1);
MeanAllElectrodeNonTarget1d = zeros(Duration_points, 1);

SDEachElectrodeTarget2d = zeros(Duration_points, 8);
SDEachElectrodeNonTarget2d  = zeros(Duration_points, 8);
SEEachElectrodeTarget2d = zeros(Duration_points, 8);
SEEachElectrodeNonTarget2d  = zeros(Duration_points, 8);
SDAllTarget1d = zeros(Duration_points, 1);
SDAllNonTarget1d = zeros(Duration_points, 1);
SEAllTarget1d = zeros(Duration_points, 1);
SEAllNonTarget1d = zeros(Duration_points, 1);

%Input data to 3 dimension array
%%Target
for k = 1:SeparatedTargetNum
    for j = 2:9
        for i = 1:Duration_points
           SeparatedTarget3d(i, j-1, k) = allTarget.data(i+(k-1)*Duration_points, j);   
        end
    end
end

%%NonTarget
for k = 1:SeparatedNonTargetNum
    for j = 2:9
        for i = 1:Duration_points
            SeparatedNonTarget3d(i, j-1, k) = allNonTarget.data(i+(k-1)*Duration_points, j);   
        end
    end
end

%whos SeparatedTarget3d
%whos SeparatedNonTarget3d

%=== ChannelAverage(2D) ===
%Contains each channels time averaged data (Column1-8)
%which averaged from 0 sec (each onset) to Stimulus_duration (ex. 0.8) sec

for j = 1:8
    for i = 1:Duration_points
        EachElectrodeAveragedTarget2d(i, j) = mean(SeparatedTarget3d(i, j, 1:SeparatedTargetNum));
        EachElectrodeAveragedNonTarget2d(i, j) = mean(SeparatedNonTarget3d(i, j, 1:SeparatedNonTargetNum));
    end
end

%whos EachElectrodeAveragedTarget2d
%whos EachElectrodeAveragedNonTarget2d

%=== SD for 2D ===
for j = 1:8
    for i = 1:Duration_points
        SDEachElectrodeTarget2d(i, j) = std(SeparatedTarget3d(i, j, 1:SeparatedTargetNum), 1, 3);
        SDEachElectrodeNonTarget2d(i, j) = std(SeparatedNonTarget3d(i, j, 1:SeparatedNonTargetNum), 1, 3);
    end
end

%whos SDEachElectrodeTarget2d
%whos SDEachElectrodeNonTarget2d

%=== SE for 2D ===
%Calculate each Timepoint SE

TargetEachChN = sqrt(SeparatedTargetNum);
NonTargetEachChN = sqrt(SeparatedNonTargetNum);

for j = 1:8
    for i = 1:Duration_points
        SEEachElectrodeTarget2d(i, j) = SDEachElectrodeTarget2d(i, j)/TargetEachChN;
        SEEachElectrodeNonTarget2d(i, j) = SDEachElectrodeNonTarget2d(i, j)/NonTargetEachChN;
    end
end

%whos SEEachElectrodeTarget2d
%whos SEEachElectrodeNonTarget2d

%=== MeanAverage(1D) ===
%Contains all channels averaged data (mean TimeAverage Comulmn1-8 -> Column1) 

for i = 1:Duration_points
    MeanAllElectrodeTarget1d(i, 1) = mean(EachElectrodeAveragedTarget2d(i, :));
    MeanAllElectrodeNonTarget1d(i, 1) = mean(EachElectrodeAveragedNonTarget2d(i, :));
end

%whos MeanAllElectrodeTarget1d
%whos MeanAllElectrodeNonTarget1d

%=== SD for 1D ===

rowTarget = zeros(Duration_points, 8 * SeparatedTargetNum);
rowNonTarget = zeros(Duration_points, 8 * SeparatedNonTargetNum);

%Put all EEG in a row (1~208 Timepoint) for SD/SE
for i = 1:Duration_points
    %Same result both k-prior and j-prior
    for k = 1: SeparatedTargetNum    
        for j = 1: 8
             rowTarget(i, 8*(k-1)+j) = SeparatedTarget3d(i, j, k);
        end
    end
end

for i = 1:Duration_points
    %Same result both k-prior and j-prior
    for k = 1: SeparatedNonTargetNum
        for j = 1: 8    
             rowNonTarget(i, 8*(k-1)+j) = SeparatedNonTarget3d(i, j, k);
        end
    end
end

%whos rowTarget
%whos rowNonTarget

%Calculate each Timepoint SD
for i = 1:Duration_points
    SDAllTarget1d(i, 1) = std(rowTarget(i, :), 1);
    SDAllNonTarget1d(i, 1) = std(rowNonTarget(i, :), 1);
end

%whos SDAllTarget1d
%whos SDAllNonTarget1d

%=== SE for 1D ===
%Calculate each Timepoint SE

TargetAllChN = sqrt(8 * SeparatedTargetNum);
NonTargetAllChN = sqrt(8 * SeparatedNonTargetNum);


for i = 1:Duration_points
    SEAllTarget1d(i, 1) = SDAllTarget1d(i, 1)/TargetAllChN;
    SEAllNonTarget1d(i, 1) = SDAllNonTarget1d(i, 1)/NonTargetAllChN;
end

%whos SEAllTarget1d
%whos SEAllNonTarget1d

end
