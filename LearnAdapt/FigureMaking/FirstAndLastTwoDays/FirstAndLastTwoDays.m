% MakeFirst2Last2DaysPlot for the various metrics

[ErrorAngles_rot_J, StrategyAngles_rot_J, PathLengths_rot_J, BinarySuccess_rot_J, PathEfficiency_rot_J]= AcrossDaysStatsAnalysis('Jango','rot');
[ErrorAngles_ref_J, StrategyAngles_ref_J, PathLengths_ref_J, BinarySuccess_ref_J, PathEfficiency_ref_J]= AcrossDaysStatsAnalysis('Jango','ref');
close all

RepeatedMeasuresAcrossSessions(PathEfficiency_rot_J)
title('PE Rotated Jango')
rlim([0 10]);rticks(0:2:10)

RepeatedMeasuresAcrossSessions(ErrorAngles_rot_J)
title('TE Rotated Jango')
rlim([0 180]);rticks(0:30:180)

%

RepeatedMeasuresAcrossSessions(PathEfficiency_ref_J)
title('PE Radial-Swap Jango')
rlim([0 10]);rticks(0:2:10)

RepeatedMeasuresAcrossSessions(ErrorAngles_ref_J)
title('TE Radial-Swap Jango')
rlim([0 180]);rticks(0:30:180)






% Kevin ------

[ErrorAngles_rot_K, StrategyAngles_rot_K, PathLengths_rot_K, BinarySuccess_rot_K,PathEfficiency_rot_K]= AcrossDaysStatsAnalysis('Kevin','rot');
[ErrorAngles_ref_K, StrategyAngles_ref_K, PathLengths_ref_K, BinarySuccess_ref_K,PathEfficiency_ref_K]= AcrossDaysStatsAnalysis('Kevin','ref');
close all


RepeatedMeasuresAcrossSessions(PathEfficiency_rot_K)
title('PE Rotated Kevin')
rlim([0 .8]);rticks(0:.2:.8)

RepeatedMeasuresAcrossSessions(ErrorAngles_rot_K)
title('TE Rotated Kevin')
rlim([0 180]);rticks(0:30:180)

%-----------

RepeatedMeasuresAcrossSessions(PathEfficiency_ref_K)
title('PE Reflected Kevin')
rlim([0 .8]);rticks(0:.2:.8)

RepeatedMeasuresAcrossSessions(ErrorAngles_ref_K)
title('TE Radial-Swap Kevin')
rlim([0 180]);rticks(0:30:180)


