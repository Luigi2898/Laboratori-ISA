close all
clear variables
clc

TmaxPR_DIR = 10.553  - 8.383;
TmaxPR_UNF = 10.939 - 8.715;
TmaxPR_PIP = 8.755 - 6.998;

TmaxSYN_DIR = 2.56;
TmaxSYN_UNF = 2.66;
TmaxSYN_PIP = 2.10;

TmPR = [TmaxPR_DIR; TmaxPR_UNF; TmaxPR_PIP];
TmSYN = [TmaxSYN_DIR; TmaxSYN_UNF; TmaxSYN_PIP];

f = figure;
cat = categorical(["Direct form" "Unfolded" "Piped"]);
bar(cat, [TmSYN TmPR])
legend("post-syntesis", "post-place&route", "Location", "northwest" )
ylabel("Time [ns]")
saveas(f, "./result/timeGraph/per.jpg")
imwrite(rgb2gray(imread("./result/timeGraph/per.jpg")), "./result/timeGraph/per_gray.jpg")
