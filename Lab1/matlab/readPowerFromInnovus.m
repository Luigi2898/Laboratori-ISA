function [Power, typeOfPower] = readPowerFromInnovus(fileName)
    typeOfPower = ["Total internal power"; "Total switching power"; "Total Leakage power"; "Total power"];
    Power = importdata(fileName);
end

