function drawSignalGraph(X, file_TargetSignal, file_TargetSE, file_NonTargetSignal, file_NonTargetSE, channelNo, GraphTitle, Stimulus_duration)

shadedErrorBar(X, file_TargetSignal(:,channelNo), file_TargetSE(:,channelNo), {'color', [0.3984 0 0.5977]} , 1);
hold on
shadedErrorBar(X, file_NonTargetSignal(:,channelNo), file_NonTargetSE(:,channelNo), {'color', [0 0.6289 0.8008]}, 1);

Ymax = 5;
Ymin = -10;

maxvec = max(file_TargetSignal(:,channelNo), file_NonTargetSignal(:,channelNo));
minvec = min(file_TargetSignal(:,channelNo), file_NonTargetSignal(:,channelNo));

if(Ymax < max(maxvec)) Ymax = max(maxvec) + 2.0; end
if(Ymin > min(minvec)) Ymin = min(minvec) - 2.0; end

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
