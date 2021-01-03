clc
clear all
close all

fprintf('------------- BINARY DATA GENERATOR -------------\n');
Nbit = input('- Enter the word length: ');
Nsamples = input('- Enter the number of samples: ');
Ncol = input('- Enter the number of parallel data (enter 1 for serial data): ');
Nrows = ceil(Nsamples/Ncol);
Sign = input('- Do you want''em to be signed (S) or unsigned (U)?: ','s');
Dec = input ('- Do you want''em to be integers (I) or decimal (D)?: ','s');
Range = input('- Enter the sweep limits as [lower upper]: ','s');
Arrange = input('- Enter the trend of the data, (R) for random, (O) for sorted (from smaller to bigger): ','s');
lim_low = 0;
lim_upp = 0;
lims = sscanf(Range,'[%d %d]');

if Arrange == "R"
    if Sign == "S" && Dec == "I"
        dec_samples = randi([lims(1) lims(2)],1,Nsamples);
    elseif Sign == "S" && Dec == "D"
        dec_samples = rand([lims(1) lims(2)],1,Nsamples);
    elseif Sign == "U"
        dec_samples = randi([lims(1) lims(2)],1,Nsamples);
    else
        fprintf('It looks like you can''t even fill 6 fields properly, have you considered switching to law studies?\n');
        return
    end
else
    dec_samples = [];
    for i = lims(1):lims(2)
        dec_samples = [dec_samples i];
    end
end
    

Filename = input('- Enter the file name with its relative path wrt this folder but without file extension\n (press enter to choose this folder as destination and Stimuli as filename):\n-> ','s');
if isempty(Filename)
    Filename = "./Stimuli";
end

filename = strcat(Filename,'Bin.txt');
fID = fopen(filename,'w');

k = 1;
for i=1:Nrows
    for j=1:Ncol
        if Dec == "D"
            bin_input_tmp = dec2q(dec_samples(k),Nbit-1,0,'bin');
            fprintf(fID,"%s",bin_input_tmp);
            k = k + 1;
        else
            bin_input_tmp = dec2bin(dec_samples(k),Nbit);
            fprintf(fID,"%s",bin_input_tmp);
            k = k + 1;
        end
    end
    fprintf(fID,"\n");
end

fclose(fID);

filename = strcat(Filename,'Int.txt');

fID = fopen(filename,'w');

k = 1;
for i=1:numel(dec_samples)
    fprintf(fID,"%d\n",dec_samples(i));
end

fclose(fID);

fprintf('Data have been correctly generated, good luck with your testbench, bye!\n');
return
  
%%

clc
clear all
close all


format rat

dec_samples = importdata('DaddaTestInputsInt.txt');

sum_tmp = 0;

for i = 1:1:17
    sum_tmp = sum_tmp + dec_samples(i)*(4^(i-1));
    (i)
    sum_tmp_vect(i) = sum_tmp;
end

first_set = dec_samples(1:17);

sum_tmp
        
res_tb = '000000000001110001111001101011100101110100111000111011100101001110'
dec2q(sum_tmp,64,0,'bin')


sum_tmp_vect'
        
        
        