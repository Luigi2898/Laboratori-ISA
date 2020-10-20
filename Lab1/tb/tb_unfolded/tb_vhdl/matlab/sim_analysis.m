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

fileID = fopen("input_samples_random.txt",'w');
samples_bin_rand = dec2q(samples_rand,10,0,'bin');
for i=1:numel(samples_bin_rand(:,1))
    fprintf(fileID,'%d%s\n',vin_vect(i),strcat(samples_bin_rand(i,:)));
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


correct_results = importdata("C:\Users\Francesco\Documents\GitHub\Laboratori-ISA\Lab1\matlab\results_untouched.txt");

count = 0;
for i=1:length(correct_results)
    if vin_vect(i) == 1
        count = count + 1;
    end
end
fprintf('The number of processed samples is %d, it should be %d.\n',length(simout_dec),length(correct_results))
for i=1:length(correct_results)
    if (i>length(simout_dec))
        fprintf('VHDL:\t%UUU\tC:\t%d\n',correct_results(i)*(1024/0.5));
    else
        fprintf('VHDL:\t\t%d\t\tC:\t\t%d\n',simout_dec(i),correct_results(i)*(1024/0.5));
    end
end
plot(simout_dec.*2,'Linewidth',1.5);
hold on;
plot(correct_results.*(1024/0.5),'Linewidth',1.5);
plot(samples,'Linewidth',1.5);
legend('VHDL Results','Matlab Results','Input Samples');

%matlab partial results
clc
k = 1;
i = 1;
while i < length(samples)-2
    input0(k) = samples(i);
    input1(k) = samples(i+1);
    input2(k) = samples(i+2);
    k = k + 1;
    i = i + 3;
end
[input0' input1' input2']