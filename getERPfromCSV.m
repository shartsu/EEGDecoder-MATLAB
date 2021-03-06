function [EachElectrodeAveragedTarget2d, SEEachElectrodeTarget2d, EachElectrodeAveragedNonTarget2d, SEEachElectrodeNonTarget2d,...
    MeanAllElectrodeTarget1d, SEAllTarget1d, MeanAllElectrodeNonTarget1d, SEAllNonTarget1d] = ...
    getERPfromCSV(AllTargetData, AllNonTargetData, Duration_points)

%How many Targets? and Non-Targets?
SeparatedTargetNum = dot(size(AllTargetData(:,1))/Duration_points,[1 0]);
SeparatedNonTargetNum = dot(size(AllNonTargetData(:,1))/Duration_points,[1 0]);
ChNum = dot(size(AllTargetData(1,:)), [0 1]);

%Just put as a log
%ChNum
%SeparatedTargetNum
%SeparatedNonTargetNum

%initiallize
SeparatedTarget3d = zeros(Duration_points, ChNum, SeparatedTargetNum);
SeparatedNonTarget3d  = zeros(Duration_points, ChNum, SeparatedNonTargetNum);
EachElectrodeAveragedTarget2d = zeros(Duration_points, ChNum);
EachElectrodeAveragedNonTarget2d = zeros(Duration_points, ChNum);
MeanAllElectrodeTarget1d = zeros(Duration_points, 1);
MeanAllElectrodeNonTarget1d = zeros(Duration_points, 1);

SDEachElectrodeTarget2d = zeros(Duration_points, ChNum);
SDEachElectrodeNonTarget2d  = zeros(Duration_points, ChNum);
SEEachElectrodeTarget2d = zeros(Duration_points, ChNum);
SEEachElectrodeNonTarget2d  = zeros(Duration_points, ChNum);
SDAllTarget1d = zeros(Duration_points, 1);
SDAllNonTarget1d = zeros(Duration_points, 1);
SEAllTarget1d = zeros(Duration_points, 1);
SEAllNonTarget1d = zeros(Duration_points, 1);

%Input data to 3 dimension array
%%Target
for k = 1:SeparatedTargetNum
    for j = 1:ChNum
        for i = 1:Duration_points
           tmp_Target = AllTargetData(i+(k-1)*Duration_points, j);
           if(tmp_Target >= 80 || tmp_Target <= -80) 
               SeparatedTarget3d(i, j, k) = NaN;
           else
               SeparatedTarget3d(i, j, k) = AllTargetData(i+(k-1)*Duration_points, j);
           end
        end
    end
end

%%NonTarget
for k = 1:SeparatedNonTargetNum
    for j = 1:ChNum
        for i = 1:Duration_points
           tmp_Nontarget = AllNonTargetData(i+(k-1)*Duration_points, j);
           if(tmp_Nontarget  >= 80 || tmp_Nontarget <= -80) 
               SeparatedNonTarget3d(i, j, k) = NaN;
           else
               SeparatedNonTarget3d(i, j, k) = AllNonTargetData(i+(k-1)*Duration_points, j);
           end
        end
    end
end

%whos SeparatedTarget3d
%whos SeparatedNonTarget3d

%=== ChannelAverage(2D) ===
%Contains each channels time averaged data (Column1-8)
%which averaged from 0 sec (each onset) to Stimulus_duration (ex. 0.8) sec

for j = 1:ChNum
    for i = 1:Duration_points
        EachElectrodeAveragedTarget2d(i, j) = nanmean(SeparatedTarget3d(i, j, 1:SeparatedTargetNum));
        EachElectrodeAveragedNonTarget2d(i, j) = nanmean(SeparatedNonTarget3d(i, j, 1:SeparatedNonTargetNum));
    end
end

%whos EachElectrodeAveragedTarget2d
%whos EachElectrodeAveragedNonTarget2d

%=== SD for 2D ===
for j = 1:ChNum
    for i = 1:Duration_points
        SDEachElectrodeTarget2d(i, j) = nanstd(SeparatedTarget3d(i, j, 1:SeparatedTargetNum), 1, 3);
        SDEachElectrodeNonTarget2d(i, j) = nanstd(SeparatedNonTarget3d(i, j, 1:SeparatedNonTargetNum), 1, 3);
    end
end

%whos SDEachElectrodeTarget2d
%whos SDEachElectrodeNonTarget2d

%=== SE for 2D ===
%Calculate each Timepoint SE

TargetEachChN = sqrt(SeparatedTargetNum);
NonTargetEachChN = sqrt(SeparatedNonTargetNum);

for j = 1:ChNum
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
    MeanAllElectrodeTarget1d(i, 1) = nanmean(EachElectrodeAveragedTarget2d(i, :));
    MeanAllElectrodeNonTarget1d(i, 1) = nanmean(EachElectrodeAveragedNonTarget2d(i, :));
end

%whos MeanAllElectrodeTarget1d
%whos MeanAllElectrodeNonTarget1d

%=== SD for 1D ===

rowTarget = zeros(Duration_points, ChNum * SeparatedTargetNum);
rowNonTarget = zeros(Duration_points, ChNum * SeparatedNonTargetNum);

%Put all EEG in a row (1~208 Timepoint) for SD/SE
for i = 1:Duration_points
    %Same result both k-prior and j-prior
    for k = 1: SeparatedTargetNum    
        for j = 1: ChNum
             rowTarget(i, ChNum*(k-1)+j) = SeparatedTarget3d(i, j, k);
        end
    end
end

for i = 1:Duration_points
    %Same result both k-prior and j-prior
    for k = 1: SeparatedNonTargetNum
        for j = 1: ChNum  
             rowNonTarget(i, ChNum*(k-1)+j) = SeparatedNonTarget3d(i, j, k);
        end
    end
end

%whos rowTarget
%whos rowNonTarget

%Calculate each Timepoint SD
for i = 1:Duration_points
    SDAllTarget1d(i, 1) = nanstd(rowTarget(i, :), 1);
    SDAllNonTarget1d(i, 1) = nanstd(rowNonTarget(i, :), 1);
end

%whos SDAllTarget1d
%whos SDAllNonTarget1d

%=== SE for 1D ===
%Calculate each Timepoint SE

TargetAllChN = sqrt(ChNum * SeparatedTargetNum);
NonTargetAllChN = sqrt(ChNum * SeparatedNonTargetNum);


for i = 1:Duration_points
    SEAllTarget1d(i, 1) = SDAllTarget1d(i, 1)/TargetAllChN;
    SEAllNonTarget1d(i, 1) = SDAllNonTarget1d(i, 1)/NonTargetAllChN;
end

%whos SEAllTarget1d
%whos SEAllNonTarget1d

end
