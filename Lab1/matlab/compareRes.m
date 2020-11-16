%%
clc
close all
clear all

simout_mat = importdata('../C/resultsm.txt');
simout_C11 = importdata('../C/resultC11.txt');
simout_C8 = importdata('../C/resultC8.txt');
simout_C8then7 = importdata('../C/resultC8then7.txt');
simout_C11then8 = importdata('../C/resultC11then8.txt');
x = (linspace(0, 20, 201))';

figure(1)
plot(x,simout_mat, 'Linewidth', 1.5, 'LineStyle', '--', 'Color', 'k', 'Marker', '^');
hold on
plot(x,simout_C11, 'Linewidth', 1.5, 'LineStyle', '--', 'Color', 'k', 'Marker', '*');
grid minor
grid on
xlabel('Time[ms]');
ylabel('Samples');
title('Model Comparison: Matlab vs C');
ylim([-600 600]);
legend('Matlab Results', 'C Results', 'Location', 'Northeast', 'LineWidth', 1.0);

figure(2)
plot(x, simout_C11then8, 'Linewidth', 1.5, 'LineStyle', '--');
hold on
plot(x, simout_C8, 'Linewidth', 1.5, 'LineStyle', '--');
hold on
plot(x, simout_C8then7, 'Linewidth', 1.5, 'LineStyle', '--');
hold on
plot(x, simout_C11,'Linewidth', 1.5, 'LineStyle', '--');
grid minor
grid on
xlabel('Time[ms]');
ylabel('Samples');
title('Reference Model: Word-length Comparison');
ylim([-600 600]);
legend('11->8','8','8->7', 'C11', 'Location', 'Southwest', 'LineWidth', 1.0);

figure(3) 
subplot(2,2,1)
thd(simout_C11/10,1e4,10);
title('11 bits, THD = ', thd(simout_C11/10,1e4,10));
subplot(2,2,2)
thd(simout_C11then8/10,1e4,10);
title('8 bits - Trunc after mpy, THD = ', thd(simout_C11then8/10,1e4,10));
subplot(2,2,3)
thd(simout_C8/10,1e4,10);
title('8 bits - Trunc after inputs, THD = ', thd(simout_C8/10,1e4,10));
subplot(2,2,4)
thd(simout_C8then7/10,1e4,10);
title('8 bits - Trunc after inputs, 7 bits - Trunc after mpy, THD = ', thd(simout_C8then7/10,1e4,10));


