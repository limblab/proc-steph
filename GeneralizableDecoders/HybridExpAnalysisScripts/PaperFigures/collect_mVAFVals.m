function MegaVAFstruct = collect_mVAFVals


BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Jango\Results\';
SubFolder = {'Lin_Jango_072414_results','Lin_Jango_072514_results', 'Lin_Jango_081914_results', 'Lin_Jango_082014_results',...
  'Lin_Jango_082114_results','Lin_Jango_092314_results','Lin_Jango_101014_results','Lin_Jango_101114_results'...
  'Lin_Jango_101214_results'};

% % BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Kevin\Results\';
% % SubFolder = {'Lin_Kevin_051915_results','Lin_Kevin_052115_results', 'Lin_Kevin_052515_results', 'Lin_Kevin_052615_results',...
% %   'Lin_Kevin_060415_results'};

for a=1:length(SubFolder)
    load([BaseFolder SubFolder{a}]);
    datalabel = SubFolder{a}(11:16);

MegaVAFstruct.IonI_mVAF(a)=MultivariateVAF(IonI_PredEMGs.preddatabin,IsoTest.emgdatabin(10:end,:));
MegaVAFstruct.SonI_mVAF(a)=MultivariateVAF(SonI_PredEMGs.preddatabin,IsoTest.emgdatabin(10:end,:));
MegaVAFstruct.WonI_mVAF(a)=MultivariateVAF(WonI_PredEMGs.preddatabin,IsoTest.emgdatabin(10:end,:));
MegaVAFstruct.HonI_mVAF(a)=MultivariateVAF(HonI_PredEMGs.preddatabin,IsoTest.emgdatabin(10:end,:));

MegaVAFstruct.WonW_mVAF(a)=MultivariateVAF(WonW_PredEMGs.preddatabin,WmTest.emgdatabin(10:end,:));
MegaVAFstruct.SonW_mVAF(a)=MultivariateVAF(SonW_PredEMGs.preddatabin,WmTest.emgdatabin(10:end,:));
MegaVAFstruct.IonW_mVAF(a)=MultivariateVAF(IonW_PredEMGs.preddatabin,WmTest.emgdatabin(10:end,:));
MegaVAFstruct.HonW_mVAF(a)=MultivariateVAF(HonW_PredEMGs.preddatabin,WmTest.emgdatabin(10:end,:));

MegaVAFstruct.SonS_mVAF(a)=MultivariateVAF(SonS_PredEMGs.preddatabin,SprTest.emgdatabin(10:end,:));
MegaVAFstruct.IonS_mVAF(a)=MultivariateVAF(IonS_PredEMGs.preddatabin,SprTest.emgdatabin(10:end,:));
MegaVAFstruct.WonS_mVAF(a)=MultivariateVAF(WonS_PredEMGs.preddatabin,SprTest.emgdatabin(10:end,:));
MegaVAFstruct.HonS_mVAF(a)=MultivariateVAF(HonS_PredEMGs.preddatabin,SprTest.emgdatabin(10:end,:));

clearvars -except BaseFolder SubFolder MegaVAFstruct

end

end

