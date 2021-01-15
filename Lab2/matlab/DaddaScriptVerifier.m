%% - DADDA TREE SCRIPT VERIFICATION - %%
clc
clear all
close all

fprintf('                ********************************************\n');
fprintf('                ******** DADDA TREE SCRIPT VERIFIER ********\n');
fprintf('                ********************************************\n\n');
fprintf('Welcome to the verification app for the Dadda Tree HDL Generator.\n');
fprintf('The search path for the input file (dot diagram output of the HDL generator) is:\n--> ../DaddaHDLGenerator/.\n\n');

script_filename = input('Enter the script output file name (default is outDotNotation.txt): \','s');
if script_filename == ""
    script_filename = 'outDotNotation.txt';
end
 fopen_filename = strcat('../DaddaHDLGenerator/',script_filename);
fID_input = fopen(fopen_filename,'r');

% Dot notation matrix acquisition
formatSpec = '';
k = 0;
for i = 1:64
    formatSpec = [formatSpec '%d,'];
    k = k + 1;
end
formatSpec = [formatSpec '\n'];

levelsTensor = zeros(17,65,7);
line = 1;
levelRow = 1;
level = 1;
i = 1;
while ~feof(fID_input) && i < 125
    tmpLine = fscanf(fID_input,formatSpec, [1 65]);
    if (tmpLine(1) == 2)
        level = level + 1;
        levelRow = 1;
    else
        levelsTensor(levelRow,:,level) = tmpLine';
        levelRow = levelRow + 1;
    end
    i = i + 1;
end
fclose(fID_input);


figure(1)
spy(levelsTensor(:,:,1),20,'y');
hold on
spy(levelsTensor(:,:,2),20,'c');
spy(levelsTensor(:,:,3),20,'r');
spy(levelsTensor(:,:,4),20,'g');
spy(levelsTensor(:,:,5),20,'b');
spy(levelsTensor(:,:,6),20,'m');
spy(levelsTensor(:,:,7),20,'k');
grid minor

fprintf('\nA dot notation plot of the HDL generator output has been produced in Figure (1).\n\n');



levelElementsCorrect(1,:) = [0	2	3	3	4	4	5	5	6	6	7	7	8	8	9	9	10	10	11	11	12	12	13	13	14	14	15	15	16	17	17	17	17	16	17	15	16	14	15	13	14	12	13	11	12	10	11	9	10	8	9	7	8	6	7	5	6	4	5	3	4	2	3	1	2];
levelElementsCorrect(2,:) = [0	2	3	3	4	4	5	5	6	6	7	7	8	8	9	9	10	10	11	11	12	13	13	13	13	13	13	13	13	13	13	13	13	13	13	13	13	13	13	13	13	12	13	11	12	10	11	9	10	8	9	7	8	6	7	5	6	4	5	3	4	2	3	1	2];
levelElementsCorrect(3,:) = [0	2	3	3	4	4	5	5	6	6	7	7	8	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	9	8	9	7	8	6	7	5	6	4	5	3	4	2	3	1	2];
levelElementsCorrect(4,:) = [0	2	3	3	4	4	5	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	5	6	4	5	3	4	2	3	1	2];
levelElementsCorrect(5,:) = [0	2	3	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	3	4	2	3	1	2];
levelElementsCorrect(6,:) = [0	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	3	2	3	1	2];
levelElementsCorrect(7,:) = [1	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	1	2];

headerCol{1} = 'LEVEL';

for i = 1:7
    for j = 1:65
        levelElementsScript(i,j) = sum(levelsTensor(:,j,i));
        if (64-(j-1)) < 10 
            headerCol{j+1} = strcat('B','0',string(64-(j-1)));
        else
            headerCol{j+1} = strcat('B',string(64-(j-1)));
        end
    end
    levelElementsDiff(i,:) = levelElementsScript(i,:)-levelElementsCorrect(i,:);
    headerRow{i} = string(i-1);
end


outfilename = input('Enter the verified output file name (default is DaddaScriptVerified.txt)):\','s');
if outfilename == ""
    outfilename = '../DaddaHDLGenerator/DaddaScriptVerified.txt';
else
    outfilename = ['../DaddaHDLGenerator/' outfilename '.txt'];
end

fID_out = fopen(outfilename,'w'); 


barStr = '';
for i = 1:(66*6) 
    barStr = [barStr '-'];
end




for i = 1:8
    if i == 1
        for j = 1:66
            tmpStr = [ headerCol{j} ' ' '|' ' '];
            fprintf(fID_out,'%s',tmpStr);
        end
        fprintf(fID_out,'\n');
        fprintf(fID_out,'%s',barStr);
        fprintf(fID_out,'\n');
    else
        for j = 1:66
            if j == 1
                fprintf(fID_out,'%s',['  ' string(8-i) '   ' '|']);
            else
                if levelElementsDiff(i-1,j-1) == -1
                    tmpStr = ['  ' string(levelElementsDiff(i-1,j-1)) ' ' '|'];
                    fprintf(fID_out,'%s',tmpStr);
                else
                    tmpStr = ['  ' string(levelElementsDiff(i-1,j-1)) '  ' '|'];
                    fprintf(fID_out,'%s',tmpStr);
                end
            end
        end
        fprintf(fID_out,'\n');
        fprintf(fID_out,'%s',barStr);
        fprintf(fID_out,'\n');
    end
end

fclose(fID_out);

fprintf('\nA text file named "%s" containing the table of the excess bits\nat each level has been produced following the specified file name.\n',outfilename);

j = 1;
for i = 1:3:19
    toPlot(i,:) = levelElementsCorrect(j,:);
    toPlot(i+1,:) = levelElementsScript(j,:);
    toPlot(i+2,:) = levelElementsDiff(j,:);
    j = j+ 1;
end

for i = 1:3:19
    toPlotMask(i,:) = zeros(1,65);
    toPlotMask(i+1,:) = zeros(1,65);
    toPlotMask(i+2,:) = ones(1,65);
end

j = 1;

for i = 1:3:19
    tmpStr = strcat('LEVEL : ',headerRow{j},' CORRECT');
    headerRowPlot{i}   = tmpStr;
    headerRowPlot{i+1} = 'SCRIPT';
    headerRowPlot{i+2} = 'DIFF';
    j = j + 1;
end


for i=1:65
    headerColPlot{i} = strcat('B',string(65-i));
end


figure(2)
tablePlot(toPlot,toPlotMask,headerRowPlot,headerColPlot);
title({'DADDA HDL GENERATOR SCRIPT VERIFICATION REPORT TABLE',...
    'The number reported in the DIFF row are intended as excess bits from the script result wrt the correct one'});

fprintf('The same table is reported in Figure (2).');