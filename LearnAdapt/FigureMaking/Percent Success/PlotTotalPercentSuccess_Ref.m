function [PercentSuccessNorm_ref, PercentSuccessRef]=PlotTotalPercentSuccess_Ref(monkeyname)


if strcmp(monkeyname,'Jango')
    BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
    FileName = JangoReflectedFileList();
end

if strcmp(monkeyname,'Kevin')
    BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\';
    FileName = KevinReflectedFileList('both');
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
        ttRef=binnedReflectedBC.trialtable;
        badTrials = find(ttRef(:,7)==-1); ttRef(badTrials,:)=[];badTrials=[];
        PercentSuccessRef(a)=length(find(ttRef(:,9)==82))/length(ttRef);
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
           
            ttRef1=binnedReflected1.trialtable;
            ttRef2=binnedReflected2.trialtable;
            ttRef3=binnedReflected3.trialtable;
            allLengths=length(ttRef1)+length(ttRef2)+length(ttRef3);
            allRefSuccess=length(find(ttRef1(:,9)==82))+length(find(ttRef2(:,9)==82))+length(find(ttRef3(:,9)==82));
           PercentSuccessRef(a)=allRefSuccess/allLengths;
        end
    end
   
     
     clearvars -except BaseFolder FileName PercentSuccessNorm PercentSuccessRef
end

PercentSuccessNorm_ref=PercentSuccessNorm;

figure; hold on;ylim([0 1]);xlim([0 9])
for b=1:length(FileName)
    plot(b, PercentSuccessNorm(b),'.k','MarkerSize',15)
     plot(b, PercentSuccessRef(b),'.r','MarkerSize',15)
end
MillerFigure
% Kevin labels:
%set(gca,'Xtick',1:8,'XTickLabel',{'0402','0406', '0415','0420','0423','0502','0614','0625'})
legend('Normal BC Success', 'Reflected Success')


