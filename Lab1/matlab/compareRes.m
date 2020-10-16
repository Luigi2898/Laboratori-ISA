clear variables
close all
clc

outputVHD = importdata('results.txt');
%outputC = importdata('../sim
x = linspace(0,10000,192)';
plot(x, outputVHD(2:end))