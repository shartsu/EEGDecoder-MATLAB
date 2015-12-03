function drawSignalGraph(file_TargetSignal, file_TargetSE, file_NonTargetSignal, file_NonTargetSE, channelNo, GraphTitle, Stimulus_duration, Duration_points)

X = linspace(0, Stimulus_duration, Duration_points);
TargetColor = [0.3984 0 0.5977];
NonTargetColor = [0 0.6289 0.8008];

shadedErrorBar(X, file_TargetSignal(:,channelNo), file_TargetSE(:,channelNo), {'color', TargetColor} , 1);
hold on
shadedErrorBar(X, file_NonTargetSignal(:,channelNo), file_NonTargetSE(:,channelNo), {'color', NonTargetColor}, 1);

maxvec = max(file_TargetSignal(:,channelNo), file_NonTargetSignal(:,channelNo));
minvec = min(file_TargetSignal(:,channelNo), file_NonTargetSignal(:,channelNo));

Ymax = ceil(max(maxvec)) + 3.0;
Ymin = floor(min(minvec)) - 3.0;

ax = gca;
hold all;
axis tight;
grid on;
axis([0 Stimulus_duration Ymin Ymax]);
set(ax,'XTick',0: 0.1: Stimulus_duration);
set(ax,'YTick',Ymin:1:Ymax);
set(ax,'GridColor',[0 0 1]);
title(GraphTitle)
xlabel('time [s]', 'FontSize', 14)
ylabel('[\muV]', 'FontSize', 14)
%set(ax,'XGrid','on','YGrid','on');

end
