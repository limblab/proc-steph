%IsHeTrying_OverDays
% This one plots the mean firing for each target for each exp. day

BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
FileName = JangoReflectedFileList();
%
% BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\';
% FileName = KevinReflectedFileList();

figure
for a=1:length(FileName)
    load(strcat(BaseFolder,FileName{a}))
    if (FileName{a}(1:4))== 'Long'
        [MeanPerTarget_Norm, StdPerTarget_Norm] = IsHeTrying(binnedNormalBC);
        [MeanPerTarget_Pert, StdPerTarget_Pert] = IsHeTrying(binnedReflectedBC);
    end
    if (FileName{a}(1:4))== 'Shor'
        [MeanPerTarget_Norm, StdPerTarget_Norm] = IsHeTrying(binnedNormal3);
        [MeanPerTarget_Pert, StdPerTarget_Pert] = IsHeTrying(binnedReflected3);
    end
    
    
    colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
    MS=8; MS2=12; LW=1;
    subplot(5,5,15); hold on
    errorbar(a,MeanPerTarget_Pert(1),StdPerTarget_Pert(1),StdPerTarget_Pert(1),'*','Color',colors(1,:),'LineWidth',LW,'MarkerSize',MS);
    errorbar(a,MeanPerTarget_Norm(1),StdPerTarget_Norm(1),StdPerTarget_Norm(1),'.','Color',colors(1,:),'LineWidth',LW,'MarkerSize',MS2);
    title('1');ylim([0 30])
    MillerFigure
    
    subplot(5,5,9); hold on
    errorbar(a,MeanPerTarget_Pert(2),StdPerTarget_Pert(2),StdPerTarget_Pert(2),'*','Color',colors(2,:),'LineWidth',LW,'MarkerSize',MS);
    errorbar(a,MeanPerTarget_Norm(2),StdPerTarget_Norm(2),StdPerTarget_Norm(2),'.','Color',colors(2,:),'LineWidth',LW,'MarkerSize',MS2);
    title('2');ylim([0 30])
    MillerFigure
    
    subplot(5,5,3); hold on
    errorbar(a,MeanPerTarget_Pert(3),StdPerTarget_Pert(3),StdPerTarget_Pert(3),'*','Color',colors(3,:),'LineWidth',LW,'MarkerSize',MS);
    errorbar(a,MeanPerTarget_Norm(3),StdPerTarget_Norm(3),StdPerTarget_Norm(3),'.','Color',colors(3,:),'LineWidth',LW,'MarkerSize',MS2);
    title('3');ylim([0 30])
    MillerFigure
    
    subplot(5,5,7); hold on
    errorbar(a,MeanPerTarget_Pert(4),StdPerTarget_Pert(4),StdPerTarget_Pert(4),'*','Color',colors(4,:),'LineWidth',LW,'MarkerSize',MS);
    errorbar(a,MeanPerTarget_Norm(4),StdPerTarget_Norm(4),StdPerTarget_Norm(4),'.','Color',colors(4,:),'LineWidth',LW,'MarkerSize',MS2);
    title('4');ylim([0 30])
    MillerFigure
    
    subplot(5,5,11); hold on
    errorbar(a,MeanPerTarget_Pert(5),StdPerTarget_Pert(5),StdPerTarget_Pert(5),'*','Color',colors(5,:),'LineWidth',LW,'MarkerSize',MS);
    errorbar(a,MeanPerTarget_Norm(5),StdPerTarget_Norm(5),StdPerTarget_Norm(5),'.','Color',colors(5,:),'LineWidth',LW,'MarkerSize',MS2);
    title('5');ylim([0 30])
    MillerFigure
    
    subplot(5,5,17); hold on
    errorbar(a,MeanPerTarget_Pert(6),StdPerTarget_Pert(6),StdPerTarget_Pert(6),'*','Color',colors(6,:),'LineWidth',LW,'MarkerSize',MS);
    errorbar(a,MeanPerTarget_Norm(6),StdPerTarget_Norm(6),StdPerTarget_Norm(6),'.','Color',colors(6,:),'LineWidth',LW,'MarkerSize',MS2);
    title('6');ylim([0 30])
    MillerFigure
    
    subplot(5,5,23); hold on
    errorbar(a,MeanPerTarget_Pert(7),StdPerTarget_Pert(7),StdPerTarget_Pert(7),'*','Color',colors(7,:),'LineWidth',LW,'MarkerSize',MS);
    errorbar(a,MeanPerTarget_Norm(7),StdPerTarget_Norm(7),StdPerTarget_Norm(7),'.','Color',colors(7,:),'LineWidth',LW,'MarkerSize',MS2);
    title('7');ylim([0 30])
    MillerFigure
    
    subplot(5,5,19); hold on
    errorbar(a,MeanPerTarget_Pert(8),StdPerTarget_Pert(8),StdPerTarget_Pert(8),'*','Color',colors(8,:),'LineWidth',LW,'MarkerSize',MS);
    errorbar(a,MeanPerTarget_Norm(8),StdPerTarget_Norm(8),StdPerTarget_Norm(8),'.','Color',colors(8,:),'LineWidth',LW,'MarkerSize',MS2);
    title('8');ylim([0 30])
    MillerFigure
    
end
