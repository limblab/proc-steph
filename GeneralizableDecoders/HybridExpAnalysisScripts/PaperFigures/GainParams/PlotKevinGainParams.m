%PlotKevinGainParams
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\Updates\kevin_gain_params.mat')

% Get the EMGnames for each day
KevinEMGlist=Kevin_HybridData_EMGQualityInfo();

figure; hold on; MillerFigure
for day=1:5
    
    for emgInd=1:length(KevinEMGlist{day,2});
        FCRflag=strcmp(KevinEMGlist{day,2}(emgInd,:),'FCR');
        if FCRflag
            plot(emg_Iso(day,emgInd),gain_Iso(day,emgInd),'*m')
            plot(emg_Wm(day,emgInd),gain_Wm(day,emgInd),'*g')
            plot(emg_Spr(day,emgInd),gain_Spr(day,emgInd),'*b')
        end
        
        FCUflag=strcmp(KevinEMGlist{day,2}(emgInd,:),'FCU');
        if FCUflag
            plot(emg_Iso(day,emgInd),gain_Iso(day,emgInd),'om')
            plot(emg_Wm(day,emgInd),gain_Wm(day,emgInd),'og')
            plot(emg_Spr(day,emgInd),gain_Spr(day,emgInd),'ob')
        end
        
        ECRflag=strcmp(KevinEMGlist{day,2}(emgInd,:),'ECR');
        if ECRflag
            plot(emg_Iso(day,emgInd),gain_Iso(day,emgInd),'.m','MarkerSize',20)
            plot(emg_Wm(day,emgInd),gain_Wm(day,emgInd),'.g','MarkerSize',20)
            plot(emg_Spr(day,emgInd),gain_Spr(day,emgInd),'.b','MarkerSize',20)
        end
        
        ECUflag=strcmp(KevinEMGlist{day,2}(emgInd,:),'ECU');
        if ECUflag
            plot(emg_Iso(day,emgInd),gain_Iso(day,emgInd),'vm')
            plot(emg_Wm(day,emgInd),gain_Wm(day,emgInd),'vg')
            plot(emg_Spr(day,emgInd),gain_Spr(day,emgInd),'vb')
        end
        
    end
    
end
xlim([0.03 0.7])
% Plot line through all the data
h = gcf; %current figure handle
axesObjs = get(h, 'Children');  %axes handles
dataObjs = get(axesObjs, 'Children');
xdata = get(dataObjs, 'XData');  xdata=cell2mat(xdata);
ydata = get(dataObjs, 'YData'); ydata=cell2mat(ydata);
X = [ones(length(xdata),1) xdata];
b = X\ydata;
yPrime = X*b;
plot(xdata,yPrime,'k-')





%% Neural gain

neur_Iso=neur_Iso*33.3;
neur_Spr=neur_Spr*33.3;
neur_Wm=neur_Wm*33.3;


figure; hold on; MillerFigure
for day=1:5
    
    for emgInd=1:length(KevinEMGlist{day,2});
        FCRflag=strcmp(KevinEMGlist{day,2}(emgInd,:),'FCR');
        if FCRflag
            plot(emg_Iso(day,emgInd),neur_Iso(day,emgInd),'*m')
            plot(emg_Wm(day,emgInd),neur_Wm(day,emgInd),'*g')
            plot(emg_Spr(day,emgInd),neur_Spr(day,emgInd),'*b')
        end
        
        FCUflag=strcmp(KevinEMGlist{day,2}(emgInd,:),'FCU');
        if FCUflag
            plot(emg_Iso(day,emgInd),neur_Iso(day,emgInd),'om')
            plot(emg_Wm(day,emgInd),neur_Wm(day,emgInd),'og')
            plot(emg_Spr(day,emgInd),neur_Spr(day,emgInd),'ob')
        end
        
        ECRflag=strcmp(KevinEMGlist{day,2}(emgInd,:),'ECR');
        if ECRflag
            plot(emg_Iso(day,emgInd),neur_Iso(day,emgInd),'.m','MarkerSize',20)
            plot(emg_Wm(day,emgInd),neur_Wm(day,emgInd),'.g','MarkerSize',20)
            plot(emg_Spr(day,emgInd),neur_Spr(day,emgInd),'.b','MarkerSize',20)
        end
        
        ECUflag=strcmp(KevinEMGlist{day,2}(emgInd,:),'ECU');
        if ECUflag
            plot(emg_Iso(day,emgInd),neur_Iso(day,emgInd),'vm')
            plot(emg_Wm(day,emgInd),neur_Wm(day,emgInd),'vg')
            plot(emg_Spr(day,emgInd),neur_Spr(day,emgInd),'vb')
        end
        
    end
    
end

% Plot line through all the data
h = gcf; %current figure handle
axesObjs = get(h, 'Children');  %axes handles
dataObjs = get(axesObjs, 'Children');
xdata = get(dataObjs, 'XData');  xdata=cell2mat(xdata);
ydata = get(dataObjs, 'YData'); ydata=cell2mat(ydata);
X = [ones(length(xdata),1) xdata];
b = X\ydata;
yPrime = X*b;
plot(xdata,yPrime,'k-')
xlim([0.03 0.7])
