function R2vals = collect_R2vals
% Ratio of SSE

BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Jango\Results\';
SubFolder = {'Lin_Jango_072414_results','Lin_Jango_072514_results', 'Lin_Jango_081914_results', 'Lin_Jango_082014_results',...
  'Lin_Jango_082114_results','Lin_Jango_092314_results','Lin_Jango_101014_results','Lin_Jango_101114_results'...
  'Lin_Jango_101214_results'};

% BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Kevin\Results\';
% SubFolder = {'Lin_Kevin_051915_results','Lin_Kevin_052115_results', 'Lin_Kevin_052515_results', 'Lin_Kevin_052615_results',...
%   'Lin_Kevin_060415_results'};

for a=1:length(SubFolder)
    load([BaseFolder SubFolder{a}]);
    
% Across ratios
for b=1:length(IonI_PredEMGs.preddatabin(1,:))
R2vals.IonI(a,b)=CalculateR2(IonI_PredEMGs.preddatabin(:,b),IsoTest.emgdatabin(10:end,:));
R2vals.SonI(a,b)=CalculateR2(SonI_PredEMGs.preddatabin(:,b),IsoTest.emgdatabin(10:end,:));
R2vals.WonI(a,b)=CalculateR2(WonI_PredEMGs.preddatabin(:,b),IsoTest.emgdatabin(10:end,:));
R2vals.HonI(a,b)=CalculateR2(HonI_PredEMGs.preddatabin(:,b),IsoTest.emgdatabin(10:end,:));
R2vals.H2onI(a,b)=CalculateR2(H2onI_PredEMGs.preddatabin(:,b),IsoTest.emgdatabin(10:end,:));

R2vals.WonW(a,b)=CalculateR2(WonW_PredEMGs.preddatabin(:,b),WmTest.emgdatabin(10:end,:));
R2vals.SonW(a,b)=CalculateR2(SonW_PredEMGs.preddatabin(:,b),WmTest.emgdatabin(10:end,:));
R2vals.IonW(a,b)=CalculateR2(IonW_PredEMGs.preddatabin(:,b),WmTest.emgdatabin(10:end,:));
R2vals.HonW(a,b)=CalculateR2(HonW_PredEMGs.preddatabin(:,b),WmTest.emgdatabin(10:end,:));
R2vals.H2onW(a,b)=CalculateR2(H2onW_PredEMGs.preddatabin(:,b),WmTest.emgdatabin(10:end,:));

R2vals.SonS(a,b)=CalculateR2(SonS_PredEMGs.preddatabin(:,b),SprTest.emgdatabin(10:end,:));
R2vals.IonS(a,b)=CalculateR2(IonS_PredEMGs.preddatabin(:,b),SprTest.emgdatabin(10:end,:));
R2vals.WonS(a,b)=CalculateR2(WonS_PredEMGs.preddatabin(:,b),SprTest.emgdatabin(10:end,:));
R2vals.HonS(a,b)=CalculateR2(HonS_PredEMGs.preddatabin(:,b),SprTest.emgdatabin(10:end,:));
R2vals.H2onS(a,b)=CalculateR2(H2onS_PredEMGs.preddatabin(:,b),SprTest.emgdatabin(10:end,:));
end


clearvars -except BaseFolder SubFolder R2vals

end

end

