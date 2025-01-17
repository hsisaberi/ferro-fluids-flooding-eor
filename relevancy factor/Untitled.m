clc;
clear;
close all;

load EORData.mat

load outputmlp.mat
outputmlp=outputs;
% EORData = [PolymerConcentration SaltConcentration RockType InitialOilSaturation Prosity Permeability PVinj Temp EOR API MolecularWeight SaltType];

load rbfoutputs.mat
outputrbf=outputs;

load anfisoutput.mat
outputanfis=Outputs;

%1
PolymerConcentration=EORData(:,1);

%2
SaltConcentration=EORData(:,2);

%3
RockType=EORData(:,3);

%4
InitialOilSaturation=EORData(:,4);

%5
Prosity=EORData(:,5);

%6
Permeability=EORData(:,6);

%7
PVinj=EORData(:,7);

%8
Temp=EORData(:,8);


%9
API=EORData(:,10);

%10
MolecularWeight=EORData(:,11);

%11
SaltType=EORData(:,12);

% EOR Data
% EOR=EORData(:,9);
% EOR=outputmlp;
% EOR=outputrbf;
EOR=outputanfis;

%% r calculator

%1
rPolymerConcentration=rcalculator(PolymerConcentration,EOR);

%2
rSaltConcentration=rcalculator(SaltConcentration,EOR);

%3
rRockType=rcalculator(RockType,EOR);

%4
rInitialOilSaturation=rcalculator(InitialOilSaturation,EOR);

%5
rProsity=rcalculator(Prosity,EOR);

%6
rPermeability=rcalculator(Permeability,EOR);

%7
rPVinj=rcalculator(PVinj,EOR);

%8
rTemp=rcalculator(Temp,EOR);

%9
rAPI=rcalculator(API,EOR);

%10
rMolecularWeight=rcalculator(MolecularWeight,EOR);

%11
rSaltType=rcalculator(SaltType,EOR);












