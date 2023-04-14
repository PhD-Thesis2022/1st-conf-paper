'KDDTrain+_20Percent KDDTest-21'
%app = load_prdataset('KDDTrain+.dat',42,42,1,41);
app = load_prdataset('KDDTrain+_20Percent.dat',42,42,1,41);
%app=iris;
appData = app.data;

for i = 1 : getsize(app,2)
    %ax1 = subplot(6,10,i); % top subplot
    
    
   % title(ax1,'Top Subplot')
    
    for j = 1 : getsize(app,3)
        [f,xi]=ksdensity(appData(getnlab(app)==j,i));
     %   ylabel(ax1,i)
     figure(i)
        plot(xi,f)
        
        hold on;

    end
    hold off;
end