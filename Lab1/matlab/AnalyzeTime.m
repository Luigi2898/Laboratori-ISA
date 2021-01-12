slackPR_DIR = 8.383;
slackSYN_DIR = 7.99;

f = figure;
cat = categorical("Worst slack");
bar(cat, [slackSYN_DIR slackPR_DIR])
legend("post-syntesis", "post-place&route")
ylabel("Time [ns]")
saveas(f, "./result/timeGraph/slack_DIRFORM.jpg")
imwrite(rgb2gray(imread("./result/timeGraph/slack_DIRFORM.jpg")), "./result/timeGraph/slack_DIRFORM_gray.jpg")


slackPR_UNF = 8.715;
slackSYN_UNF =  8.28;

f = figure;
cat = categorical("Worst slack");
bar(cat, [slackSYN_UNF slackPR_UNF])
legend("post-syntesis", "post-place&route")
ylabel("Time [ns]")
saveas(f, "./result/timeGraph/slack_UNF.jpg")
imwrite(rgb2gray(imread("./result/timeGraph/slack_UNF.jpg")), "./result/timeGraph/slack_UNF_gray.jpg")



slackPR_PIP = 6.998;
slackSYN_PIP =  6.65;

f = figure;
cat = categorical("Worst slack");
bar(cat, [slackSYN_PIP slackPR_PIP])
legend("post-syntesis", "post-place&route")
ylabel("Time [ns]")
saveas(f, "./result/timeGraph/slack_PIP.jpg")
imwrite(rgb2gray(imread("./result/timeGraph/slack_PIP.jpg")), "./result/timeGraph/slack_PIP_gray.jpg")


