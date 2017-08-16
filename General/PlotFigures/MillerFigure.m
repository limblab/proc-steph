function MillerFigure

%Change tick direction
set(gca,'TickDir','out')
 box off
 legend boxoff

 set(findall(gcf, '-property', 'FontSize'), 'FontSize', 10,'Fontname','Arial')
set(findall(gcf,'type','text'),'fontSize',10,'fontWeight','bold','Fontname','Arial')
 
 %set default line widths for the session
% set(0,'defaultlinelinewidth',1.3)
 
 % See two sig figs
%  set(gca, 'YTickLabel', num2str(get(gca, 'YTick')', '%.1f'));