clear variables
close all
clc

[PowerGatingDIRSYN, typesDIRSYN] = readPowerFromSynopsys("../results/syn/synthReportAfterBack/gating/firNC/elab_power.txt");
[PowerGatingUNFSYN, typesUNFSYN] = readPowerFromSynopsys("../results/syn/synthReportAfterBack/gating/firUnfoldedNC/elab_power.txt");
[PowerGatingPIPSYN, typesPIPSYN] = readPowerFromSynopsys("../results/syn/synthReportAfterBack/gating/firUnfoldedPipedNC/elab_power.txt");

[PowerGatingDIRPR, typesDIRPR] = readPowerFromInnovus("../results/innovus/DirectForm/powerAnal/elab_power.txt");
[PowerGatingUNFPR, typesUNFPR] = readPowerFromInnovus("../results/innovus/Unfolded/PowerAnal/elab_Power_report.txt");
[PowerGatingPIPPR, typesPIPPR] = readPowerFromInnovus("../results/innovus/UnfoldedPiped/PowerAnalysis/elab_power_report.txt");

PowerGatingDIRPR = PowerGatingDIRPR.*1000;
PowerGatingUNFPR = PowerGatingUNFPR.*1000;
PowerGatingPIPPR = PowerGatingPIPPR.*1000;
powerPR = [PowerGatingDIRPR(4); PowerGatingUNFPR(4); PowerGatingPIPPR(4)];
powerSYN = [PowerGatingDIRSYN(5); PowerGatingUNFSYN(5); PowerGatingPIPSYN(5)];

f = figure;
cat = categorical(["Direct form", "Unfolded", "Piped"]);
bar(cat, [powerSYN powerPR])
legend("post-syntesis", "post-place&route",'Location','northwest')
ylabel("Total ower [\muW]")
saveas(f, "./result/powerGraphs/power_conf.jpg")
imwrite(rgb2gray(imread("./result/powerGraphs/power_conf.jpg")), "./result/powerGraphs/power_conf_gray.jpg")

powerINTPR = [PowerGatingDIRPR(1) PowerGatingUNFPR(1) PowerGatingPIPPR(1)]';
powerINTSYN = [PowerGatingDIRSYN(1) PowerGatingUNFSYN(1) PowerGatingPIPSYN(1)]';

f = figure;
cat = categorical(["Direct form", "Unfolded", "Piped"]);
bar(cat, [powerINTSYN powerINTPR])
legend("post-syntesis", "post-place&route",'Location','northwest')
ylabel("Internal power [\muW]")
saveas(f, "./result/powerGraphs/power_conf_INT.jpg")
imwrite(rgb2gray(imread("./result/powerGraphs/power_conf_INT.jpg")), "./result/powerGraphs/power_conf_INT_gray.jpg")

powerSWIPR = [PowerGatingDIRPR(2) PowerGatingUNFPR(2) PowerGatingPIPPR(2)]';
powerSWISYN = [PowerGatingDIRSYN(2) PowerGatingUNFSYN(2) PowerGatingPIPSYN(2)]';

f = figure;
cat = categorical(["Direct form", "Unfolded", "Piped"]);
bar(cat, [powerSWISYN powerSWIPR])
legend("post-syntesis", "post-place&route",'Location','northwest')
ylabel("Switching power [\muW]")
saveas(f, "./result/powerGraphs/power_conf_INT.jpg")
imwrite(rgb2gray(imread("./result/powerGraphs/power_conf_INT.jpg")), "./result/powerGraphs/power_conf_INT_gray.jpg")

powerLEAKPR = [PowerGatingDIRPR(3) PowerGatingUNFPR(3) PowerGatingPIPPR(3)]';
powerLEAKSYN = [PowerGatingDIRSYN(4) PowerGatingUNFSYN(4) PowerGatingPIPSYN(4)]';

f = figure;
cat = categorical(["Direct form", "Unfolded", "Piped"]);
bar(cat, [powerLEAKSYN powerLEAKPR])
legend("post-syntesis", "post-place&route",'Location','northwest')
ylabel("Leakage power [\muW]")
saveas(f, "./result/powerGraphs/power_conf_LEAK.jpg")
imwrite(rgb2gray(imread("./result/powerGraphs/power_conf_LEAK.jpg")), "./result/powerGraphs/power_conf_LEAK_gray.jpg")
