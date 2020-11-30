%% - DADDA TREE SCRIPT VERIFICATION - %%
clc
clear all
close all

%script_filename = input('Enter the script output file name: \','s');
script_filename = 'out.txt';
fopen_filename = strcat('../DaddaHDLGenerator/',script_filename);
fID_input = fopen(fopen_filename,'r');

% Dot notation matrix acquisition
formatSpec = '';
k = 0;
for i = 1:64
    formatSpec = [formatSpec '%d' ' '];
    k = k + 1;
end
formatSpec = [formatSpec ' ' '\n'];

levelsTensor = zeros(7,17,64);
line = 1;
levelRow = 1;
level = 1;
while ~feof(fID_input)
    tmpLine = fscanf(fID_input,formatSpec, [1 64])
    if (tmpLine(1) == 2)
        level = level + 1;
        levelRow = 1;
    else
        levelsTensor(level,levelRow,:) = tmpLine';
        levelRow = levelRow + 1;
    end
end
fclose(fID_input);