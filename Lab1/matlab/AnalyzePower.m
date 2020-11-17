close all
clear variables
clc


[PowerGating, types] = readPowerFromSynopsys("../results/syn/synthReportAfterBack/gating/firNC/elab_power.txt");
PowerNoGating = readPowerFromSynopsys("../results/syn/synthReportAfterBack/noGating/firNC/elab_power.txt");


rate = 1 - PowerGating(5)/PowerNoGating(5)

f = figure;
cat = categorical(types(1:4));
bar(cat, [PowerGating(1:4) PowerNoGating(1:4)])
legend("with gating", "without gating")
ylabel("Power [\muW]")
saveas(f, "./result/powerGraphs/power_DIRFORM.jpg")
imwrite(rgb2gray(imread("./result/powerGraphs/power_DIRFORM.jpg")), "./result/powerGraphs/power_DIRFORM_gray.jpg")

f = figure;
cat = categorical(types(5));
bar(cat, [PowerGating(5) PowerNoGating(5)])
legend("with gating", "without gating")
ylabel("Power [\muW]")
saveas(f, "./result/powerGraphs/power_TOT_DIRFORM.jpg")
imwrite(rgb2gray(imread("./result/powerGraphs/power_TOT_DIRFORM.jpg")), "./result/powerGraphs/power_TOT_DIRFORM_gray.jpg")
