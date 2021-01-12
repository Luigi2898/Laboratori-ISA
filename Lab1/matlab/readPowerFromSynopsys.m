function [Power, typeOfPower] = readPowerFromSynopsys(fileName)
    typeOfPower = ["Cell internal power"; "Net switching power"; "Dynamic power"; "Leakage power"; "Total power"];
    Power = importdata(fileName);
    Power(5) = Power(4) + Power(3);
end

