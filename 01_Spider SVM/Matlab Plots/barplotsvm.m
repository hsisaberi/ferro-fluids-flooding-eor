clc;
clear;
close all;

%% All Data

x = categorical({'Good','Very Good','Great'});
x = reordercats(x,{'Good','Very Good','Great'});
% x = [1, 2, 3];
y = [788, 192, 280];
Legend = {'Good           0 <x<15','Very Good  15<x<25','Great           25<x'};
figure()
barr = bar(x,diag(y,0), 'stacked');

a = gca;
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)
% linkaxes([a b])

legend(Legend);

xx = gca;
xx.YTick = [192, 280, 788];
xx.YLim = [0 788];
xx.FontSize = 22;
xx.YLabel.String = 'Number of Data';
xx.FontName = 'Times New Roman';
xx.XAxis.TickLength = [0 2];
% xx.XLim = [0.5 3.5];
barcolor1 = [255 128 10]./288;
barcolor2 = [255 255 0]./288;
barcolor3 = [99 233 10]./288;
xx.XAxis.TickLabels = {'Good','Very Good','Great'};
xx.ColorOrder =         [barcolor1
                         barcolor2
                         barcolor3
                         0.4940    0.1840    0.5560
                         0.4660    0.6740    0.1880
                         0.3010    0.7450    0.9330
                         0.6350    0.0780    0.1840];
xx.Legend.Box = 'off';

xx.YLabel.FontSize = 33;
xx.Legend.FontSize=22;
xx.XAxis.FontSize = 33;

%% Test Data

x = categorical({'Good','Very Good','Great'});
x = reordercats(x,{'Good','Very Good','Great'});
% x = [1, 2, 3];
y = [243, 49, 86];
Legend = {'Good           0 <x<15','Very Good  15<x<25','Great           25<x'};
figure()
barr = bar(x,diag(y,0), 'stacked');

a = gca;
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)
% linkaxes([a b])

legend(Legend);

xx = gca;
xx.YTick = [49, 86, 243];
xx.YLim = [0 243];
xx.FontSize = 22;
xx.YLabel.String = 'Number of Data';
xx.FontName = 'Times New Roman';
xx.XAxis.TickLength = [0 2];
% xx.XLim = [0.5 3.5];
barcolor1 = [255 128 10]./288;
barcolor2 = [255 255 0]./288;
barcolor3 = [99 233 10]./288;
xx.XAxis.TickLabels = {'Good','Very Good','Great'};
xx.ColorOrder =         [barcolor1
                         barcolor2
                         barcolor3
                         0.4940    0.1840    0.5560
                         0.4660    0.6740    0.1880
                         0.3010    0.7450    0.9330
                         0.6350    0.0780    0.1840];
xx.Legend.Box = 'off';

xx.YLabel.FontSize = 33;
xx.Legend.FontSize=22;
xx.XAxis.FontSize = 33;

%% Train Data

x = categorical({'Good','Very Good','Great'});
x = reordercats(x,{'Good','Very Good','Great'});
% x = [1, 2, 3];
y = [545, 143, 194];
Legend = {'Good           0 <x<15','Very Good  15<x<25','Great           25<x'};
figure()
barr = bar(x,diag(y,0), 'stacked');

a = gca;
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)
% linkaxes([a b])

legend(Legend);

xx = gca;
xx.YTick = [143, 194, 545];
xx.YLim = [0 545];
xx.FontSize = 22;
xx.YLabel.String = 'Number of Data';
xx.FontName = 'Times New Roman';
xx.XAxis.TickLength = [0 2];
% xx.XLim = [0.5 3.5];
barcolor1 = [255 128 10]./288;
barcolor2 = [255 255 0]./288;
barcolor3 = [99 233 10]./288;
xx.XAxis.TickLabels = {'Good','Very Good','Great'};
xx.ColorOrder =         [barcolor1
                         barcolor2
                         barcolor3
                         0.4940    0.1840    0.5560
                         0.4660    0.6740    0.1880
                         0.3010    0.7450    0.9330
                         0.6350    0.0780    0.1840];
xx.Legend.Box = 'off';

xx.YLabel.FontSize = 33;
xx.Legend.FontSize=22;
xx.XAxis.FontSize = 33;