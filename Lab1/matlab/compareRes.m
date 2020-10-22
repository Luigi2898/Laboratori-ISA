clear variables
close all
clc

outputVHD = importdata('../sim/results.txt');
outputC11 = importdata('../C/resultC11.txt');
outputC11b = importdata('../C/resultC11b.txt');
outputC5 = importdata('../C/resultC5.txt');
outputC6 = importdata('../C/resultC6.txt');
outputC7 = importdata('../C/resultC7.txt');
samp = importdata('samples.txt');
figure
plot(outputVHD/max(abs(outputVHD)))
hold on
plot(outputC11/max(abs(outputC11)))
plot(outputC11b/max(abs(outputC11b)))
plot(outputC5/max(abs(outputC5)))
plot(outputC6/max(abs(outputC6)))
plot(outputC7/max(abs(outputC7)))

figure
thd(outputC11/max(abs(outputC11)))
hold on
thd(outputC5/max(abs(outputC5)))
thd(outputC6/max(abs(outputC6)))
thd(outputC7/max(abs(outputC7)))
thd(outputC11b/max(abs(outputC11b)))
thd(outputVHD/max(abs(outputVHD)))