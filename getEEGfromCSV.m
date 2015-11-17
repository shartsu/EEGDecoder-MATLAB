function getEEGfromCSV(file_allTarget, file_allNonTarget)

allTarget=importdata(file_allTarget);
allNonTarget=importdata(file_allNonTarget);

%signal averaging over all channels
%TimeAveraging(EEGFile, 1, 10, 0.5);

%initiallize
aveTarget = zeros(204, 9);
aveNonTarget  = zeros(204, 9);

for j = 2:9
    for i = 1:1:204
        aveTarget(i, j) = mean(allTarget.data(i:204:size(allTarget.data), j));
        aveNonTarget(i, j) = mean(allNonTarget.data(i:204:size(allNonTarget.data), j));
    end
end

%Contains each channels time averaged data (Column2-9)
%         which averaged from 0 sec (each onset) to 0.8 sec &&
%         all channels averaged data (mean Comulmn2-9 -> Column1) 
whos aveTarget
whos aveNonTarget

aveTarget(:,1) = mean(aveTarget(:,1:8),2);
aveNonTarget(:,1) = mean(aveNonTarget(:,1:8),2);

eTarget = std(aveTarget(:,1))*ones(size(aveTarget(:,1)));
eNonTarget = std(aveNonTarget(:,1))*ones(size(aveTarget(:,1)));

whos eTarget
whos eNonTarget

whos aveAll

X = linspace(0, 0.8, 204);
whos X


figure
plot(X, aveTarget(:,1), '-o', X, aveNonTarget(:,1), '-*', ...
    X, aveTarget(:,2), X, aveTarget(:,3), X, aveTarget(:,4), X, aveTarget(:,5), X, aveTarget(:,6), X, aveTarget(:,7), X, aveTarget(:,8), X, aveTarget(:,9),...
    X, aveNonTarget(:,2), X, aveNonTarget(:,3), X, aveNonTarget(:,4), X, aveNonTarget(:,5), X, aveNonTarget(:,6), X, aveNonTarget(:,7), X, aveNonTarget(:,8), X, aveNonTarget(:,9));
ax = gca;
hold all;
axis tight;
grid on;
axis([0 0.8 -10 10]);
set(ax,'XTick',0: 0.1: 0.8);
set(ax,'YTick',-10:0.5:10);
xlabel('time [s]', 'FontSize', 14)
ylabel('[\muV]', 'FontSize', 14)
set(ax,'XGrid','on','YGrid','on');



figure
shadedErrorBar(X, aveTarget(:,1), eTarget, {'color', [0 0.6289 0.8008]} , 1);
hold on
shadedErrorBar(X, aveNonTarget(:,1), eNonTarget, {'color', [0.3984 0 0.5977]}, 1);

ax = gca;
hold all;
axis tight;
grid on;
axis([0 0.8 -10 10]);
set(ax,'XTick',0: 0.1: 0.8);
set(ax,'YTick',-10:0.5:10);
xlabel('time [s]', 'FontSize', 14)
ylabel('[\muV]', 'FontSize', 14)
set(ax,'XGrid','on','YGrid','on');

end