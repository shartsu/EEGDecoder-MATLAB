function drawSignalGraph(file_TargetSignal, file_TargetSE, file_NonTargetSignal, file_NonTargetSE, channelNo, GraphTitle, Stimulus_duration, Duration_points, gap, Ymax, Ymin)

X = linspace(gap, Stimulus_duration+gap, Duration_points);
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
hline = refline([0 0]);
hline.Color = 'r';
hold on
[ph,msg]=jbfill([0.0 0.1],[-50 -50],[50 50],'r','r',0,0.1);
[ph,msg]=jbfill([0.3 0.4],[-50 -50],[50 50],'r','r',0,0.1);
[ph,msg]=jbfill([0.6 0.7],[-50 -50],[50 50],'r','r',0,0.1);

legend('T', 'N');

%{
maxvec = max(file_TargetSignal(:,channelNo), file_NonTargetSignal(:,channelNo));
minvec = min(file_TargetSignal(:,channelNo), file_NonTargetSignal(:,channelNo));

if(max(maxvec) > 7 || min(minvec) < -7 )
    Ymax = ceil(max(maxvec)) + 3.0;
    Ymin = floor(min(minvec)) - 3.0;
else
    Ymax = 10;
    Ymin = -10;
end
%}
hold on

axis([0.0 0.7 Ymin Ymax]);
set(ax,'XTick', 0.0: 0.05: 0.7);
set(ax,'YTick',Ymin:1:Ymax);
set(ax,'GridColor',[0 0 1]);
title(GraphTitle)
xlabel('time [s]', 'FontSize', 14)
ylabel('[\muV]', 'FontSize', 14)
%set(ax,'XGrid','on','YGrid','on');

end
