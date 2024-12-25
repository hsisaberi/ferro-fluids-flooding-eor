def Plot_Results(target, output, targetsnormal, outputsnormal, name):
    
    import matplotlib.pyplot as plt
    import numpy as np
    from AARD import AARD
    
    font = {'family': 'Times New Roman'}
    plt.figure(figsize=(7, 5.6), dpi=400)
    
    
    # target and output
    plt.subplot(2,2,1)
    plt.plot(output, 'k', label='Outputs')
    plt.plot(target, 'r:', label='Targets')
    plt.legend(bbox_to_anchor=(0, .89, 0.99, 0.1), borderaxespad=0., fontsize=4)
    AARD1 = AARD(target, output)
    AARD1 = round(float(AARD1), 4)
    plt.title('AARD = ' + str(AARD1) + ' ' + str(name), fontdict = font, fontsize=8)
    
    
#     plt.figure(figsize=(3,2.4), dpi=400)
    # Correlation Plot
    plt.subplot(2,2,2)
    plt.plot(target, output, 'ko', label='Outputs', markeredgecolor = 'k', markerfacecolor = [1, 1, 1])
    xmin = min(min(target), min(output))
    xmax = max(max(target), max(output))
    plt.plot([xmin, xmax], [xmin, xmax], 'b', linewidth = 2)
    corr = np.corrcoef(target.reshape(len(target),), output.reshape(len(target),))[0,1]
    R_sq = corr**2
    R_sq = round(float(R_sq), 4)
    plt.title('R$^{2}$ = ' + str(float(R_sq)), fontdict = font, fontsize=8)
    
    
    plt.figure(figsize=(7, 5.6), dpi=400)
    # Error plots
    plt.subplot(2,2,1)
    e = targetsnormal-outputsnormal
    plt.plot(e, 'b', label='Error')
    plt.legend(bbox_to_anchor=(0, .89, 0.99, 0.1), borderaxespad=0., fontsize=4)
    MSE = np.mean(e**2)
    RMSE = MSE**(1/2)
    MSE = round(float(MSE), 4)
    RMSE = round(float(RMSE), 4)
    plt.title('MSE = ' + str(MSE) + ', RMSE = ' + str(RMSE), fontdict = font, fontsize=8)
    
    
#     plt.figure(figsize=(3, 2.4), dpi=400)
    plt.subplot(2,2,2);
    plt.hist(e, 50, facecolor = 'green', alpha = 0.75, density = True, stacked = True, histtype='bar');
    plt.grid()
    eMean = np.abs(np.mean(e));
    eMean = round(float(eMean), 4)
    eStd = np.std(e);       # enheraf Meyar
    eStd = round(float(eStd), 4)
    plt.title(r'$\mu = $' + str(eMean) + r', $\sigma = $ ' + str(eStd), fontdict = font, fontsize=8);