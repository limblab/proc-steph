function [IsoBinned, WmBinned, SprBinned] = FixBaseline_HybridData(IsoBinned,WmBinned,SprBinned)

Iso1percent=quantile(IsoBinned.emgdatabin,0.01);
NewIsoEMG=IsoBinned.emgdatabin-repmat(Iso1percent, length(IsoBinned.emgdatabin),1);
for emg=1:length(Iso1percent)
    for ind=1:length(NewIsoEMG)
        if NewIsoEMG(ind,emg)<0
            NewIsoEMG(ind,emg)=0;
        end
    end
end
IsoBinned.emgdatabin=NewIsoEMG;

Wm1percent=quantile(WmBinned.emgdatabin,0.01);
NewWmEMG=WmBinned.emgdatabin-repmat(Wm1percent, length(WmBinned.emgdatabin),1);
for emg=1:length(Wm1percent)
    for ind=1:length(NewWmEMG)
        if NewWmEMG(ind,emg)<0
            NewWmEMG(ind,emg)=0;
        end
    end
end
WmBinned.emgdatabin=NewWmEMG;

Spr1percent=quantile(SprBinned.emgdatabin,0.01);
NewSprEMG=SprBinned.emgdatabin-repmat(Spr1percent, length(SprBinned.emgdatabin),1);
for emg=1:length(Spr1percent)
    for ind=1:length(NewSprEMG)
        if NewSprEMG(ind,emg)<0
            NewSprEMG(ind,emg)=0;
        end
    end
end
SprBinned.emgdatabin=NewSprEMG;

