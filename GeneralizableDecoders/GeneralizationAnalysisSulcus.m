% Sulcus (LMA) data comparison

% Isometric
R2_Iso_Sul_Within = R2;
MSE_Iso_Sul_Within = mse;
VAF_Iso_Sul_Within = vaf;
clear R2 mse vaf


R2_Iso_Sul_Across = R2;
MSE_Iso_Sul_Across = mse;
VAF_Iso_Sul_Across = vaf;
clear R2 mse vaf


R2_Sul_IsoWoverIsoA = R2_Iso_Sul_Within./R2_Iso_Sul_Across;
MSE_Sul_IsoAoverIsoW = MSE_Iso_Sul_Across./R2_Iso_Sul_Within;

% Wrist Movement
R2_WM_Sul_Within = R2;
MSE_WM_Sul_Within = mse;
VAF_WM_Sul_Within = vaf;
clear R2 mse vaf


R2_WM_Sul_Across = R2;
MSE_WM_Sul_Across = mse;
VAF_WM_Sul_Across = vaf;
clear R2 mse vaf


R2_Sul_WMWoverWMA = R2_WM_Sul_Within./R2_WM_Sul_Across;
MSE_Sul_WMAoverWMW = MSE_WM_Sul_Across./R2_WM_Sul_Within;

%%
figure;
R2SI =  subplot(2,2,1);
bar(R2_Sul_IsoWoverIsoA)
title('Sulcus | R2 | Isometric | Within:Across')
mseSI = subplot(2,2,3);
bar(MSE_Sul_IsoAoverIsoW)
title('Sulcus | MSE | Isometric | Across:Within')

R2SW = subplot(2,2,2);
bar(R2_Sul_WMWoverWMA)
title('Sulcus | R2 | Wrist Movement | Within:Across')
mseSW = subplot(2,2,4);
bar(MSE_Sul_WMAoverWMW)
title('Sulcus | MSE | Wrist Movement | Across:Within')

linkaxes([R2SI R2SW], 'y')
linkaxes([mseSW mseSI], 'y')

%%