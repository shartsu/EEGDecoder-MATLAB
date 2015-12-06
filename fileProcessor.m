function [AllData, Sampling_Hz, Electrodes] = fileProcessor(File_CSV)

AllData = [];

if isempty(File_CSV)
    [FileName, FileNamePath]=uigetfile('*.csv','Select P300 file(s)','multiselect','on');
    FileNameCellArray = strcat(FileNamePath, FileName);
    
    whos FileNameCellArray 
    
    if (ischar(FileNameCellArray))
        allData_struct = importdata(FileNameCellArray);
        AllData = allData_struct.data;
    else
        for n = 1: length(FileNameCellArray)
            allData_struct = importdata(FileNameCellArray{n});
            AllData = vertcat(AllData, allData_struct.data);
        end
    end
else
    allData_struct = importdata(File_CSV);
    AllData = allData_struct.data;
end

%Sampling heltz data can be get from these data
Sampling_Hz = allData_struct.data(1, end);
Electrodes = allData_struct.textdata(1, 2:(end-1));

end