def Reading_Data():
    
    import pandas as pd
    import numpy as np

    # Reading the dataset
    dataframe = pd.read_excel('SamplesColectting.xlsx')
    m = 1368
    NPs_EOR_Method = dataframe.iloc[:m, 18].values.reshape(m,1)
    NPs_Concentration = dataframe.iloc[:m, 2].values.reshape(m,1)
    Polymer_Concentration = dataframe.iloc[:m, 3].values.reshape(m,1)
    NPs_Type = dataframe.iloc[:m, 19].values.reshape(m,1)
    NPs_Size = dataframe.iloc[:m, 5].values.reshape(m,1)
    Brine_Salinity = dataframe.iloc[:m, 6].values.reshape(m,1)
    API_Gravity = dataframe.iloc[:m, 7].values.reshape(m,1)
    Initial_Oil_Saturation = dataframe.iloc[:m, 8].values.reshape(m,1)
    Viscosity = dataframe.iloc[:m, 9].values.reshape(m,1)
    Temperature = dataframe.iloc[:m, 10].values.reshape(m,1)
    Prosity = dataframe.iloc[:m, 11].values.reshape(m,1)
    Permeability = dataframe.iloc[:m, 12].values.reshape(m,1)
    Rock_Type = dataframe.iloc[:m, 20].values.reshape(m,1)
    PV_injection = dataframe.iloc[:m, 14].values.reshape(m,1)
    EOR = dataframe.iloc[:m, 15].values.reshape(m,1)

    Input = np.array([NPs_EOR_Method, NPs_Concentration, Polymer_Concentration, NPs_Type, NPs_Size, Brine_Salinity,
                      API_Gravity,Initial_Oil_Saturation, Viscosity, Temperature, Prosity, Permeability,
                      Rock_Type, PV_injection]).reshape(14,1368).T
    Target = EOR
    return Input, Target