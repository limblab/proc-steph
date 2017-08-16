dateV=[0,0.857142857142857,2.14285714285714,3.28571428571429,3.85714285714286,5,5.57142857142857,6.57142857142857,7.57142857142857,8.28571428571429,9.28571428571429,11.2857142857143,13.2857142857143,14.2857142857143,15.2857142857143,17,17.8571428571429,19,19.4285714285714];
%namesV=[{'EDCr','EDCu','Brad','ECRb','APL','ECRl','ECU','FDS1','FDS2','PT','FDP1','FCR','PL','FDP2','OP','Lum1','FDI','FDMb','FPB','ADM','Elbow Flexor','Wrist Flexor','Wrist Extensor','Finger Flexor','Finger Extensor','Thumb Extensor','Thumb Flexor','Hand Intrinsics'}];
namesV=[{'EDCr','EDCu','Brad','ECRb','APL','ECRl','ECU','FDS1','FDS2','PT','FDP','FCR','PL','FDP2','OP','Lum1','FDI','FDMb','FPB','ADM','Elbow Flexor','Wrist Flexor','Wrist Extensor','Finger Flexor','Finger Extensor','Thumb Extensor','Thumb Flexor','Hand Intrinsics'}];
FuncM=[];
SelLineMStable=[];
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
%2)  'v'
%3)  '*'
%4)  '>'
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

