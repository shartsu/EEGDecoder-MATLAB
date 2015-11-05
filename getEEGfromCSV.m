function getEEGfromCSV

FntFam = 'Times New Roman';
fontSIZE = 14;
EEG=importdata('sampleEEG.csv');

Time1sec = EEG(1:513,1);
ch1 = EEG(1:513,2);
ch2 = EEG(1:513,3);

%average
for i = 0:127
    hoge = 0.0;
    k = 4*i;
    for j = k: k+4
        hoge = hoge + ch1(j, 1);
    end
    ch1AVE(i, 1) = hoge/4;
end 

ch1AVE

Time4sec= EEG(1:2049,1);
ch3 = EEG(1:2049,4);
ch4 = EEG(1:2049,5);

Timeall= EEG(:,1);
ch5 = EEG(1:513,6);
ch6 = EEG(1:513,7);

figure
%plot(Time1sec, ch1, Time1sec, ch2);
plot(Time4sec, ch3, Time4sec, ch4);
%plot(Timeall, ch5, Timeall, ch6);
%title(electrodes(ii), 'FontSize', fontSIZE, 'FontName', FntFam);
xlabel('time [s]', 'FontSize', fontSIZE, 'FontName', FntFam)
ylabel('[\muV]', 'FontSize', fontSIZE, 'FontName', FntFam)
grid on;
axis tight;
end