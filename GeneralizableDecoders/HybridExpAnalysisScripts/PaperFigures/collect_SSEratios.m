function SSEratio = collect_SSEratios(monkeyname)
% Ratio of SSE

if strcmp(monkeyname,'Jango')
BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Jango\Results\';
SubFolder = {'Lin_Jango_072414_results','Lin_Jango_072514_results', 'Lin_Jango_081914_results', 'Lin_Jango_082014_results',...
  'Lin_Jango_082114_results','Lin_Jango_092314_results','Lin_Jango_101014_results','Lin_Jango_101114_results'...
  'Lin_Jango_101214_results'};
end

if strcmp(monkeyname,'Kevin')
BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Kevin\Results\Old\';
SubFolder = {'Lin_Kevin_051915_results','Lin_Kevin_052115_results', 'Lin_Kevin_052515_results', 'Lin_Kevin_052615_results',...
  'Lin_Kevin_060415_results'};
end

for a=1:length(SubFolder)
    load([BaseFolder SubFolder{a}]);
    datalabel = SubFolder{a}(11:16);
% Across ratios
SSEratio.SonI(a)=calculateSSEratio(SonI_PredEMGs.preddatabin,IonI_PredEMGs.preddatabin,IsoTest.emgdatabin(10:end,:));
SSEratio.WonI(a)=calculateSSEratio(WonI_PredEMGs.preddatabin,IonI_PredEMGs.preddatabin,IsoTest.emgdatabin(10:end,:));

SSEratio.SonW(a)=calculateSSEratio(SonW_PredEMGs.preddatabin,WonW_PredEMGs.preddatabin,WmTest.emgdatabin(10:end,:));
SSEratio.IonW(a)=calculateSSEratio(IonW_PredEMGs.preddatabin,WonW_PredEMGs.preddatabin,WmTest.emgdatabin(10:end,:));

SSEratio.WonS(a)=calculateSSEratio(WonS_PredEMGs.preddatabin,SonS_PredEMGs.preddatabin,SprTest.emgdatabin(10:end,:));
SSEratio.IonS(a)=calculateSSEratio(IonS_PredEMGs.preddatabin,SonS_PredEMGs.preddatabin,SprTest.emgdatabin(10:end,:));

% Hybrid ratios
SSEratio.HonI(a)=calculateSSEratio(HonI_PredEMGs.preddatabin,IonI_PredEMGs.preddatabin,IsoTest.emgdatabin(10:end,:));
SSEratio.HonW(a)=calculateSSEratio(HonW_PredEMGs.preddatabin,WonW_PredEMGs.preddatabin,WmTest.emgdatabin(10:end,:));
SSEratio.HonS(a)=calculateSSEratio(HonS_PredEMGs.preddatabin,SonS_PredEMGs.preddatabin,SprTest.emgdatabin(10:end,:));

clearvars -except BaseFolder SubFolder SSEratio

end

end

