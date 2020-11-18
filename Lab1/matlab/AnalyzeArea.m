clear variables
close all
clc

[ AreaGating, types ] = readAreaFromSynopsys("../results/syn/synthReport/gating/firNC/elab_area.txt");
AreaNoGating = readAreaFromSynopsys("../results/syn/synthReport/noGating/firNC/elab_area.txt");

rate = AreaGating(5)/AreaNoGating(5)

f = figure;
cat = categorical(types(1:3));
bar(cat, [AreaGating(1:3) AreaNoGating(1:3)])
legend("with gating", "without gating")
ylabel("Area [\mum^2]")
saveas(f, "./result/AreaGraphs/AreaBar_par_DIRFORM.jpg")
imwrite(rgb2gray(imread("./result/AreaGraphs/AreaBar_par_DIRFORM.jpg")), "./result/AreaGraphs/AreaBar_par_DIRFORM_gray.jpg")

f = figure;
cat = categorical(types(5));
bar(cat, [AreaGating(5) AreaNoGating(5)])
legend("with gating", "without gating")
ylabel("Area [\mum^2]")
saveas(f, "./result/AreaGraphs/AreaBar_tot_DIRFORM.jpg")
imwrite(rgb2gray(imread("./result/AreaGraphs/AreaBar_tot_DIRFORM.jpg")), "./result/AreaGraphs/AreaBar_tot_DIRFORM_gray.jpg")

f = figure;
cat = categorical("Total design area");
bar(cat, [AreaGating(5) 2886.6])
legend("post-syntesis", "post-place&route")
ylabel("Area [\mum^2]")
saveas(f, "./result/AreaGraphs/AreaBar_comp_DIRFORM.jpg")
imwrite(rgb2gray(imread("./result/AreaGraphs/AreaBar_comp_DIRFORM.jpg")), "./result/AreaGraphs/AreaBar_comp_DIRFORM_gray.jpg")

[ AreaGating, types ] = readAreaFromSynopsys("../results/syn/synthReport/gating/firUnfoldedNC/elab_area.txt");
AreaNoGating = readAreaFromSynopsys("../results/syn/synthReport/noGating/firUnfoldedNC/elab_area.txt");

f = figure;
cat = categorical(types(1:3));
bar(cat, [AreaGating(1:3) AreaNoGating(1:3)])
legend("with gating", "without gating")
ylabel("Area [\mum^2]")
saveas(f, "./result/AreaGraphs/AreaBar_par_UNFOLDED.jpg")
imwrite(rgb2gray(imread("./result/AreaGraphs/AreaBar_par_UNFOLDED.jpg")), "./result/AreaGraphs/AreaBar_par_UNFOLDED_gray.jpg")


f = figure;
cat = categorical(types(5));
bar(cat, [AreaGating(5) AreaNoGating(5)])
legend("with gating", "without gating")
ylabel("Area [\mum^2]")
saveas(f, "./result/AreaGraphs/AreaBar_tot_UNFOLDED.jpg")
imwrite(rgb2gray(imread("./result/AreaGraphs/AreaBar_tot_UNFOLDED.jpg")), "./result/AreaGraphs/AreaBar_tot_UNFOLDED_gray.jpg")

f = figure;
cat = categorical("Total design area");
bar(cat, [AreaGating(5) 8087.5])
legend("post-syntesis", "post-place&route")
ylabel("Area [\mum^2]")
saveas(f, "./result/AreaGraphs/AreaBar_comp_UNF.jpg")
imwrite(rgb2gray(imread("./result/AreaGraphs/AreaBar_comp_UNF.jpg")), "./result/AreaGraphs/AreaBar_comp_UNF_gray.jpg")


[ AreaGating, types ] = readAreaFromSynopsys("../results/syn/synthReport/gating/firUnfoldedPipedNC/elab_area.txt");
AreaNoGating = readAreaFromSynopsys("../results/syn/synthReport/noGating/firUnfoldedPipedNC/elab_area.txt");

f = figure;
cat = categorical(types(1:3));
bar(cat, [AreaGating(1:3) AreaNoGating(1:3)])
legend("with gating", "without gating")
ylabel("Area [\mum^2]")
saveas(f, "./result/AreaGraphs/AreaBar_par_PIPED.jpg")
imwrite(rgb2gray(imread("./result/AreaGraphs/AreaBar_par_PIPED.jpg")), "./result/AreaGraphs/AreaBar_par_PIPED_gray.jpg")

f = figure;
cat = categorical(types(5));
bar(cat, [AreaGating(5) AreaNoGating(5)])
legend("with gating", "without gating")
ylabel("Area [\mum^2]")
saveas(f, "./result/AreaGraphs/AreaBar_tot_PIPED.jpg")
imwrite(rgb2gray(imread("./result/AreaGraphs/AreaBar_tot_PIPED.jpg")), "./result/AreaGraphs/AreaBar_tot_PIPED_gray.jpg")

f = figure;
cat = categorical("Total design area");
bar(cat, [AreaGating(5) 9364.3])
legend("post-syntesis", "post-place&route")
ylabel("Area [\mum^2]")
saveas(f, "./result/AreaGraphs/AreaBar_comp_PIPE.jpg")
imwrite(rgb2gray(imread("./result/AreaGraphs/AreaBar_comp_PIPE.jpg")), "./result/AreaGraphs/AreaBar_comp_PIPE_gray.jpg")