dateV=[0,0.857142857142857,2.14285714285714,3.28571428571429,3.85714285714286,5,5.57142857142857,6.57142857142857,7.57142857142857,8.28571428571429,9.28571428571429,11.2857142857143,13.2857142857143,14.2857142857143,15.2857142857143,17,17.8571428571429,19,19.4285714285714];
%namesV=[{'EDCr','EDCu','Brad','ECRb','APL','ECRl','ECU','FDS1','FDS2','PT','FDP1','FCR','PL','FDP2','OP','Lum1','FDI','FDMb','FPB','ADM','Elbow Flexor','Wrist Flexor','Wrist Extensor','Finger Flexor','Finger Extensor','Thumb Extensor','Thumb Flexor','Hand Intrinsics'}];
namesV=[{'EDCr','EDCu','Brad','ECRb','APL','ECRl','ECU','FDS','FDS2','PT','FDP','FCR','PL','FDP2','OP','Lum1','FDI','FDMb','FPB','ADM','Elbow Flexor','Wrist Flexor','Wrist Extensor','Finger Flexor','Finger Extensor','Thumb Extensor','Thumb Flexor','Hand Intrinsics'}];
SelLineMax=[];
%Contacts will be color scale from 1 to 16 with near colors similar
%Lines will be function
%Symbols will be specific muscles
%Done for both sel and thresholds at that value
%Best Sel value per day
%Up to 15 weeks (tr<=14)

%Function muscle groups
%1) Elbow Flexor (3)
%2) Wrist Flexor (12,13)
%3) Wrist Extensor (4,6,7)
%4) Finger Flexor (8,9,11,14)
%5) Finger Extensor (1,2)
%6) Thumb Extensor (5)
%7) Thumb Flexor (15)
%8) Hand Intrinsics (16,17,18,20)

%Function (2 will be further edited in illustrator to make 6 unique lines- matlab only has 4 unique lines)
%Each muscle will have own marker:
%1)  '+'
%2)  'o'
%3)  '*'
%4)  '.'
%5)  'x'
%6)  's'
%7)  'd'
%8)  '^'
%9)  'v'
%10)  '>'
%11)  '<'
%12)  'p'
%13)  'h'
%14)  '+'
%15)  'o'
%16)  '*'
%17)  '.'
%18)  'x'
%19)  's'
%20)  'd'

charList=['+o*.xsd^v><ph+o*.xsd'];


LS{1}='-';
LS{2}='--';
LS{3}=':';
LS{4}='-.';
LS{5}='-';
LS{6}='--';
LS{7}=':';
LS{8}=':';

LSize{1}=1;
LSize{2}=1;
LSize{3}=1;
LSize{4}=1;
LSize{5}=2;
LSize{6}=2;
LSize{7}=2;
LSize{8}=3;

%Contact color set:
cmap=colormap(jet);
ContCol=cmap([1:4:64],:);

%SelP
%1) Stim value for 2nd muscle stim
%2) Value of second largest EMG (0.2)
%3) Selectivity Value
%4) Active Channel
%5) Static Value of stim
%6) Muscle Channel number of selective muscle
%7) Stimulation value at threshold of active muscle
%8) ModVal (2 is PWM and 3 is PAM)
%9) Active chan order (seli)


%load('C:\Users\Natalie\Desktop\NHPINVIVO\Figures\DataAnalysis\RECSelvarRight.mat')
%Best in each day

