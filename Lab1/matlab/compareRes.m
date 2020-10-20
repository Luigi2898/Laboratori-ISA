clear variables
close all
clc

outputVHD = importdata('results.txt')*2^-10;
outputC = importdata('../C/resultC.new5')*2^(-11-5);
outputC2 = importdata('../C/resultC.new')*2^(-10);
outputM = importdata('../C/resultsm.txt')*2^-10;
samp = importdata('samples.txt')*2^-10;
figure
plot(outputVHD)
hold on
plot(outputC(2:end))
plot(outputM(10:end))
plot(outputC2(2:end))

figure
plot(samp(6:end))
hold on
plot(outputVHD)
hold off

figure
thd(outputC)
hold on
pause()
thd(outputC2)