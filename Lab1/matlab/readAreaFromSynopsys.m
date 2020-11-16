function [Area, typeOfArea] = readAreaFromSynopsys(fileName)
    typeOfArea = ["Combinational"; "Buf/Inv"; "Noncombinational"; "Macro/Black Box"; "Total"];
    Area = importdata(fileName);
end

