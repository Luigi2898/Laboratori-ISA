close all
clear all
clc

AreaBasic = 3749.26;
AreaCSA = 4803.69;
AreaPP = 3547.37;

Area = [AreaPP AreaBasic AreaCSA];
Area = Area/max(Area);

PeriodBasic = 5.03;
PeriodCSA = 4.454;
PeriodPP = 5.09;

Period = [PeriodPP PeriodBasic PeriodCSA];
Period = Period / max(Period);

PowerBasic = 1.665;
PowerCSA = 1.202;
PowerPP = 1.040;

Power = [PowerPP PowerBasic PowerCSA];
Power = Power/max(Power);

toBPlt = [Area; Period; Power];

f = figure
bar(toBPlt)
xticklabels(["Area" "Delay" "Power"])
legend('PPARCH', 'Auto', 'CSA', 'Location', 'SouthEast')
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

PowerBEH = 1.324;
PowerDADDA = 2.053;
PowerWALLACE = 2.087;

PowerMBE = [PowerBEH PowerDADDA PowerWALLACE];
PowerMBE = PowerMBE / max(PowerMBE);

toBPlt = [AreaMBE; DelayMBE; PowerMBE];

f = figure
bar(toBPlt)
xticklabels(["Area" "Delay" "Power"])
legend('Behavioural', 'Dadda', 'Wallace', 'Location', 'SouthEast')
saveas(f, 'optall.jpg')










AreaBEH = 4429.96;
AreaDADDA = 6126.51;
AreaWALLACE = 6234.5;

AreaMBE = [AreaBEH AreaDADDA AreaWALLACE];
AreaMBE = AreaMBE / max(AreaMBE);

DelayBEH = 1.27;
DelayDADDA = 1.46;
DelayWALLACE = 1.70;

DelayMBE = [DelayBEH DelayDADDA DelayWALLACE];
DelayMBE = DelayMBE / max(DelayMBE);

PowerBEH = 1.225;
PowerDADDA = 2.986;
PowerWALLACE = 2.595;

PowerMBE = [PowerBEH PowerDADDA PowerWALLACE];
PowerMBE = PowerMBE / max(PowerMBE);

toBPlt = [AreaMBE; DelayMBE; PowerMBE];

f = figure
bar(toBPlt)
xticklabels(["Area" "Delay" "Power"])
legend('Behavioural', 'Dadda', 'Wallace', 'Location', 'SouthEast')
saveas(f, 'compultraall.jpg')










AreaBasic = 3749.26;
AreaCSA = 4803.69;
AreaPP = 3547.37;
AreaDADDA = 
AreaWA = 


Area = [AreaPP AreaBasic AreaCSA];
Area = Area/max(Area);

PeriodBasic = 5.03;
PeriodCSA = 4.454;
PeriodPP = 5.09;

Period = [PeriodPP PeriodBasic PeriodCSA];
Period = Period / max(Period);

PowerBasic = 1.665;
PowerCSA = 1.202;
PowerPP = 1.040;

Power = [PowerPP PowerBasic PowerCSA];
Power = Power/max(Power);

toBPlt = [Area; Period; Power];

f = figure
bar(toBPlt)
xticklabels(["Area" "Delay" "Power"])
legend('PPARCH', 'Auto', 'CSA', 'Location', 'SouthEast')
saveas(f, 'd3_impl.jpg')








