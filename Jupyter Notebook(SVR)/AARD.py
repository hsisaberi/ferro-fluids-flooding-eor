def AARD(real, predict):
    
    import numpy as np
    
    N=len(real)
#     w=0
#     for i in range(len(real)):
#         w=np.abs((real[i]-predict[i])/real[i])+w;

#     AARDloop=100/N*w;

    AARD1 = 100/N*np.sum(np.abs((real-predict)/real))

    return AARD1