%Function muscle groups
%1) Elbow Flexor (3)
%2) Wrist Flexor (12,13)
%3) Wrist Extensor (4,6,7)
%4) Finger Flexor (8,9,11,14)
%5) Finger Extensor (1,2)
%6) Thumb Extensor (5)
%7) Thumb Flexor (15)
%8) Hand Intrinsics (16,17,18,20)
figure
countm=0;
for n=1:3;
    
    [r trmax]=size(SelP{n});
    Sel= [];%Sel value
    Thresh= [];%Thresh value in uC, all in us or uA
    ContColVal= [];%contact number
    charListi= [];%muscle channel for symbol
    ival=[];
    
    for tr=9:trmax;
        
        
        if n==1; %Radial
            fv=[1 3 5 6];
            mv=[3 4 6 7 1 2 5];
        elseif n==2; %Median
            fv=[2 4 7];
            mv=[12 13 8 9 11 14 15];
        elseif n==3; %Ulnar
            fv=[8];
            mv=[16 17 18 20];
        end
        
        for mn=mv; %This analysis looks for the best selectivity for each muscle
            
            Sel{mn}(tr,16,1)=NaN; %Selectivity value at each contact to determine most stable at PW 10
            Sel{mn}(tr,16,2)=NaN; %Selectivity value at each contact to determine most stable at PW 20
            Thresh{mn}(tr,16,1)= NaN;%Thresh value in uC, all in us or uA at pw 10
            Thresh{mn}(tr,16,2)= NaN;%Thresh value in uC, all in us or uA at pw 20
            charListi{mn}(tr,1:16,1)= 1;%muscle channel for symbol at pw 10
            charListi{mn}(tr,1:16,2)= 1;%muscle channel for symbol at pw 20
            
            if length(SelP{n}{tr})>0;
                
                
                isel=find(SelP{n}{tr}(:,6)==mn);%All muscles for this muscle
                for c=1:16;
                    iselc=find(SelP{n}{tr}(isel,4)==c); %find contact of interest
                    isel10=find(SelP{n}{tr}(isel(iselc),5)==10); %find pw 10 at contact of interest
                    isel20=find(SelP{n}{tr}(isel(iselc),5)==20); %find ow 20 at contact of interest
                    stable10=isel(iselc(isel10));
                    stable20=isel(iselc(isel20));
                    %Take max for contact of interest at each pw for
                    %the function of interest
                    iselmx10=find(max(SelP{n}{tr}(stable10,3))==SelP{n}{tr}(stable10,3));
                    iselmx20=find(max(SelP{n}{tr}(stable20,3))==SelP{n}{tr}(stable20,3));
                    if length(stable10)>0;
                        ival{mn}(tr,c,1)=stable10(iselmx10); %pw 10
                    else ival{mn}(tr,c,1)=0;
                    end
                    if length(stable20)>0;
                        ival{mn}(tr,c,2)=stable20(iselmx20); %pw 20
                    else ival{mn}(tr,c,2)=0;
                    end
                    if ival{mn}(tr,c,1)>0; %pw 10 has values
                        Sel{mn}(tr,c,1)=SelP{n}{tr}(ival{mn}(tr,c,1),3);
                        Thresh{mn}(tr,c,1)= ((SelP{n}{tr}(ival{mn}(tr,c,1),7)/1e6)*(SelP{n}{tr}(ival{mn}(tr,c,1),5)/1e6))*1e6*1000;%Thresh value in uC, all in us or uA, pw 10
                        charListi{mn}(tr,c,1)= SelP{n}{tr}(ival{mn}(tr,c,1),6)%muscle channel for symbol at pw 10
                    end
                    if ival{mn}(tr,c,2)>0; %pw 20 has values
                        Sel{mn}(tr,c,2)=SelP{n}{tr}(ival{mn}(tr,c,2),3);%Sel value
                        Thresh{mn}(tr,c,2)= ((SelP{n}{tr}(ival{mn}(tr,c,2),7)/1e6)*(SelP{n}{tr}(ival{mn}(tr,c,2),5)/1e6))*1e6*1000;%Thresh value in uC, all in us or uA, pw2-
                        charListi{mn}(tr,c,2)= SelP{n}{tr}(ival{mn}(tr,c,2),6)%muscle channel for symbol at pw 20
                    end
                    
                end
            end
            
        end
        
    end
    
    
    
    
    NerveV{1}='Radial ';
    NerveV{2}='Median ';
    NerveV{3}='Ulnar ';
    %Thresh
    %     for mm=mv;
    %         hold on
    %         scatter(-1,-1,strcat(charList(mm),'k'))
    %     end
    %
    %     for ff=fv;
    %         hold on
    %         plot(-1,-1,strcat(LS{ff},'k'),'LineWidth',LSize{ff})
    %     end
    %
    %     legend(namesV{[mv fv+12]},'Location','eastoutside')
    
    cV=[];
    pV=[];
    
    for mn=mv;
        
        
        
        trvec=[9:14];
        %Need to ignore first set since some acute spikes in selectivity at
        %the beginning of the implant
        %Sel{mn}(1,:,1)=0; %First session at pw 10 removed 5/23/16 since
        %not starting on first trial
        %Sel{mn}(1,:,2)=0; %First session at pw 20 removed 5/23/16 since
        %not starting on first trial
        
        EMGmeanpw=nanmean(Sel{mn}(trvec,:,:)); %added nanmean 5/23/16
        EMGmeanpwR=reshape(EMGmeanpw,16,2);
        SelLineMax(end+1)=max(max(max(Sel{mn}(trvec,:,:)))); %Only plotting the muscle with the highest max
        SelLineMEANMax=max(max(EMGmeanpw));
        [c p]=find(EMGmeanpwR==SelLineMEANMax);
        c=c(1);
        p=p(1);
        
        pwvec=[10 20];
        pwidth=pwvec(p);
        
        Targetmn=mn;%Seli, order of selective muscle in rec curve
        
        countt=0;
        TableInfo{mn}=[];
        
        if mn==2;
            check='c'
        end

        if SelLineMEANMax>=.3; %Sel occured at least one time above this value, was SelLineMax(end) but changed on 5/23/16 to SelLineMEANMax
            for tr=trvec;
                
                TableInfo{mn}(tr-8,:)=nan(1,4);
                ivalStable=find(SelP{n}{tr}(:,4)==c & SelP{n}{tr}(:,5)==pwidth)% All stim that is the pw and contact of interest, 5/14/2016
                
                if length(ivalStable)>0;
                    
                    EMGvec=SelP{n}{tr}(ivalStable,end-31:end);
                    [EMGvecS veci]=sort(EMGvec,2,'descend');
                    [r OrderF1]=find(veci==Targetmn);
                    OrderF=100-OrderF1(1); %The larger the value, the better
                    ivalStable=ivalStable(find(EMGvec(:,Targetmn).*OrderF==max(EMGvec(:,Targetmn).*OrderF)));
                    
                    %if ival{mn}(tr,c,p)>0;
                    
                    countt=countt+1;
                    TableInfo{mn}(tr-8,:)=[c pwvec(p) OrderF1(1) EMGvecS(OrderF1(1))];
                    %mnorder=SelP{n}{tr}(ivalStable,9)
                    mnorder=find(RecCh{n}{tr}{ivalStable}==Targetmn);
                    RecLine(countt,:)=RecP{n}{tr}{ivalStable}(mnorder,:);
                    StimLine(countt,:)=Rect{n}{tr}{ivalStable};
                    
                    
                end
            end
            %end
        end

    
    if countt>=3;
        countm=countm+1;
        subplot(2,4,countm)
        meanRec=mean(RecLine);
        stdRec=std(RecLine);
        
        RecLineM{countm}=RecLine;
        StimLineM{countm}=StimLine;
        
        stimp2mean=find(abs(meanRec-.2)==min(abs(meanRec-.2)));
        Recvals=RecLine(:,stimp2mean);
        TableInfo{mn}(:,5)=Recvals;
        TableInfo{mn}(:,7)=repmat(StimLine(stimp2mean),6,1);
        
        stimp5mean=find(abs(meanRec-.5)==min(abs(meanRec-.5)));
        Recvals=RecLine(:,stimp5mean);
        TableInfo{mn}(:,6)=Recvals;
        TableInfo{mn}(:,8)=repmat(StimLine(stimp5mean),6,1);
        
        
        hold on
        plot(StimLine/1000,meanRec,'-','Color',ContCol(c,:),'LineWidth',2)
        plot(StimLine/1000,meanRec+stdRec,':','Color',ContCol(c,:),'LineWidth',2) %1 std above
        plot(StimLine/1000,meanRec-stdRec,':','Color',ContCol(c,:),'LineWidth',2) %1 std below
        
        if p==1;
            title(strcat(NerveV{n},', ',' ',namesV{mn}))
        elseif p==2;
            title(strcat(NerveV{n},', ',' ',namesV{mn}))
        end
        
        ylabel('Normalized EMG')
        xlabel('Pulse Amplitude (mA)')
        axis([0 3 0 1])
        axis square
        set(findall(gcf,'-property','FontSize'),'FontSize',16)
        
    end
    
    counttrials{n}(mn)=countt;
    
end

end




