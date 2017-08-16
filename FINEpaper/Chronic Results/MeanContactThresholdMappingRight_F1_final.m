dateV=[0,0.857142857142857,2.14285714285714,3.28571428571429,3.85714285714286,5,5.57142857142857,6.57142857142857,7.57142857142857,8.28571428571429,9.28571428571429,11.2857142857143,13.2857142857143,14.2857142857143,15.2857142857143,17,17.8571428571429,19,19.4285714285714];
namesV=[{'EDCr','EDCu','Brad','ECRb','APL','ECRl','ECU','FDS1','FDS2','PT','FDP1','FCR','PL','FDP2','OP','Lum1','FDI','FDMb','FPB','ADM','Elbow Flexor','Wrist Flexor','Wrist Extensor','Finger Flexor','Finger Extensor','Thumb Extensor','Thumb Flexor','Hand Intrinsics'}];

figure('Units','inches','Position',[0 2 6.5 3.2]);

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


load('C:\Users\Natalie\Desktop\NHPINVIVO\Figures\DataAnalysis\RECSelvarRight.mat')
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
ChargeT=[];
ival=[];
for n=1:3;
    subplot(1,3,n)
    
       spacing=.07;
       subfigW=(1-(spacing*3.2))/3;
       subfigH=.78; %was 3.5
       startsub=(subfigW*(n-1))+(spacing*n);
       subplot('Position',[startsub (.15) subfigW subfigH]) %this sets up the subplot within the figure, was .15
    
    
    
    [r trmax]=size(ThreshC{n});
    
    for tr=8:trmax;
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
        
        
        
        
        for c=1:16;
            ic=find(ThreshC{n}{tr}(:,3)==c); %find contact of interest
            for mn=mv; %This analysis looks for the best selectivity for each muscle
                
                ChargeT{n}(tr,16,mn)=NaN;
                im=find(ThreshC{n}{tr}(ic,1)==mn);%All muscles for this muscle
                
                if length(ThreshC{n}{tr})>0;
                    %Take max for contact of interest at each pw for
                    %the function of interest
                    imin=find(min(ThreshC{n}{tr}(ic(im),2))==ThreshC{n}{tr}(ic(im),2));
                    
                    ival{n}(tr,c,mn)=0;
                    
                    if length(imin)>0;
                        imin=imin(1);
                        ival{n}(tr,c,mn)=ic(im(imin));
                        
                        if ival{n}(tr,c,mn)>0;
                            ChargeT{n}(tr,c,mn)=ThreshC{n}{tr}(ival{n}(tr,c,mn),2);
                            
                        end
                    end
                    
                end
            end
            
        end
        
    end
    
    
    
    
    NerveV{1}='Radial ';
    NerveV{2}='Median ';
    NerveV{3}='Ulnar ';
    
    %Function muscle groups
    %1) Elbow Flexor (3)
    %2) Wrist Flexor (12,13)
    %3) Wrist Extensor (4,6,7)
    %4) Finger Flexor (8,9,11,14)
    %5) Finger Extensor (1,2)
    %6) Thumb Extensor (5)
    %7) Thumb Flexor (15)
    %8) Hand Intrinsics (16,17,18,20)
    %[3 12 13 4 6 7 8 9 11 14 1 2 5 15 16 17 18 20] order of muscles in functions to be shown as a colormap
    %namesV=[{'EDCr','EDCu','Brad','ECRb','APL','ECRl','ECU','FDS1','FDS2','PT','FDP1','FCR','PL','FDP2','OP','Lum1','FDI','FDMb','FPB','ADM','Elbow Flexor','Wrist Flexor','Wrist Extensor','Finger Flexor','Finger Extensor','Thumb Extensor','Thumb Flexor','Hand Intrinsics'}];
    colmus=[11    12     1     4    13     5     6     7     8     0     9     2     3    10    14    15 16 16 16 16 16];
    cV=[1:8 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1];
    
    for mn=mv;
        
        for c=1:16;
            ChargeV=ChargeT{n}(8:14,c,mn);
            ChargeV(find(ChargeV==0))=NaN;
            
                MeanCharge(mn,c)=nanmean(ChargeV);
                stdCharge(mn,c)=nanstd(ChargeV);

        end
        
        hold on
        plot([1:16],MeanCharge(mn,:),strcat('-',charList(mn)),'Color',ContCol(colmus(mn),:),'LineWidth',1.5)
        
    end

    countm=0;
    namesM=[];
    for mn=mv;
        countm=countm+1;
        hold on
        %scatter([1:16],MeanCharge(mn,:),charList(mn),'MarkerFaceColor',ContCol(colmus(mn),:),'MarkerEdgeColor',ContCol(colmus(mn),:))
        errorbar([1:16],MeanCharge(mn,:),stdCharge(mn,:),'Color',ContCol(colmus(mn),:))
        namesM{countm}=namesV{mv(countm)}
    end
    
    
    ylabel('Threshold (nC)')
    xlabel('Contact Number')
    %axis square
    set(findall(gcf,'-property','FontSize'),'FontSize',10)
    set(findall(gcf,'-property','FontName'),'FontName','Times')
    title(NerveV{n})
    
    if n<3
    h=columnlegend(2,namesM,'Location','north')
    set(h,'Position',[startsub .65 subfigW subfigH/4])
    elseif n==3;
    h=columnlegend(2,namesM,'Location','north')
    set(h,'Position',[startsub .735 subfigW subfigH/4])        
    end
%     
%     if n==1;
%     h1=legend(namesM)
%     elseif n==2;
%     h2=legend(namesM)    
%     elseif n==3;
%     h3=legend(namesM)
%     end
%     
    
    
    legend boxoff 
    axis([1 16 0 80])
    set(gca, 'XTick', [2:2:16])
end

% set(h1,'Fontsize',8)
% set(h2,'Fontsize',8)
% set(h3,'Fontsize',8)