charList=['+v*>xsd^v><ph+o*.xsdo'];


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
 
    
for n=1:3;
    
    [r trmax]=size(SelP{n});
    Sel= [];%Sel value
    Thresh= [];%Thresh value in uC, all in us or uA
    ContColVal= [];%contact number
    charListi= [];%muscle channel for symbol
    ival=[];
    
    for tr=1:trmax;
        
        
        if n==1; %Radial
            fv=[1 3 5 6];
            mv=[3 4 6 7 1 2 5];
        elseif n==2; %Median
            fv=[2 4];
            mv=[12 13 8 9 11 14 15];
        elseif n==3; %Ulnar
            fv=[8];
            mv=[16 17 18 20];
        end
        
        for fn=fv;
            
            %Sel{fn}(tr,16,1)=0; %Selectivity value at each contact to determine most stable at PW 10, NB 5/2/2016 was NaN
            %Sel{fn}(tr,16,2)=0; %Selectivity value at each contact to determine most stable at PW 20, NB 5/2/2016 was NaN
            %Thresh{fn}(tr,16,1)= 0;%Thresh value in uC, all in us or uA at pw 10, NB 5/2/2016 was NaN
            %Thresh{fn}(tr,16,2)= 0;%Thresh value in uC, all in us or uA at pw 20, NB 5/2/2016 was NaN
            charListi{fn}(tr,1:16,1)= 21;%muscle channel for symbol at pw 10 DEFAULT if there is a 0 value 
            charListi{fn}(tr,1:16,2)= 21;%muscle channel for symbol at pw 20 DEFAULT if there is a 0 value 
            
            if length(SelP{n}{tr})>0;
                
                if fn==1;
                    isel=find(SelP{n}{tr}(:,6)==3);%All muscles for this function group
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
                            ival{fn}(c,1)=stable10(iselmx10); %pw 10
                        else ival{fn}(c,1)=0;
                        end
                        if length(stable20)>0;
                            ival{fn}(c,2)=stable20(iselmx20); %pw 20
                        else ival{fn}(c,2)=0;
                        end
                    end
                    
                elseif fn==2;
                    isel=find(SelP{n}{tr}(:,6)==12|SelP{n}{tr}(:,6)==13);%All muscles for this function group
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
                            ival{fn}(c,1)=stable10(iselmx10); %pw 10
                        else ival{fn}(c,1)=0;
                        end
                        if length(stable20)>0;
                            ival{fn}(c,2)=stable20(iselmx20); %pw 20
                        else ival{fn}(c,2)=0;
                        end
                    end
                elseif fn==3;
                    isel=find(SelP{n}{tr}(:,6)==4|SelP{n}{tr}(:,6)==6|SelP{n}{tr}(:,6)==7);%All muscles for this function group
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
                            ival{fn}(c,1)=stable10(iselmx10); %pw 10
                        else ival{fn}(c,1)=0;
                        end
                        if length(stable20)>0;
                            ival{fn}(c,2)=stable20(iselmx20); %pw 20
                        else ival{fn}(c,2)=0;
                        end
                    end
                elseif fn==4;
                    isel=find(SelP{n}{tr}(:,6)==8|SelP{n}{tr}(:,6)==9|SelP{n}{tr}(:,6)==11|SelP{n}{tr}(:,6)==14);%All muscles for this function group
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
                            ival{fn}(c,1)=stable10(iselmx10); %pw 10
                        else ival{fn}(c,1)=0;
                        end
                        if length(stable20)>0;
                            ival{fn}(c,2)=stable20(iselmx20); %pw 20
                        else ival{fn}(c,2)=0;
                        end
                    end;
                elseif fn==5;
                    isel=find(SelP{n}{tr}(:,6)==1|SelP{n}{tr}(:,6)==2);%All muscles for this function group
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
                            ival{fn}(c,1)=stable10(iselmx10); %pw 10
                        else ival{fn}(c,1)=0;
                        end
                        if length(stable20)>0;
                            ival{fn}(c,2)=stable20(iselmx20); %pw 20
                        else ival{fn}(c,2)=0;
                        end
                    end
                elseif fn==6;
                    isel=find(SelP{n}{tr}(:,6)==5);%All muscles for this function group
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
                            ival{fn}(c,1)=stable10(iselmx10); %pw 10
                        else ival{fn}(c,1)=0;
                        end
                        if length(stable20)>0;
                            ival{fn}(c,2)=stable20(iselmx20); %pw 20
                        else ival{fn}(c,2)=0;
                        end
                    end
                elseif fn==7;
                    isel=find(SelP{n}{tr}(:,6)==15);%All muscles for this function group
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
                            ival{fn}(c,1)=stable10(iselmx10); %pw 10
                        else ival{fn}(c,1)=0;
                        end
                        if length(stable20)>0;
                            ival{fn}(c,2)=stable20(iselmx20); %pw 20
                        else ival{fn}(c,2)=0;
                        end
                    end
                elseif fn==8;
                    isel=find(SelP{n}{tr}(:,6)==16|SelP{n}{tr}(:,6)==17|SelP{n}{tr}(:,6)==18|SelP{n}{tr}(:,6)==20);%All muscles for this function group
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
                            ival{fn}(c,1)=stable10(iselmx10); %pw 10
                        else ival{fn}(c,1)=0;
                        end
                        if length(stable20)>0;
                            ival{fn}(c,2)=stable20(iselmx20); %pw 20
                        else ival{fn}(c,2)=0;
                        end
                    end
                    
                end
                
                Sel{fn}(tr,[1:16],1)=0; %Added 5/2/2016
                Sel{fn}(tr,[1:16],2)=0; %Added 5/2/2016
                Thresh{fn}(tr,[1:16],1)=0; %Added 5/2/2016
                Thresh{fn}(tr,[1:16],2)=0; %Added 5/2/2016
                
                for c=1:16;
                    if ival{fn}(c,1)>0; %pw 10 has values
                        Sel{fn}(tr,c,1)=SelP{n}{tr}(ival{fn}(c,1),3);
                        Thresh{fn}(tr,c,1)= ((SelP{n}{tr}(ival{fn}(c,1),7)/1e6)*(SelP{n}{tr}(ival{fn}(c,1),5)/1e6))*1e6*1000;%Thresh value in uC, all in us or uA, pw 10
                        charListi{fn}(tr,c,1)= SelP{n}{tr}(ival{fn}(c,1),6)%muscle channel for symbol at pw 10
                    end
                    if ival{fn}(c,2)>0; %pw 20 has values
                        Sel{fn}(tr,c,2)=SelP{n}{tr}(ival{fn}(c,2),3);%Sel value
                        Thresh{fn}(tr,c,2)= ((SelP{n}{tr}(ival{fn}(c,2),7)/1e6)*(SelP{n}{tr}(ival{fn}(c,2),5)/1e6))*1e6*1000;%Thresh value in uC, all in us or uA, pw2-
                        charListi{fn}(tr,c,2)= SelP{n}{tr}(ival{fn}(c,2),6)%muscle channel for symbol at pw 20
                    end
                end
            end
            
        end
        
    end
    
    
    NerveV{1}='Median Nerve';
    NerveV{2}='Radial Nerve';
    NerveV{3}='Ulnar Nerve';
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
    for fn=fv;
        %subplot(2,4,fn)
        if fn==2|fn==4; %Removed 7 since no thumb flexor was selective
            %Median
            subplot(2,3,1)
            
                    title({'Median Nerve', 'Stable Contact Threshold'})
        ylabel('Threshold (nC)')
        xlabel('Weeks Post Implant')
        axis([0 15 0 60])
        axis square
        %set(findall(gcf,'-property','FontSize'),'FontSize',16)
        set(gca,'XTick',[0:5:15])
            %Thresh
            

 

        elseif fn==1|fn==3|fn==5|fn==6;
            %Radial 
            subplot(2,3,2)
            
                    title({'Radial Nerve', 'Stable Contact Threshold'})
        ylabel('Threshold (nC)')
        xlabel('Weeks Post Implant')
        axis([0 27 0 60])
        %axis square
        %set(findall(gcf,'-property','FontSize'),'FontSize',16)
                set(gca,'XTick',[0:5:15])
                

         
        elseif fn==8;
            %Ulnar
            subplot(2,3,3)
            
        title({'Ulnar Nerve', 'Stable Contact Threshold'})
        ylabel('Threshold (nC)')
        xlabel('Weeks Post Implant')
        axis([0 15 0 60])
        axis square
        %set(findall(gcf,'-property','FontSize'),'FontSize',16)
                set(gca,'XTick',[0:5:15])
                

 
        end
        
        %Need to ignore first set since some acute spikes in selectivity at
        %the beginning of the implant
        Sel{fn}(1,:,1)=NaN; %First session at pw 10, was a 0, NB 5/2/2016
        Sel{fn}(1,:,2)=NaN; %First session at pw 20, was a 0, NB 5/2/2016
        
        Thresh{fn}(1,:,1)=NaN; %First session at pw 10, was a 0, NB 5/2/2016
        Thresh{fn}(1,:,2)=NaN; %First session at pw 20, was a 0, NB 5/2/2016
        
        EMGmeanpw=nanmean(Sel{fn});
        EMGmeanpwR=reshape(EMGmeanpw,16,2);
        SelLineMax=max(max(EMGmeanpwR)); %Only plotting the muscle with the highest max
        [c p]=find(EMGmeanpwR==SelLineMax);
        c=c(1);
        p=p(1);
        
        SelLine=Sel{fn}(:,c,p);%Sel value;
        SelLine(Sel{fn}(:,c,p)==0)=NaN; %was [], NB 5/2/2016
        
        ThreshLine=Thresh{fn}(:,c,p);%Thresh value;
        ThreshLine(Thresh{fn}(:,c,p)==0)=NaN; %was [], NB 5/2/2016
        dateLine=dateV(1:14);
        %dateLine(isnan(Thresh{fn}(:,c,p))==1)=[]; %Was not commented, NB 5/2/2016
        
        hold on
        if length(dateLine)>0;
            if mean(ThreshLine>0)
                ThreshLine(find(ThreshLine==0))=NaN;
            plot(dateLine,ThreshLine,LS{fn},'Color',ContCol(c,:),'LineWidth',LSize{fn})
            end
        end
        
        
        if fn==2|fn==4; %Removed 7 since no thumb flexor was selective
            %Median
            subplot(2,3,4)
        title({'Median Nerve', 'Stable Contact Selectivity'})    
        ylabel('Normalized EMG Selectivity')
        xlabel('Weeks Post Implant')
        axis([0 15 0 1])
        axis square
       % set(findall(gcf,'-property','FontSize'),'FontSize',16)
            

 

        elseif fn==1|fn==3|fn==5|fn==6;
            %Radial 
            subplot(2,3,5)
            title({'Radial Nerve', 'Stable Contact Selectivity'})    
        ylabel('Normalized EMG Selectivity')
        xlabel('Weeks Post Implant')
        axis([0 15 0 1])
        axis square
       % set(findall(gcf,'-property','FontSize'),'FontSize',16)
                

         
        elseif fn==8;
            %Ulnar
            subplot(2,3,6)
          
        title({'Ulnar Nerve', 'Stable Contact Selectivity'})        
        ylabel('Normalized EMG Selectivity')
        xlabel('Weeks Post Implant')
        axis([0 15 0 1])
        axis square
       % set(findall(gcf,'-property','FontSize'),'FontSize',16)
                

 
        end
        
                hold on
        if length(dateLine)>0;
            if mean(SelLine>0)
                SelLine(find(SelLine==0))=NaN;
            plot(dateLine,SelLine,LS{fn},'Color',ContCol(c,:),'LineWidth',LSize{fn})
            SelLineMStable(end+1,:)=SelLine';
            FuncM{end+1,1}=namesV{fn+20};
            end
        end
        
        cV(fn)=c;
        pV(fn)=p;
        

    end
    
    
    for tr=1:14;
        
        
        for fn=fv;
            c=cV(fn);
            p=pV(fn);
            %subplot(2,4,fn)
        if fn==2|fn==4|fn==7;
            %Median
            subplot(2,3,1)
        elseif fn==1|fn==3|fn==5|fn==6;
            %Radial 
            subplot(2,3,2)
        elseif fn==8;
            %Ulnar
            subplot(2,3,3)
        end
            hold on
            %if Thresh{fn}(tr,c,p)>0;
            %if charListi{fn}(tr,c,p)~=21;
            if Thresh{fn}(tr,c,p)>0; %NB 5/2/2016
            scatter(dateV(tr),Thresh{fn}(tr,c,p),100,charList(charListi{fn}(tr,c,p)),'MarkerFaceColor',ContCol(c,:),'MarkerEdgeColor',ContCol(c,:))
            end
            %elseif charListi{fn}(tr,c,p)==21;
            %scatter(dateV(tr),Thresh{fn}(tr,c,p),30,charList(charListi{fn}(tr,c,p)),'k','filled')%'MarkerFaceColor',ContCol(c,:),'MarkerEdgeColor',ContCol(c,:)) %BLACK filled if zero value   
            %end
            
            
                    if fn==2|fn==4|fn==7;
            %Median
            subplot(2,3,4)
        elseif fn==1|fn==3|fn==5|fn==6;
            %Radial 
            subplot(2,3,5)
        elseif fn==8;
            %Ulnar
            subplot(2,3,6)
        end
            hold on

