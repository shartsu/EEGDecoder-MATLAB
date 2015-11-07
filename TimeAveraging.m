function TimeAveraging(EEGFile, Channel, Duration_sec, Step_sec)

SamplingRate_Hz = EEGFile(1,8);
TimeArray = EEGFile(:,1);
EEGArray = EEGFile(:, 2:7);

l = 1;
channel = Channel;
duration = SamplingRate_Hz * Duration_sec;
step = SamplingRate_Hz * Step_sec;

%time averaging
for i = 1:step:(duration-step+1) %Step_sec=0.5/Duration_sec=10 => 1:256:4865(4864points)
    k = i;
    buf = 0;
    for j = k:1:k+step %Step_sec=0.5=> 1:1:257(256points)
        buf = buf + EEGArray(j, channel);
    end
    
    AVE(l, 1) = Step_sec * (l-1); %l-1: Shift for graph (x-axis from 0)
    AVE(l, 2) = buf/step;
    l = l + 1;
end 

whos TimeArray
whos EEGArray
AVE

figure
plot(TimeArray(:,1), EEGArray(:,channel), AVE(:,1), AVE(:,2),'-*');

ax = gca;
hold all;
axis tight;
grid on;
axis([0 Duration_sec -5 5]);
set(ax,'XTick',0:Step_sec:Duration_sec);
set(ax,'YTick',-5:0.5:5);
xlabel('time [s]', 'FontSize', 14)
ylabel('[\muV]', 'FontSize', 14)
set(ax,'XGrid','on','YGrid','on');

end