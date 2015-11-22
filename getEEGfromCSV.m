function getEEGfromCSV(file_allTarget, file_allNonTarget, Stimulus_duration)

allTarget=importdata(file_allTarget);
allNonTarget=importdata(file_allNonTarget);

%signal averaging over all channels
%TimeAveraging(EEGFile, 1, 10, 0.5);

Sampling_Hz = allTarget.data(1, 10);
Duration_points = floor(Sampling_Hz * Stimulus_duration);
SeparatedTargetNum = dot(size(allTarget.data(:,1))/Duration_points,[1 0]);
SeparatedNonTargetNum = dot(size(allNonTarget.data(:,1))/Duration_points,[1 0]);

%initiallize
SeparatedTarget3d = zeros(Duration_points, 8, SeparatedTargetNum);
SeparatedNonTarget3d  = zeros(Duration_points, 8, SeparatedNonTargetNum);
AveragedSeparatedTarget2d = zeros(Duration_points, 8);
AveragedSeparatedNonTarget2d  = zeros(Duration_points, 8);
AveragedAllTarget1d = zeros(Duration_points, 1);
AveragedAllNonTarget1d = zeros(Duration_points, 1);
SDTarget2d = zeros(Duration_points, 8);
SDNonTarget2d  = zeros(Duration_points, 8);
SDTarget1d = zeros(Duration_points, 1);
SDNonTarget1d  = zeros(Duration_points, 1);

aveTarget = zeros(Duration_points, 1);
aveNonTarget  = zeros(Duration_points, 1);

SETarget = zeros(Duration_points, 1);
SENonTarget  = zeros(Duration_points, 1);



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

whos SeparatedTarget3d
whos SeparatedNonTarget3d

%=== TimeAverage(2D) ===
%Contains each channels time averaged data (Column1-8)
%which averaged from 0 sec (each onset) to Stimulus_duration (ex. 0.8) sec

for j = 1:8
    for i = 1:Duration_points
        AveragedSeparatedTarget2d(i, j) = mean(SeparatedTarget3d(i, j, 1:SeparatedTargetNum));
        AveragedSeparatedNonTarget2d(i, j) = mean(SeparatedNonTarget3d(i, j, 1:SeparatedNonTargetNum));
    end
end

whos AveragedSeparatedTarget2d
whos AveragedSeparatedNonTarget2d


%=== MeanAverage ===
%Contains all channels averaged data (mean TimeAverage Comulmn1-8 -> Column1) 

for i = 1:Duration_points
    AveragedAllTarget1d(i, 1) = mean(AveragedSeparatedTarget2d(i, :));
    AveragedAllNonTarget1d(i, 1) = mean(AveragedSeparatedNonTarget2d(i, :));
end

whos AveragedAllTarget1d
whos AveragedAllNonTarget1d

%=== SD for 2D ===
for j = 1:8
    for i = 1:Duration_points
        SDTarget2d(i, j) = std(SeparatedTarget3d(i, j, 1:SeparatedTargetNum), 1, 3);
        SDNonTarget2d(i, j) = std(SeparatedTarget3d(i, j, 1:SeparatedTargetNum), 1, 3);
    end
end

whos SDTarget2d
whos SDNonTarget2d

%=== SD for 1D ===
%{
for i = 1:Duration_points
    SDTarget1d(i, 1) = std(SeparatedTarget3d(i, :, :), 1, 3);
end
%}

%*=*=*=*=*=*= Just keep as reference *=*=*=*=*=*=*=
%(Different way to calclate EEG average wave)
%{
for j = 2:9
    for i = 1:1:Duration_points
        aveTarget(i, j) = mean(allTarget.data(i:Duration_points:size(allTarget.data), j));
        aveNonTarget(i, j) = mean(allNonTarget.data(i:Duration_points:size(allNonTarget.data), j));
    end
end

aveTarget(:,1) = mean(aveTarget(:,1:8),2);
aveNonTarget(:,1) = mean(aveNonTarget(:,1:8),2);

whos aveTarget
whos aveNonTarget
%}
%*=*=*=*=*=*= Just keep as reference *=*=*=*=*=*=*=

%=== SD/SE from all data ===

%?????????z?????SD???
whos SDTargets2

%{
SETargets = SDTargets/sqrt(size(aveTarget,1));
SENonTargets = SDNonTargets/sqrt(size(allNonTarget,1));

whos SDTargets
whos SDNonTargets

whos aveAll

X = linspace(0, Stimulus_duration, Duration_points);
whos X

%Each channel graph
figure
plot(X, AveragedAllTarget1d(:,1), '-o', X, AveragedAllNonTarget1d(:,1), '-*', ...
    X, AveragedSeparatedTarget2d(:,1), X, AveragedSeparatedTarget2d(:,2), X, AveragedSeparatedTarget2d(:,3),...
    X, AveragedSeparatedTarget2d(:,4), X, AveragedSeparatedTarget2d(:,5), X, AveragedSeparatedTarget2d(:,6),...
    X, AveragedSeparatedTarget2d(:,7), X, AveragedSeparatedTarget2d(:,8),...
    X, AveragedSeparatedNonTarget2d(:,1), X, AveragedSeparatedNonTarget2d(:,2), X, AveragedSeparatedNonTarget2d(:,3),...
    X, AveragedSeparatedNonTarget2d(:,4), X, AveragedSeparatedNonTarget2d(:,5), X, AveragedSeparatedNonTarget2d(:,6),...
    X, AveragedSeparatedNonTarget2d(:,7), X, AveragedSeparatedNonTarget2d(:,8));
ax = gca;
hold all;
axis tight;
grid on;
axis([0 Stimulus_duration -10 10]);
set(ax,'XTick',0: 0.1: Stimulus_duration);
set(ax,'YTick',-10:0.5:10);
xlabel('time [s]', 'FontSize', 14)
ylabel('[\muV]', 'FontSize', 14)
set(ax,'XGrid','on','YGrid','on');
%}


%Mean and SEerrorbar graph
%{
figure
shadedErrorBar(X, AveragedAllTarget1d(:,1), SETargets, {'color', [0.3984 0 0.5977]} , 1);
hold on
shadedErrorBar(X, AveragedAllNonTarget1d(:,1), SENonTargets, {'color', [0 0.6289 0.8008]}, 1);

ax = gca;
hold all;
axis tight;
grid on;
axis([0 Stimulus_duration -10 10]);
set(ax,'XTick',0: 0.1: Stimulus_duration);
set(ax,'YTick',-10:0.5:10);
xlabel('time [s]', 'FontSize', 14)
ylabel('[\muV]', 'FontSize', 14)
set(ax,'XGrid','on','YGrid','on');
%}

end
