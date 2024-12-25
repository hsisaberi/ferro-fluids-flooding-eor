close all;
%% First Plot

figure;
hold on
plot(Targets,'ko','MarkerFaceColor','k', 'MarkerSize', 10, 'LineWidth', 3);
plot(Outputs,'go', 'MarkerSize', 10, 'LineWidth', 3);

legend('Experimental Data','ANFIS Data');
% title('All Data');
xlabel('Data Index')
ylabel('EOR(%)')

a = gca;
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)

xx = gca;
xx.FontSize = 22;
% xx.YLabel.String = 'Number of Data';
xx.FontName = 'Times New Roman';
% xx.XAxis.TickLength = [0 2];
% xx.XLim = [0.5 3.5];
xx.YLim = [0 35];
xx.XLim = [0 985];

xx.Legend.Box = 'off';

xx.YLabel.FontSize = 33;
xx.XLabel.FontSize = 33;
xx.Legend.FontSize=22;
xx.XAxis.FontSize = 30;
xx.YAxis.FontSize = 30;

%% Second Plot

figure;
e=targetsnormal-outputsnormal;
plot(e,'b', 'LineWidth', 3);
legend('Error');
xlabel('Data Index')
ylabel('Error')

a = gca;
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)

xx = gca;
xx.FontSize = 22;
% xx.YLabel.String = 'Number of Data';
xx.FontName = 'Times New Roman';
% xx.XAxis.TickLength = [0 2];
% xx.YLim = [0 35];
xx.XLim = [0 985];

xx.Legend.Box = 'off';

xx.YLabel.FontSize = 33;
xx.XLabel.FontSize = 33;
xx.Legend.FontSize=22;
xx.XAxis.FontSize = 30;
xx.YAxis.FontSize = 30;

%% Third Plot

figure;

t=Targets;
y=Outputs;

plot(t,y,'ko', 'MarkerSize', 10, 'LineWidth', 3);
hold on;
xmin=min(min(t),min(y));
xmax=max(max(t),max(y));
plot([xmin xmax],[xmin xmax],'b','LineWidth',2, 'MarkerSize', 10, 'LineWidth', 5);


a = gca;
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)

ylabel('Output')
xlabel('Target')
legend('Data', 'Fit');
legend('Location', 'NW')

xx = gca;
xx.FontSize = 22;
% xx.YLabel.String = 'Number of Data';
xx.FontName = 'Times New Roman';
% xx.XAxis.TickLength = [0 2];
xx.YLim = [0 33];
xx.XLim = [0 33];

xx.Legend.Box = 'off';

xx.YLabel.FontSize = 33;
xx.XLabel.FontSize = 33;
xx.Legend.FontSize=22;
xx.XAxis.FontSize = 30;
xx.YAxis.FontSize = 30;

%% Forth Plot

figure;
e=targetsnormal-outputsnormal;
plot(e,'b');
legend('Error');
MSE=mean(e.^2);
RMSE=sqrt(MSE);
title(['MSE= ' num2str(MSE) ', RMSE= ' num2str(RMSE)]);

histfit(e,50);
eMean=abs(mean(e));
eStd=std(e);       %enheraf Meyar

% xlim([-0.15 0.15])
xlabel('Residual')
ylabel('Frequency')

a = gca;
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)

xx = gca;
xx.FontSize = 22;
% xx.YLabel.String = 'Number of Data';
xx.FontName = 'Times New Roman';
% xx.XAxis.TickLength = [0 2];
% xx.YLim = [0 35];
% xx.XLim = [0 985];


xx.YLabel.FontSize = 33;
xx.XLabel.FontSize = 33;
xx.XAxis.FontSize = 30;
xx.YAxis.FontSize = 30;