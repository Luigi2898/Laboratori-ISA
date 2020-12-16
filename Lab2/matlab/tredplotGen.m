close all
clear all
clc

AreaBasic = 5621.643961;
AreaCSA =   5072.087958;
AreaPP = 4345.641962;

Area = [AreaPP AreaBasic AreaCSA];
Area = Area/max(Area);

PeriodBasic = 1.60;
PeriodCSA = 1.58;
PeriodPP = 1.56;

Period = [PeriodPP PeriodBasic PeriodCSA];
Period = Period / max(Period);

PowerBasic = 1.4690;
PowerCSA = 1.2068;
PowerPP = 1.2040;

Power = [PowerPP PowerBasic PowerCSA];
Power = Power/max(Power);

toBPlt = [Area; Period; Power];

f = figure
bar(toBPlt)
xticklabels(["Area" "Delay" "Power"])
legend('Auto', 'PPARCH', 'CSA', 'Location', 'SouthEast')
saveas(f, 'd3_impl.jpg')








AreaBEH = 5851.999923;
AreaDADDA = 7602.01;
AreaWALLACE = 7700.433835;

AreaMBE = [AreaBEH AreaDADDA AreaWALLACE];
AreaMBE = AreaMBE / max(AreaMBE);

DelayBEH = 0.91;
DelayDADDA = 0.74;
DelayWALLACE = 0.73;

DelayMBE = [DelayBEH DelayDADDA DelayWALLACE];
DelayMBE = DelayMBE / max(DelayMBE);

PowerBEH = 1.2250;
PowerDADDA = 2.9864;
PowerWALLACE = 2.2278;

PowerMBE = [PowerBEH PowerDADDA PowerWALLACE];
PowerMBE = PowerMBE / max(PowerMBE);

toBPlt = [AreaMBE; DelayMBE; PowerMBE];

f = figure
bar(toBPlt)
xticklabels(["Area" "Delay" "Power"])
saveas(f, 'MBE.jpg')
legend('Behavioural', 'Dadda', 'Wallace', 'Location', 'SouthEast')








