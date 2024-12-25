clc;
clear;
close all;

load EORData.mat
format long g

%% New Generalized Data
nData=10;

NPs_Concentration = 100*ones(nData,1);                              % 1)  range (200, 8000)
NPs_Concentration_linspace = linspace(200,8000, 3)';

Polymer_Concentration = 100*ones(nData,1);                          % 2)  range (0, 1000)
Polymer_Concentration_linspace = linspace(0, 1000, 3)';

NPs_Size = 10*ones(nData,1);                                        % 3)  range (12, 80)
NPs_Size_linspace = linspace(12, 80, 3)';

Brine_Salinity = 5000*ones(nData,1);                                % 4)  range (5000, 106200)
Brine_Salinity_linspace = linspace(5000, 106200, 3)';

API_Gravity = 10*ones(nData,1);                                     % 5)  range (17.1,58)
API_Gravity_linspace = linspace(17.1, 58, 3)';

Initial_Oil_Saturation = 70*ones(nData,1);                          % 6)  range (72.6,100)
Initial_Oil_Saturation_linspace = linspace(72.6, 100, 2)';

Viscosity = 80*ones(nData,1);                                       % 7)  range (0.8066,355.5000)
Viscosity_linspace = linspace(0.8066, 355.5000, 3)';

Temperature = 25*ones(nData,1);                                     % 8)  range (25,85)
Temperature_linspace = linspace(25, 85, 3)';

Porosity = 10*ones(nData,1);                                        % 9)  range (17.8,31)
Porosity_linspace = linspace(17.8, 31, 3)';

Permeability = 0.001*ones(nData,1);                                 % 10) range (34.12, 17000)
Permeability_linspace = linspace(34.12, 17000, 3)';

PV_injection = 1*ones(nData,1);                                     % 11) range (1,10.6192)
PV_injection_linspace = linspace(1,10.6192,4)';

NPs_EOR_Method = 1*ones(nData,1);                                   % 12) range (1,2) 1 >>> neutral NPs, 2 >>> coated NPs
NPs_EOR_Method_linspace = [1:2]';

Rock_Type = 1*ones(nData,1);                                        % 13) range (1,2) 1 >>> SandStone,   2 >>> Carbonate
Rock_Type_linspace = [1:2]';


NewInput = [NPs_Concentration Polymer_Concentration NPs_Size Brine_Salinity API_Gravity Initial_Oil_Saturation Viscosity Temperature Porosity Permeability PV_injection NPs_EOR_Method Rock_Type];

AllNewCombinations = allcomb(NPs_Concentration_linspace, Polymer_Concentration_linspace, NPs_Size_linspace, Brine_Salinity_linspace, API_Gravity_linspace, Initial_Oil_Saturation_linspace, Viscosity_linspace, Temperature_linspace, Porosity_linspace, Permeability_linspace, PV_injection_linspace, NPs_EOR_Method_linspace, Rock_Type_linspace);

%% Calculations

a = find(AllNewCombinations(:,12)==2);
AllNewCombinations(a,2) = 0;






