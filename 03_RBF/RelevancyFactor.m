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
disp(['r_NPs_Concentration: ' num2str(r_NPs_Concentration)])

%2
r_Polymer_Concentration=rcalculator(Polymer_Concentration,EOR);
disp(['r_Polymer_Concentration: ' num2str(r_Polymer_Concentration)])

%3
r_NPs_Size=rcalculator(NPs_Size,EOR);
disp(['r_NPs_Size: ' num2str(r_NPs_Size)])

%4
r_Brine_Salinity=rcalculator(Brine_Salinity,EOR);
disp(['r_Brine_Salinity: ' num2str(r_Brine_Salinity)])

%5
r_API_Gravity=rcalculator(API_Gravity,EOR);
disp(['r_API_Gravity: ' num2str(r_API_Gravity)])

%6
r_Initial_Oil_Saturation=rcalculator(Initial_Oil_Saturation,EOR);
disp(['r_Initial_Oil_Saturation: ' num2str(r_Initial_Oil_Saturation)])

%7
r_Viscosity=rcalculator(Viscosity,EOR);
disp(['r_Viscosity: ' num2str(r_Viscosity)])

%8
r_Temperature=rcalculator(Temperature,EOR);
disp(['r_Temperature: ' num2str(r_Temperature)])

%9
r_Prosity=rcalculator(Prosity,EOR);
disp(['r_Prosity: ' num2str(r_Prosity)])

%10
r_Permeability=rcalculator(Permeability,EOR);
disp(['r_Permeability: ' num2str(r_Permeability)])

%11
r_PV_injection=rcalculator(PV_injection,EOR);
disp(['r_PV_injection: ' num2str(r_PV_injection)])

%12
r_NPs_EOR_Method=rcalculator(NPs_EOR_Method,EOR);
disp(['r_NPs_EOR_Method: ' num2str(r_NPs_EOR_Method)])

%13
r_Rock_Type=rcalculator(Rock_Type,EOR);
disp(['r_Rock_Type: ' num2str(r_Rock_Type)])