%plotting 0.2 thresh line, NB 5/2/2016
plot([0 15],[0.2 0.2],'k:')

            %if charListi{fn}(tr,c,p)~=21;
            if Sel{fn}(tr,c,p)>0; %NB 5/2/2016
            scatter(dateV(tr),Sel{fn}(tr,c,p),100,charList(charListi{fn}(tr,c,p)),'MarkerFaceColor',ContCol(c,:),'MarkerEdgeColor',ContCol(c,:))
            
            end
            %elseif charListi{fn}(tr,c,p)==21;
            %scatter(dateV(tr),Sel{fn}(tr,c,p),30,charList(charListi{fn}(tr,c,p)),'k','filled')%'MarkerFaceColor',ContCol(c,:),'MarkerEdgeColor',ContCol(c,:)) %BLACK filled if zero value   
            %end
            
%             if p==1;
%                 scatter(dateV(tr),Thresh{fn}(tr,c,p),100,charList(charListi{fn}(tr,c,p)),'MarkerEdgeColor','m') %pw 10 so can change outline if you want
%             elseif p==2
%                 scatter(dateV(tr),Thresh{fn}(tr,c,p),100,charList(charListi{fn}(tr,c,p)),'MarkerEdgeColor','c') %pw 20 so can change outline if you want
%             end            
            




        end
    end
    
end

    for s=1:3;
        p=[];
        if s==2;
            fv=[1 3 5 6];
            mv=[1:6];
        elseif s==1;
            fv=[2 4];
            mv=[12 13 11];
        elseif s==3;
            fv=[8];
            mv=[20];    
        end
subplot(2,3,s)

        for mm=mv;
            hold on
            p(end+1)=scatter(-1,-1,strcat('k',charList(mm)))
        end
        
        for ff=fv;
            hold on
            p(end+1)=plot(-1,-1,strcat(LS{ff},'k'),'LineWidth',LSize{ff})
        end
        
        

        if s==1|s==3;
        legend(p,namesV([mv fv+20]),'Location','north')
        legend boxoff
        elseif s==2;
        legend(p,namesV([mv fv+20]),'Location','east')
        legend boxoff
        end

    end
    
 