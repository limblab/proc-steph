% AcrossPercentGeneralizability

% Across on Iso------------------------------------------------------------
WonI_PG = [MegaVAFstruct.WonI_mVAF]./[MegaVAFstruct.IonI_mVAF]*100;
WonI_PG_mean=mean(WonI_PG);
WonI_PG_ste=std(WonI_PG)/sqrt(length(WonI_PG));

SonI_PG = [MegaVAFstruct.SonI_mVAF]./[MegaVAFstruct.IonI_mVAF]*100;
SonI_PG_mean=mean(SonI_PG);
SonI_PG_ste=std(SonI_PG)/sqrt(length(SonI_PG));

% Across on Move-----------------------------------------------------------
IonW_PG = [MegaVAFstruct.IonW_mVAF]./[MegaVAFstruct.WonW_mVAF]*100;
IonW_PG_mean=mean(IonW_PG);
IonW_PG_ste=std(IonW_PG)/sqrt(length(IonW_PG));

SonW_PG = [MegaVAFstruct.SonW_mVAF]./[MegaVAFstruct.WonW_mVAF]*100;
SonW_PG_mean=mean(SonW_PG);
SonW_PG_ste=std(SonW_PG)/sqrt(length(SonW_PG));

% Across on Spring-----------------------------------------------------------
IonS_PG = [MegaVAFstruct.IonS_mVAF]./[MegaVAFstruct.SonS_mVAF]*100;
IonS_PG_mean=mean(IonS_PG);
IonS_PG_ste=std(IonS_PG)/sqrt(length(IonS_PG));

WonS_PG = [MegaVAFstruct.WonS_mVAF]./[MegaVAFstruct.SonS_mVAF]*100;
WonS_PG_mean=mean(WonS_PG);
WonS_PG_ste=std(WonS_PG)/sqrt(length(WonS_PG));

% Plot!
%ylim([-100 100]);
hold on; 
xlim([0.5 3.5]); LW=2;MS=10;
h1 = errorbar(1.1,WonI_PG_mean,WonI_PG_ste,WonI_PG_ste,'.g','LineWidth',LW,'MarkerSize',MS);
h2 = errorbar(1,SonI_PG_mean,SonI_PG_ste,SonI_PG_ste,'.b','LineWidth',LW,'MarkerSize',MS);

h3 = errorbar(2.1,IonW_PG_mean,IonW_PG_ste,IonW_PG_ste,'.m','LineWidth',LW,'MarkerSize',MS);
h4 = errorbar(2,SonW_PG_mean,SonW_PG_ste,SonW_PG_ste,'.b','LineWidth',LW,'MarkerSize',MS);

h5 = errorbar(3.1,IonS_PG_mean,IonS_PG_ste,IonS_PG_ste,'.m','LineWidth',LW,'MarkerSize',MS);
h6 = errorbar(3,WonS_PG_mean,WonS_PG_ste,WonS_PG_ste,'.b','LineWidth',LW,'MarkerSize',MS);
ylabel('%Gen')




