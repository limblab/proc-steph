 
% Jango: First reflected day
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_073115_binnedDec_ref.mat')
binnedPerturbation=binnedReflectedBC;
PlotEfficiencyForFigure

% Jango: Last reflected day
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_092815_binnedDec_ref.mat')
binnedPerturbation=binnedReflectedBC;
PlotEfficiencyForFigure

% Jango: First rotated day
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_080415_binnedDec_rot.mat')
binnedPerturbation=binnedRotatedBC;
PlotEfficiencyForFigure

% Jango: Last rotated day
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_092915_binnedDec_rot.mat')
binnedPerturbation=binnedRotatedBC;
PlotEfficiencyForFigure


% Kevin: First reflected day
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\ShorPert_Kevin_040215_binnedDec_ref.mat')
binnedPerturbation=binnedReflected1;PlotEfficiencyForFigure
binnedPerturbation=binnedReflected2;PlotEfficiencyForFigure
binnedPerturbation=binnedReflected3;PlotEfficiencyForFigure

% Kevin: Last reflected day
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_061415_binnedDec_ref.mat')
binnedPerturbation=binnedReflectedBC;
PlotEfficiencyForFigure

% Kevin: First rotated day
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\ShorPert_Kevin_040315_binnedDec_rot.mat')
binnedPerturbation=binnedRotated1;PlotEfficiencyForFigure
binnedPerturbation=binnedRotated2;PlotEfficiencyForFigure
binnedPerturbation=binnedRotated3;PlotEfficiencyForFigure

% Kevin: Last rotated day
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_061315_binnedDec_rot.mat')
binnedPerturbation=binnedRotatedBC;
PlotEfficiencyForFigure

