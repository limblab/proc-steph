%clear all
%This handles redundant muscle by ignoring similar muscles
colm=['rrgbymckrrgbymck'];
ts=['030513';'031113';'032013';'032813';'040413';'041213';'041613';'042313';'043013';'050713';'051413';'052813';'061413';'062113';'062813';'071213';'071813';'072613';'080113'];
ns=['R';'M';'U'];
for n=2:2; %two nerves (Important for file path)
    for tr=2:2%4; %Order of date in ts vector, (Important for file path)
        
        if n==1;
            pathname=strcat('C:\Users\Natalie\Desktop\NHPINVIVO\Data\ChronicNHPDATA\Right\Radial\',ts(tr,:),'\SC');
        elseif n==2;
            pathname=strcat('C:\Users\Natalie\Desktop\NHPINVIVO\Data\ChronicNHPDATA\Right\Median\',ts(tr,:),'\SC');
        elseif n==3;
            pathname=strcat('C:\Users\Natalie\Desktop\NHPINVIVO\Data\ChronicNHPDATA\Right\Ulnar\',ts(tr,:),'\SC');
        end
        filenames=dir(pathname);
        
        EMGSel=[];
        ActiveCh=[];
        staticvalue=[];
        EMGvalnew2=[];
        ModValvec=[];
        
        
        for f=1:(length(filenames)-2); %number of files for this date (ts number and in the nerve n)
            cd(pathname)
            load(filenames(f+2).name)
            f
            
            StimValsF{f}=StimVals;
            RecordingChannelsF{f}=handles.RecordingChannels;
            ActiveCh(f)=handles.RecruitCh;
            staticvalue(f)=handles.StaticVal;
            ModValvec(f)=handles.ModVal;
            
            %%%%%%%%%%PROCESSING RAW TWICTHES AND REMOVING NOISE
            [rr cc]=size(rawtwitch);
            EMGvalnew2{f}=zeros(20,length(StimVals));
            if rr==600*4*length(StimVals);
                
                for i=1:length(handles.RecordingChannels);
                    m=handles.RecordingChannels(i);
                    datatempS=rawtwitch(:,m)';
                    datatempV=reshape(datatempS(1:600*4*length(StimVals)),600*handles.EMGave,length(StimVals));
                    for j=1:length(StimVals);
                        datatempR=datatempV(:,j)';
                        datatempJ=reshape(datatempR,600,handles.EMGave);
                        countr=0;
                        for r=1:handles.EMGave;
                            
                            datatemp=datatempJ(:,r);
                            checknoise=abs([datatemp(7)]);% datatemp(40:50)]);
                            maxP=max(datatemp(8:50));
                            if length(find(checknoise>.002))>0;
                                                            subplot(1,2,1)
                                                            hold on
                                                            plot(datatemp(8:80),colm(m-7))
                                                            title('Noise')
                            else
                                                            subplot(1,2,2)
                                                            hold on
                                                            plot(datatemp(8:80),colm(m-7))
                                                            title('Signal')
                                
%                                                                     clf
%                                                                  plot(datatemp(1:200))
%                                                                  hold on
%                                                                  plot([8 8],[min(datatemp) max(datatemp)],'k','LineWidth',2) 
%                                                                  plot([30 30],[min(datatemp) max(datatemp)],'k','LineWidth',2) 
%                                                                  title(handles.EMGnames{handles.RecordingChannels(i)})
%                                                                  pause(.1)
                                                                 
                                countr=countr+1;
                                EMGvaltemp(countr)=max(datatemp(8:30))-min(datatemp(8:30));%WAS 80 end,max(cumsum(abs(datatemp(8:50))))/handles.maxVals(i); %CHANGED to peak to peak values
                                
                            end
                        end
                        EMGvalnew2{f}(m,j)=mean(EMGvaltemp);
                        EMGvaltemp=[];
                    end
                end
            end
        end
        %%%%%%%%%%END PROCESSING RAW TWICTHES AND REMOVING NOISE
        EMGvalnew2AllF=EMGvalnew2;
        EMGvalnew2=[];
        maxvals=max(cell2mat(EMGvalnew2AllF),[],2); %normalized for each muscle using peak to peak
        chanloc=find(maxvals>0);
        
        %ANALYSIS per set of files
        %EMGvalnew2AllF has a file set per cell. In each cell is EMGval and StimVal where rows are muscles and columns are stimulation values corresponding to SimVals (similar binary search order from Polasek)
        
        for f=1:length(EMGvalnew2AllF); %CALCULATING SELECTIVITY for each EMGval (now EMGvalnew2) and StimVals
            f
            EMGvalnew2=[];
            [fr fc]=size(EMGvalnew2AllF{f});
            %NEED TO NORMALIZE TO PEAK TO PEAK, ran through all files
            mv=RecordingChannelsF{f};
            EMGvalnew2(1:length(mv),:)=EMGvalnew2AllF{f}(intersect(chanloc,mv),:)./repmat(maxvals(intersect(chanloc,mv)),1,fc); %normalized for each muscle using peak to peak, CHANGED index of chanloc to length(mv)
            
            StimVals=StimValsF{f};
            [vi si]=sort(StimVals,'ascend');
            Stimsort=StimVals(si);
            EMGsort=EMGvalnew2(:,si); %Now in pulse strength order from small to large
            
            t=linspace(Stimsort(1),Stimsort(end),200); %Increasing the recruitment curve resolution at higher sampled stimulation values
            
            p=[];
            threshi=[];
            selval=.2; %This is the value of the second largest EMG to take selectivity value (was .1)
            for mm=1:length(RecordingChannelsF{f});

                p(mm,:) = pchip(Stimsort,EMGsort(mm,:),t); 
                [minV threshi(mm)]=min(abs(p(mm,:)-selval));
                
                %Determining threshold for target muscle (mm) at 0.2
                seli=mm;
                selm=threshi(mm);
                chargep2=NaN;
                
                if p(seli,end)>.2
                pMuscle=[p(seli,max(1,selm-1)) p(seli,selm) p(seli,min(selm+1,length(t)))];
                if all(diff(pMuscle)>0)==1; % checks if monotonic increasing
                    stimp1=interp1([p(seli,max(1,selm-1)) p(seli,selm) p(seli,min(selm+1,length(t)))],[t(max(1,selm-1)) t(selm) t(min(selm+1,length(t)))],.2)
                    
                elseif all(diff(pMuscle)>0)==0;
                    stimp1=t(selm); %The stim parameter is at a boundary so it is at its max
                end
                chargep2=(stimp1/1e6)*(staticvalue(f)/1e6)*1e6*1000; %nC
                end

                ThreshCell{n}{tr}{f,1}(mm,1)=RecordingChannelsF{f}(mm);
                ThreshCell{n}{tr}{f,1}(mm,2)=chargep2;
                ThreshCell{n}{tr}{f,1}(mm,3)=ActiveCh(f);
            end
            
            [selm seli]=min(threshi);
            
            %Default Sel is 0 if there is no active channel (selective channel is <.2)
            EMGSel(f,RecordingChannelsF{f})=0;
            
            %% Ignoring the redundant channel based on what the selective (WILL BE DIFFERENT FOR ACUTE DATA)
            %muscle index is, seli
            if n==1; %radial, 'EDCr'    'EDCu'    'BRad'    'ECRb'    'APL'    'ECRl'    'ECU'
                if seli==1; %this is EDCr so ignore EDCu channel
                    threshi(2)=10000;
                elseif seli==2; %this is EDCu so ignore EDCr channel
                    threshi(1)=10000;
                end
                
            elseif n==2; %median, 'FDS1'    'FDS2'    'PT'    'FDP1'    'FCR'    'PL'    'FDP2'    'OP'
                
                if mm==1; %this is FDS1 so ignore FDS2 channel
                    threshi(2)=10000;
                elseif mm==2; %this is FDS2 so ignore FDS1 channel
                    threshi(1)=10000;
                elseif mm==4; %this is FDP1 so ignore FDS2 channel
                    threshi(7)=10000;
                elseif mm==7; %this is FDS2 so ignore FDS1 channel
                    threshi(4)=10000;
                end
                
            end
            %%
            
            threshi(seli)=10000; %dont want selective muscle included in min search
            [selmnext selinext]=min(threshi);
            
            %SelP{n}{tr}(f,:)=[0 0 0 ActiveCh(f) staticvalue(f) 0 0 0 0];
            %JUST COMMENTED THIS 5/1/2016
            
            %if p(seli,selmnext)>0; %CHANGED TO ZERO SO THAT CAN PLOT ACTUAL VALUE EVEN IF IT IS BELOW 0.2
                pNextMuscle=[p(selinext,max(1,selmnext-1)) p(selinext,selmnext) p(selinext,min(selmnext+1,length(t)))];
                
                if all(diff(pNextMuscle)>0)==1; % checks if monotonic increasing
                    stimp2=interp1([p(selinext,max(1,selmnext-1)) p(selinext,selmnext) p(selinext,min(selmnext+1,length(t)))],[t(max(1,selmnext-1)) t(selmnext) t(min(selmnext+1,length(t)))],.2)
                    neigh=interp1(t,p(selinext,:),stimp2);
                elseif all(diff(pNextMuscle)>0)==0;
                    stimp2=t(selmnext); %The stim parameter is at a boundary so it is at its max
                    neigh=interp1(t,p(selinext,:),stimp2);
                end
                
                %Determining threshold for target muscle at 0.2
                pMuscle=[p(seli,max(1,selm-1)) p(seli,selm) p(seli,min(selm+1,length(t)))];
                if all(diff(pMuscle)>0)==1; % checks if monotonic increasing
                    stimp1=interp1([p(seli,max(1,selm-1)) p(seli,selm) p(seli,min(selm+1,length(t)))],[t(max(1,selm-1)) t(selm) t(min(selm+1,length(t)))],.2)
                    
                elseif all(diff(pMuscle)>0)==0;
                    stimp1=t(selm); %The stim parameter is at a boundary so it is at its max
                end
                
                EMGselVal=interp1(t,p(seli,:),stimp2); %stimp2 is Stimulation parameter at .2 of next muscle at the selective muscle, seli
                EMGSel(f,mv(seli))=EMGselVal; %Corresponds to correct channel value
                
                EMGtemp=[];
                EMGvec=zeros(1,32);
                for mi=1:length(mv);
                    EMGtemp(mi)=interp1(t,p(mi,:),stimp2);
                end
                EMGvec(mv)=EMGtemp; %Always the same size adn values at the recorded channel locations (5/15/2016)
                
                %if abs(neigh-.2)<.01; %Neighbor muscle is close to 0.2
                %%CHECKING WHY THERE ARE STILL ZEROS NB 5/1/2016
                SelP{n}{tr}(f,:)=[stimp2 neigh EMGselVal ActiveCh(f) staticvalue(f) mv(seli) stimp1 ModValvec(f) seli EMGvec]; %[Stimulation value of target, value of second larget EMG (should be .2), the selectivity value, active channel, static stim param value, muscle channel, stim value at sel, Modulation type, active chan order]
                RecCh{n}{tr}{f}=mv;
                %end
            %end
            
        RecP{n}{tr}{f}=p; %Can go back and check recruitment curves from each file set
        Rect{n}{tr}{f}=t; %Can go back and check highly sampled stim values from each file set
            
        end
        
        ThreshC{n}{tr}=cell2mat(ThreshCell{n}{tr});
        P2PMAll{n}{tr}=EMGSel; %All the EMG selectivity values in each experimental date, tr
    end
    
   
    
end

clearvars -except P2PMAll Rect RecP SelP ThreshC RecCh






