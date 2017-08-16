
emgind=3;
[meanIonI_r2, steIonI_r2] = FindMeanAndSTE(R2vals.IonI(:,emgind));
[meanSonS_r2, steSonS_r2] = FindMeanAndSTE(R2vals.SonS(:,emgind));
[meanWonW_r2, steWonW_r2] = FindMeanAndSTE(R2vals.WonW(:,emgind));

[meanHonI_r2, steHonI_r2] = FindMeanAndSTE(R2vals.HonI(:,emgind));
[meanHonS_r2, steHonS_r2] = FindMeanAndSTE(R2vals.HonS(:,emgind));
[meanHonW_r2, steHonW_r2] = FindMeanAndSTE(R2vals.HonW(:,emgind));

[meanH2onI_r2, steH2onI_r2] = FindMeanAndSTE(R2vals.H2onI(:,emgind));
[meanH2onS_r2, steH2onS_r2] = FindMeanAndSTE(R2vals.H2onS(:,emgind));
[meanH2onW_r2, steH2onW_r2] = FindMeanAndSTE(R2vals.H2onW(:,emgind));

figure; hold on;ylim([0 1])
errorbar(1,meanHonI_r2, steHonI_r2, steHonI_r2,'.c');
errorbar(2,meanHonW_r2, steHonW_r2, steHonW_r2,'.c');
errorbar(3,meanHonS_r2, steHonS_r2, steHonS_r2,'.c');
errorbar(1,meanH2onI_r2, steH2onI_r2, steH2onI_r2,'.k');
errorbar(2,meanH2onW_r2, steH2onW_r2, steH2onW_r2,'.k');
errorbar(3,meanH2onS_r2, steH2onS_r2, steH2onS_r2,'.k');

errorbar(1,meanIonI_r2, steIonI_r2, steIonI_r2,'.m');
errorbar(2,meanWonW_r2, steWonW_r2, steWonW_r2,'.g');
errorbar(3,meanSonS_r2, steSonS_r2, steSonS_r2,'.b');


