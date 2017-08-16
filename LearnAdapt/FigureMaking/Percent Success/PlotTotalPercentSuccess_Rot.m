function [PercentSuccessNorm_rot, PercentSuccessRot]=PlotTotalPercentSuccess_Rot(monkeyname)


if monkeyname=='Jango'
    BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
    FileName= JangoRotatedFileList();
end

if monkeyname=='Kevin'
    BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\';
    FileName= KevinRotatedFileList('both');
end
 
%  Start loop
for a=1:length(FileName)
    % Load files
    load(strcat(BaseFolder,FileName{a}))
    currentFile = FileName{a};
    date = FileName{a}(1,16:21);
    
     % Build decoders-------------------------------------------------------
    % Normal and reflected decoders from hand control
    if (FileName{a}(1:4))== 'Long'
        tt=binnedNormalBC.trialtable;
        badTrials = find(tt(:,7)==-1); tt(badTrials,:)=[];badTrials=[];
        PercentSuccessNorm(a)=length(find(tt(:,9)==82))/length(tt);
        ttRot=binnedRotatedBC.trialtable;
        badTrials = find(ttRot(:,7)==-1); ttRot(badTrials,:)=[];badTrials=[];
        PercentSuccessRot(a)=length(find(ttRot(:,9)==82))/length(ttRot);
    else if (FileName{a}(1:4))== 'Shor'
            tt1=binnedNormal1.trialtable;
            badTrials = find(tt1(:,7)==-1); tt1(badTrials,:)=[];badTrials=[];
            tt2=binnedNormal2.trialtable;
            badTrials = find(tt2(:,7)==-1); tt2(badTrials,:)=[];badTrials=[];
            tt3=binnedNormal3.trialtable;
            badTrials = find(tt3(:,7)==-1); tt3(badTrials,:)=[];badTrials=[];
            allLengths=length(tt1)+length(tt2)+length(tt3);
            allNormSuccess=length(find(tt1(:,9)==82))+length(find(tt2(:,9)==82))+length(find(tt3(:,9)==82));
           PercentSuccessNorm(a)=allNormSuccess/allLengths;
           
              ttRot1=binnedRotated1.trialtable;
            ttRot2=binnedRotated2.trialtable;
            ttRot3=binnedRotated3.trialtable;
            allLengths=length(ttRot1)+length(ttRot2)+length(ttRot3);
            allRotSuccess=length(find(ttRot1(:,9)==82))+length(find(ttRot2(:,9)==82))+length(find(ttRot3(:,9)==82));
           PercentSuccessRot(a)=allRotSuccess/allLengths;
        end
    end
   
     
     clearvars -except BaseFolder FileName PercentSuccessNorm PercentSuccessRot
end

PercentSuccessNorm_rot=PercentSuccessNorm;

figure; hold on;ylim([0 1]);xlim([0 9])
for b=1:length(FileName)
    plot(b, PercentSuccessNorm(b),'.k','MarkerSize',15)
     plot(b, PercentSuccessRot(b),'.g','MarkerSize',15)
end
MillerFigure
set(gca,'Xtick',1:8,'XTickLabel',{'0403','0407', '0410', '0416','0417','0501','0503','0613'})
legend('Normal BC Success', 'Rotated Success')

