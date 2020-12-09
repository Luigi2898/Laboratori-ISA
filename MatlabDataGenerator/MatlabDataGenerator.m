clc
clear all
close all

% Unsigned number generator
Nbit = 33;
Nsamples = 102;
Ncol = 17;
Nrows = ceil(Nsamples/Ncol);

dec_samples = randi([-2^31 2^31],1,Nsamples);
%dec_samples = randi([-5 5],1,Nsamples);

for i=17:17:numel(dec_samples)
if (dec_samples(i) < 0)
    dec_samples(i) = -1*dec_samples(i);
end
end


filename = "../Lab2/tb/stimulus_files/DaddaTestInputs.txt"

fID = fopen(filename,'w');

k = 1;
for i=1:Nrows
    for j=1:Ncol
        bin_input_tmp = dec2q(dec_samples(k),Nbit-1,0,'bin');
        fprintf(fID,"%s",bin_input_tmp);
        k = k + 1;
    end
    fprintf(fID,"\n");
end

fclose(fID);

filename = "./DaddaTestInputsInt.txt"

fID = fopen(filename,'w');

k = 1;
for i=1:numel(dec_samples)
    fprintf(fID,"%d\n",dec_samples(i));
end

fclose(fID);
  
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
        
        
        