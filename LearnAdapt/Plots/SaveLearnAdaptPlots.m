function SaveLearnAdaptPlots(saveFlag,foldername, plotname)

if saveFlag==1
    saveas(gcf, strcat(foldername, plotname, '.fig'))
    saveas(gcf, strcat(foldername, plotname, '.pdf'))
    saveas(gcf, strcat(foldername, plotname, '.png'))
    % close
end

end