function drawSignalGraph(file_TargetSignal, file_TargetSE, file_NonTargetSignal, file_NonTargetSE, channelNo, GraphTitle, Stimulus_duration, Duration_points)

X = linspace(0.1, Stimulus_duration+0.1, Duration_points);
TargetColor = [0.3984 0 0.5977];
NonTargetColor = [0 0.6289 0.8008];

ax = gca;
hold all; axis tight; grid on;

plot(X, file_TargetSignal(:,channelNo), '-o', 'Color', TargetColor);
hold on
plot(X, file_NonTargetSignal(:,channelNo), '-x', 'Color', NonTargetColor);
hold on
shadedErrorBar(X, file_TargetSignal(:,channelNo), file_TargetSE(:,channelNo), {'color', TargetColor} , 1);
hold on
shadedErrorBar(X, file_NonTargetSignal(:,channelNo), file_NonTargetSE(:,channelNo), {'color', NonTargetColor}, 1);
hold on

legend('Target Response', 'NonTarget Response');

maxvec = max(file_TargetSignal(:,channelNo), file_NonTargetSignal(:,channelNo));
minvec = min(file_TargetSignal(:,channelNo), file_NonTargetSignal(:,channelNo));

Ymax = ceil(max(maxvec)) + 3.0;
Ymin = floor(min(minvec)) - 3.0;

axis([0.1 0.5 Ymin Ymax]);
set(ax,'XTick', 0.1: 0.05: 0.5);
set(ax,'YTick',Ymin:1:Ymax);
set(ax,'GridColor',[0 0 1]);
title(GraphTitle)
xlabel('time [s]', 'FontSize', 14)
ylabel('[\muV]', 'FontSize', 14)
%set(ax,'XGrid','on','YGrid','on');

end
