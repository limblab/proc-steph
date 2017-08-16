% PlotJangoGainParams
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\Updates\jango_gain_params.mat')


% Get the EMGnames for each day
JangoEMGlist=Jango_SpringDays_EMGlist();

figure; hold on; MillerFigure
for day=1:9
    
    for emgInd=1:length(JangoEMGlist{day,2});
        FCRflag=strcmp(JangoEMGlist{day,2}(emgInd,:),'FCR');
        if FCRflag
            plot(emg_Iso{day}(emgInd),gain_Iso{day}(emgInd),'*m')
            plot(emg_Wm{day}(emgInd),gain_Wm{day}(emgInd),'*g')
            plot(emg_Spr{day}(emgInd),gain_Spr{day}(emgInd),'*b')
        end
        
        FCUflag=strcmp(JangoEMGlist{day,2}(emgInd,:),'FCU');
        if FCUflag
            plot(emg_Iso{day}(emgInd),gain_Iso{day}(emgInd),'om')
            plot(emg_Wm{day}(emgInd),gain_Wm{day}(emgInd),'og')
            plot(emg_Spr{day}(emgInd),gain_Spr{day}(emgInd),'ob')
        end
        
        ECRflag=strcmp(JangoEMGlist{day,2}(emgInd,:),'ECR');
        if ECRflag
            plot(emg_Iso{day}(emgInd),gain_Iso{day}(emgInd),'.m','MarkerSize',20)
            plot(emg_Wm{day}(emgInd),gain_Wm{day}(emgInd),'.g','MarkerSize',20)
            plot(emg_Spr{day}(emgInd),gain_Spr{day}(emgInd),'.b','MarkerSize',20)
        end
        
        ECUflag=strcmp(JangoEMGlist{day,2}(emgInd,:),'ECU');
        if ECUflag
            plot(emg_Iso{day}(emgInd),gain_Iso{day}(emgInd),'vm')
            plot(emg_Wm{day}(emgInd),gain_Wm{day}(emgInd),'vg')
            plot(emg_Spr{day}(emgInd),gain_Spr{day}(emgInd),'vb')
        end
        
    end
    
end
xlim([0.03 .61])
ylim([0 20])
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

neur_Iso=cellfun(@(x) x*33.3,neur_Iso,'UniformOutput',0);
neur_Spr=cellfun(@(x) x*33.3,neur_Spr,'UniformOutput',0);
neur_Wm=cellfun(@(x) x*33.3,neur_Wm,'UniformOutput',0);



figure; hold on; MillerFigure
for day=1:9
    
    for emgInd=1:length(JangoEMGlist{day,2});
        FCRflag=strcmp(JangoEMGlist{day,2}(emgInd,:),'FCR');
        if FCRflag
            plot(emg_Iso{day}(emgInd),neur_Iso{day}(emgInd),'*m')
            plot(emg_Wm{day}(emgInd),neur_Wm{day}(emgInd),'*g')
            plot(emg_Spr{day}(emgInd),neur_Spr{day}(emgInd),'*b')
        end
        
        FCUflag=strcmp(JangoEMGlist{day,2}(emgInd,:),'FCU');
        if FCUflag
            plot(emg_Iso{day}(emgInd),neur_Iso{day}(emgInd),'om')
            plot(emg_Wm{day}(emgInd),neur_Wm{day}(emgInd),'og')
            plot(emg_Spr{day}(emgInd),neur_Spr{day}(emgInd),'ob')
        end
        
        ECRflag=strcmp(JangoEMGlist{day,2}(emgInd,:),'ECR');
        if ECRflag
            plot(emg_Iso{day}(emgInd),neur_Iso{day}(emgInd),'.m','MarkerSize',20)
            plot(emg_Wm{day}(emgInd),neur_Wm{day}(emgInd),'.g','MarkerSize',20)
            plot(emg_Spr{day}(emgInd),neur_Spr{day}(emgInd),'.b','MarkerSize',20)
        end
        
        ECUflag=strcmp(JangoEMGlist{day,2}(emgInd,:),'ECU');
        if ECUflag
            plot(emg_Iso{day}(emgInd),neur_Iso{day}(emgInd),'vm')
            plot(emg_Wm{day}(emgInd),neur_Wm{day}(emgInd),'vg')
            plot(emg_Spr{day}(emgInd),neur_Spr{day}(emgInd),'vb')
        end
        
    end
    
end

xlim([0.03 .61])
ylim([0 2.5])
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

