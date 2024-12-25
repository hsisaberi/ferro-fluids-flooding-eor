%1
NPs_Concentration=InputData(:,1);

%2
Polymer_Concentration=InputData(:,2);

%3
NPs_Size=InputData(:,3);

%4
Brine_Salinity=InputData(:,4);

%5
API_Gravity=InputData(:,5);

%6
Initial_Oil_Saturation=InputData(:,6);

%7
Viscosity=InputData(:,7);

%8
Temperature=InputData(:,8);


%9
Prosity=InputData(:,9);

%10
Permeability=InputData(:,10);

%11
PV_injection=InputData(:,11);

%12
NPs_EOR_Method=InputData(:,12);

%13
Rock_Type=InputData(:,13);

EOR=outputs;

%% r calculator

%1
r_NPs_Concentration=rcalculator(NPs_Concentration,EOR);

%2
r_Polymer_Concentration=rcalculator(Polymer_Concentration,EOR);

%3
r_NPs_Size=rcalculator(NPs_Size,EOR);

%4
r_Brine_Salinity=rcalculator(Brine_Salinity,EOR);

%5
r_API_Gravity=rcalculator(API_Gravity,EOR);

%6
r_Initial_Oil_Saturation=rcalculator(Initial_Oil_Saturation,EOR);

%7
r_Viscosity=rcalculator(Viscosity,EOR);

%8
r_Temperature=rcalculator(Temperature,EOR);

%9
r_Prosity=rcalculator(Prosity,EOR);

%10
r_Permeability=rcalculator(Permeability,EOR);

%11
r_PV_injection=rcalculator(PV_injection,EOR);

%12
r_NPs_EOR_Method=rcalculator(NPs_EOR_Method,EOR);

%13
r_Rock_Type=rcalculator(Rock_Type,EOR);









