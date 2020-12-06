INN = [56 ; 78 ;  98 ; 80 ; 23 ;  45 ; 65 ; 76 ; 12 ; 35 ; 68 ; 97 ; 85 ; 35 ; 46 ; 56 ; 76]
OUT = 0;
for i = 2:numel(INN) - 2
   par = INN(i) * 2^(2*(i - 1)) +  (2^(i + 34) + 2^(i+35));
   OUT = OUT + par;
end

OUT = OUT + INN(1) + 2^35;
OUT = OUT + (INN(16) + 2^33)* 2^(30);
OUT = OUT + INN(17) * 2^(17*2)