close all
clear all
clc

[ AreaSYNDIR, types ] = readAreaFromSynopsys("../results/syn/synthReport/gating/firNC/elab_area.txt");
[ AreaSYNUNF, types ] = readAreaFromSynopsys("../results/syn/synthReport/gating/firUnfoldedNC/elab_area.txt");
[ AreaSYNPIP, types ] = readAreaFromSynopsys("../results/syn/synthReport/gating/firUnfoldedPipedNC/elab_area.txt");

AreaPRDIR = 2886.6;
AreaPRUNF = 8087.5;
AreaPRPIP = 9364.3;

AreaSYN = [AreaSYNDIR(5) AreaSYNUNF(5) AreaSYNPIP(5)]';
AreaPR = [AreaPRDIR AreaPRUNF AreaPRPIP]';


f = figure;
cat = categorical(["Direct form", "Unfolded", "Pieped"]);
bar(cat, [AreaSYN AreaPR])
legend("post-syntesis", "post-place&route", 'Location', 'northwest')
ylabel("Area [\mum^2]")
saveas(f, "./result/AreaGraphs/AreaBar_comp.jpg")
imwrite(rgb2gray(imread("./result/AreaGraphs/AreaBar_comp.jpg")), "./result/AreaGraphs/AreaBar_comp_gray.jpg")

AreaPR./AreaPR'
