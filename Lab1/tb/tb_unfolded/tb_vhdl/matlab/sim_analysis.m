clc
clear all
close all

% data conversion to binary

samples = importdata("samples.txt"); 
samples_bin_straight = dec2q(samples,10,0,'bin');
check = q2dec(samples_bin_straight,10,0,'bin');
plot(samples);
hold on;
plot(check);

fileID = fopen("input_samples_straight.txt",'w');

for i=1:numel(samples_bin_straight(:,1))
    fprintf(fileID,'1%s\n',strcat(samples_bin_straight(i,:)));
end
fclose(fileID);

j = 0;
i = 1;
k = 1;
random = 0;
while j == 0
    x=rand;
    
    if x<0.3
        coin_flip = 1;
    else
        coin_flip = 0;
    end
    
    [x coin_flip]
    
    if (coin_flip  == 1)
        samples_rand(k) = samples(i);
        vin_vect(k) = 1;
        i = i+1;
        k = k+1;
        
    else
        samples_rand(k) = rand*(2^10 - 1);
        vin_vect(k) = 0;
        k = k+1;
        random = random + 1;
    end
    
    if (i == length(samples)+1)
        j = 1;
    end
end

samples_ones = ones(100);
vin_ones = ones(100);
fileID = fopen("input_samples_ones.txt",'w');
samples_bin_ones = dec2q(samples_ones,10,0,'bin');
for i=1:numel(samples_bin_ones(:,1))
    fprintf(fileID,'%d%s\n',vin_ones(i),strcat(samples_bin_ones(i,:)));
end
fclose(fileID);

fileID = fopen("C:\Users\Francesco\Desktop\POLITO\V_ANNO\Integrated_System_Architecture\Lab1\C\myfir_unfolded\samples_ones.txt",'w');
for i=1:numel(samples_bin_ones(:,1))
    fprintf(fileID,'%d\n',samples_ones(i));
end
fclose(fileID);


fileID = fopen("input_samples_random.txt",'w');
samples_bin_rand = dec2q(samples_rand,10,0,'bin');
for i=1:numel(samples_bin_rand(:,1))
    fprintf(fileID,'%d%s\n',vin_vect(i),strcat(samples_bin_rand(i,:)));
end
fclose(fileID);

fileID = fopen("input_samples_triplets.txt",'w');
for i=1:numel(samples_bin_straight(:,1))
    fprintf(fileID,'%s\n',samples_bin_straight(i,:));
end
fclose(fileID);
    

fileID = fopen("input_samples_random_n.txt",'w');
for i=1:numel(samples_bin_rand(:,1))
    fprintf(fileID,'%s\n',strcat(samples_bin_rand(i,:)));
end
fclose(fileID);


%% data analysis from simulation
clc
close all

fid = fopen("C:\Users\Francesco\Documents\GitHub\Laboratori-ISA\Lab1\tb\tb_unfolded\tb_vhdl\matlab\output_samples_sim_random.txt",'r'); 
simout_t = textscan(fid,'%s'); 
simout_t = string(simout_t{:});
simout_dec = q2dec(char(simout_t),10,0,'bin');
fclose(fid);

fid = fopen("C:\Users\Francesco\Documents\GitHub\Laboratori-ISA\Lab1\tb\tb_unfolded\tb_vhdl\matlab\input_samples_random_n.txt",'r'); 
simin_t = textscan(fid,'%s'); 
simin_t = string(simin_t{:});
simin_dec = q2dec(char(simin_t),10,0,'bin');
fclose(fid);


correct_results = importdata("C:\Users\Francesco\Desktop\POLITO\V_ANNO\Integrated_System_Architecture\Lab1\C\myfir_unfolded\resultC_unfolded8.txt",'r'); 
correct_results = [correct_results'];
plot(simout_dec,'Linewidth',1.5);
hold on;
plot(correct_results,'Linewidth',1.5);
legend('Sim-Out','C-Out');

figure
subplot(1,2,1)
thd(correct_results,10000,10);
subplot(1,2,2)
sinad(correct_results,10000);

figure
subplot(1,2,1)
thd(simout_dec,10000,10);
subplot(1,2,2)
sinad(simout_dec,10000);


%% C result debug
clc
close all
clear all

simout_C8 = importdata("C:\Users\Francesco\Desktop\POLITO\V_ANNO\Integrated_System_Architecture\Lab1\C\myfir_unfolded\resultC_unfolded8.txt",'r'); 
simout_Pipe8 = importdata("C:\Users\Francesco\Desktop\POLITO\V_ANNO\Integrated_System_Architecture\Lab1\C\myfir_unfolded\resultC_Pipe.txt",'r'); 

plot(simout_Pipe8,'-o');
hold on;
plot(simout_C8);
legend('Pipe','Correct');


% [r8,harmpow8,harmfreq8] = thd(correct_results,1e4,10);
% [r8a,harmpow8a,harmfreq8a] = thd(simout_C8all,1e4,10);
% [r7a,harmpow7a,harmfreq7a] = thd(simout_C7all,1e4,10);
% 
% dist8 = 0;
% dist8a = 0;
% dist7a = 0;
% harmpow8_lin = 10.^(harmpow8(2:end)./10);
% harmpow8a_lin = 10.^(harmpow8a(2:end)./10);
% harmpow7a_lin = 10.^(harmpow7a(2:end)./10);
% dist8 = sum(harmpow8_lin);
% dist8a = sum(harmpow8a_lin);
% dist7a = sum(harmpow7a_lin);
% figure 
% 
% subplot(2,3,1)
% thd(simout_C11then8,1e4,10);
% %title('8 bits - Trunc after mpy - THD = ',);
% subplot(2,3,2)
% thd(simout_C8,1e4,10);
% %title('8 bits - Trunc after inputs');
% subplot(2,3,3)
% thd(simout_C8then7,1e4,10);
% %title('7 bits - Trunc after inputs');
% subplot(2,3,4)
% sinad(simout_C11then8,1e4);
% %title('8 bits - Trunc after mpy');
% subplot(2,3,5)
% sinad(simout_C8,1e4);
% %title('8 bits - Trunc after inputs');
% subplot(2,3,6)
% sinad(simout_C8then7,1e4);
% %title('7 bits - Trunc after inputs');

    
%% NUMBER OF BITS SIMULATOR
clc
clear all
close all

insamples = importdata("samples.txt");




