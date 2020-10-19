clear variables
close all
clc

outputVHD = importdata('results.txt');
outputC = importdata('../C/resultC.old');
outputM = importdata('../C/resultsm.txt');
x = linspace(0,10000,192)';
plot(x, outputVHD*2)
hold on
plot(x, outputC(2:end))
plot(x, outputM(10:end))
