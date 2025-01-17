function PlotResults(t,y,tnormal,ynormal,name)

    figure;
    
    % t and y
    subplot(2,2,1);
    plot(y,'k');
    hold on
    plot(t,'r:');
    legend('Outputs','Targets');
%     title(name);
    [~, AAD]=AARD(t,y);
    title(['AARD= ' num2str(AAD) '  ' name]);
    
    % correlation Plot
    subplot(2,2,2);
    plot(t,y,'ko');
    hold on;
    xmin=min(min(t),min(y));
    xmax=max(max(t),max(y));
    plot([xmin xmax],[xmin xmax],'b','LineWidth',2);
    R=corr(t',y');  %dota bordar amodi bayad bashad
    title(['R^2= ' num2str(R^2)]);
    
    % e
    subplot(2,2,3);
    e=tnormal-ynormal;
    plot(e,'b');
    legend('Error');
    MSE=mean(e.^2);
    RMSE=sqrt(MSE);
    title(['MSE= ' num2str(MSE) ', RMSE= ' num2str(RMSE)]);
    
    subplot(2,2,4);
    histfit(e,50);
    eMean=abs(mean(e));
    eStd=std(e);       %enheraf Meyar
    title(['\mu = ' num2str(eMean) ', \sigma = ' num2str(eStd)]);
    
end