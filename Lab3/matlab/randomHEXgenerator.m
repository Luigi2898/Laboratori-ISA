close all
clear all
clc

x = randi(2^29,1000,1);


plot(x)

hex = dec2hex(x);

fID = fopen("../file/input_random.hex",'w');

for i = 1:1000
    fprintf(fID,"%s\n",hex(i,:));
end

fclose(fID);