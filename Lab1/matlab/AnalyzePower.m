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

powerSYN = PowerGating(5)/1000;
powerPR = 0.2814 ;

rate = 1 - powerSYN/powerPR

f = figure;
cat = categorical("Total power");
bar(cat, [powerSYN*1000 powerPR*1000])
legend("post-syntesis", "post-place&route")
ylabel("Power [\muW]")
saveas(f, "./result/powerGraphs/power_conf_DIRFORM.jpg")
imwrite(rgb2gray(imread("./result/powerGraphs/power_conf_DIRFORM.jpg")), "./result/powerGraphs/power_conf_DIRFORM_gray.jpg")

[PowerGating, types] = readPowerFromSynopsys("../results/syn/synthReportAfterBack/gating/firUnfoldedNC/elab_power.txt");
PowerNoGating = readPowerFromSynopsys("../results/syn/synthReportAfterBack/noGating/firUnfoldedNC/elab_power.txt");


rate = 1 - PowerGating(5)/PowerNoGating(5)

f = figure;
cat = categorical(types(1:4));
bar(cat, [PowerGating(1:4) PowerNoGating(1:4)])
legend("with gating", "without gating")
ylabel("Power [\muW]")
saveas(f, "./result/powerGraphs/power_UNFOLDED.jpg")
imwrite(rgb2gray(imread("./result/powerGraphs/power_UNFOLDED.jpg")), "./result/powerGraphs/power_UNFOLDED_gray.jpg")

f = figure;
cat = categorical(types(5));
bar(cat, [PowerGating(5) PowerNoGating(5)])
legend("with gating", "without gating")
ylabel("Power [\muW]")
saveas(f, "./result/powerGraphs/power_TOT_UNFOLDED.jpg")
imwrite(rgb2gray(imread("./result/powerGraphs/power_TOT_UNFOLDED.jpg")), "./result/powerGraphs/power_TOT_UNFOLDED_gray.jpg")

powerSYN = PowerGating(5)/1000;
powerPR = 0.42141670;

rate = 1 - powerSYN/powerPR

f = figure;
cat = categorical("Total power");
bar(cat, [powerSYN*1000 powerPR*1000])
legend("post-syntesis", "post-place&route")
ylabel("Power [\muW]")
saveas(f, "./result/powerGraphs/power_conf_UNFOLDED.jpg")
imwrite(rgb2gray(imread("./result/powerGraphs/power_conf_UNFOLDED.jpg")), "./result/powerGraphs/power_conf_UNFOLDED_gray.jpg")









[PowerGating, types] = readPowerFromSynopsys("../results/syn/synthReportAfterBack/gating/firUnfoldedPipedNC/elab_power.txt");
PowerNoGating = readPowerFromSynopsys("../results/syn/synthReportAfterBack/noGating/firUnfoldedPipedNC/elab_power.txt");


rate = 1 - PowerGating(5)/PowerNoGating(5)

f = figure;
cat = categorical(types(1:4));
bar(cat, [PowerGating(1:4) PowerNoGating(1:4)])
legend("with gating", "without gating")
ylabel("Power [\muW]")
saveas(f, "./result/powerGraphs/power_PIPED.jpg")
imwrite(rgb2gray(imread("./result/powerGraphs/power_PIPED.jpg")), "./result/powerGraphs/power_PIPED_gray.jpg")

f = figure;
cat = categorical(types(5));
bar(cat, [PowerGating(5) PowerNoGating(5)])
legend("with gating", "without gating")
ylabel("Power [\muW]")
saveas(f, "./result/powerGraphs/power_TOT_PIPED.jpg")
imwrite(rgb2gray(imread("./result/powerGraphs/power_TOT_PIPED.jpg")), "./result/powerGraphs/power_TOT_PIPED_gray.jpg")

powerSYN = PowerGating(5)/1000;
powerPR = 0.43246513;

rate = 1 - powerSYN/powerPR

f = figure;
cat = categorical("Total power");
bar(cat, [powerSYN*1000 powerPR*1000])
legend("post-syntesis", "post-place&route")
ylabel("Power [\muW]")
saveas(f, "./result/powerGraphs/power_conf_PIPED.jpg")
imwrite(rgb2gray(imread("./result/powerGraphs/power_conf_PIPED.jpg")), "./result/powerGraphs/power_conf_PIPED_gray.jpg")





