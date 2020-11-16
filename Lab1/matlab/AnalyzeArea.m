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
saveas(f, "AreaBar_par_DIRFORM.jpg")
imwrite(rgb2gray(imread("AreaBar_par_DIRFORM.jpg")), "AreaBar_par_DIRFORM_gray.jpg")

f = figure;
cat = categorical(types(5));
bar(cat, [AreaGating(5) AreaNoGating(5)])
legend("with gating", "without gating")
ylabel("Area [\mum^2]")
saveas(f, "AreaBar_tot_DIRFORM.jpg")
imwrite(rgb2gray(imread("AreaBar_tot_DIRFORM.jpg")), "AreaBar_tot_DIRFORM_gray.jpg")

[ AreaGating, types ] = readAreaFromSynopsys("../results/syn/synthReport/gating/firUnfoldedNC/elab_area.txt");
AreaNoGating = readAreaFromSynopsys("../results/syn/synthReport/noGating/firUnfoldedNC/elab_area.txt");

f = figure;
cat = categorical(types(1:3));
bar(cat, [AreaGating(1:3) AreaNoGating(1:3)])
legend("with gating", "without gating")
ylabel("Area [\mum^2]")
saveas(f, "AreaBar_par_UNFOLDED.jpg")
imwrite(rgb2gray(imread("AreaBar_par_UNFOLDED.jpg")), "AreaBar_par_UNFOLDED_gray.jpg")


f = figure;
cat = categorical(types(5));
bar(cat, [AreaGating(5) AreaNoGating(5)])
legend("with gating", "without gating")
ylabel("Area [\mum^2]")
saveas(f, "AreaBar_tot_UNFOLDED.jpg")
imwrite(rgb2gray(imread("AreaBar_tot_UNFOLDED.jpg")), "AreaBar_tot_UNFOLDED_gray.jpg")

[ AreaGating, types ] = readAreaFromSynopsys("../results/syn/synthReport/gating/firUnfoldedPipedNC/elab_area.txt");
AreaNoGating = readAreaFromSynopsys("../results/syn/synthReport/noGating/firUnfoldedPipedNC/elab_area.txt");

f = figure;
cat = categorical(types(1:3));
bar(cat, [AreaGating(1:3) AreaNoGating(1:3)])
legend("with gating", "without gating")
ylabel("Area [\mum^2]")
saveas(f, "AreaBar_par_PIPED.jpg")
imwrite(rgb2gray(imread("AreaBar_par_PIPED.jpg")), "AreaBar_par_PIPED_gray.jpg")

f = figure;
cat = categorical(types(5));
bar(cat, [AreaGating(5) AreaNoGating(5)])
legend("with gating", "without gating")
ylabel("Area [\mum^2]")
saveas(f, "AreaBar_tot_PIPED.jpg")
imwrite(rgb2gray(imread("AreaBar_tot_PIPED.jpg")), "AreaBar_tot_PIPED_gray.jpg")
