function drawSignalGraph_clsAB_TARGETDif(file_clsASignal, file_clsASE, file_clsBSignal, file_clsBSE,...
    Channels, GraphTitle, Stimulus_duration, Duration_points)

X = linspace(0.0, Stimulus_duration, Duration_points);
Color1 = [0.7282 0.5931 0.2968];
Color2 = [0.5 1.0 0.5];
Color3 = [1.0 0.5 0.5];
Color4 = [0.7282 0.5931 0.2968];
Color5 = [0.5 1.0 0.5];
Color6 = [1.0 0.5 0.5];

ax = gca;

hold all; axis tight; grid on;
plot(X, file_clsASignal(:,Channels(1)), '-+', 'Color', Color1);
hold on
plot(X, file_clsASignal(:,Channels(2)), '-+', 'Color', Color2);
hold on
plot(X, file_clsASignal(:,Channels(3)), '-+', 'Color', Color3);
hold on
plot(X, file_clsBSignal(:,Channels(1)), '-*', 'Color', Color4);
hold on
plot(X, file_clsBSignal(:,Channels(2)), '-*', 'Color', Color5);
hold on
plot(X, file_clsBSignal(:,Channels(3)), '-*', 'Color', Color6);
hold on
shadedErrorBar(X, file_clsASignal(:, Channels(1)), file_clsASE(:, Channels(1)), {'color', Color1} , 1);
hold on
shadedErrorBar(X, file_clsASignal(:, Channels(2)), file_clsBSE(:, Channels(2)), {'color', Color2} , 1);
hold on
shadedErrorBar(X, file_clsASignal(:, Channels(3)), file_clsASE(:, Channels(3)), {'color', Color3} , 1);
hold on
shadedErrorBar(X, file_clsBSignal(:, Channels(1)), file_clsBSE(:, Channels(1)), {'color', Color4} , 1);
hold on
shadedErrorBar(X, file_clsBSignal(:, Channels(2)), file_clsASE(:, Channels(2)), {'color', Color5} , 1);
hold on
shadedErrorBar(X, file_clsBSignal(:, Channels(3)), file_clsBSE(:, Channels(3)), {'color', Color6} , 1);
hold on

hline = refline([0 0]);
hline.Color = 'r';
hold on
[ph,msg]=jbfill([0.0 0.1],[-20 -20],[20 20],'r','r',0,0.1);
[ph,msg]=jbfill([0.3 0.4],[-20 -20],[20 20],'r','r',0,0.1);
[ph,msg]=jbfill([0.6 0.7],[-20 -20],[20 20],'r','r',0,0.1);

legend('clsA-Cz', 'clsA-C3', 'clsA-C4', 'clsB-Cz', 'clsB-C3', 'clsB-C4');

% maxvec = max(file_clsASignal(:,channelNo1), file_clsASignal(:,channelNo1));
% minvec = min(file_clsASignal(:,channelNo1), file_clsASignal(:,channelNo1));
% 
% if(max(maxvec) > 7 || min(minvec) < -7 )
%     Ymax = ceil(max(maxvec)) + 3.0;
%     Ymin = floor(min(minvec)) - 3.0;
% else
%     Ymax = 10;
%     Ymin = -10;
% end
% hold on

Ymax = 10;
Ymin = -10;

axis([0.0 0.4 Ymin Ymax]);
set(ax,'XTick', 0.0: 0.05: 0.4);
set(ax,'YTick',Ymin:1:Ymax);
set(ax,'GridColor',[0 0 1]);
title(GraphTitle)
xlabel('time [s]', 'FontSize', 14)
ylabel('[\muV]', 'FontSize', 14)
%set(ax,'XGrid','on','YGrid','on');

end
