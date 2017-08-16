function [EMG_Iso2, EMG_Wm2, EMG_Spr2] = GDremoveEMGoutliers(EMG_Iso, EMG_Wm, EMG_Spr)

%Josh's code to remove EMG outliers

EMG_Spr2=EMG_Spr;
for i=1:size(EMG_Spr,2)
    qs=quantile(EMG_Spr(:,i),[.9 .995]);
    d=qs(2)-qs(1);
    thresh=qs(2)+2*d;
    change=find(EMG_Spr(:,i)>thresh);
    
    for j=1:length(change)
        change_idx=change(j);
        EMG_Spr2(change_idx,i)=median(EMG_Spr(change_idx-2:change_idx+2,i));
    end
end
EMG_Spr2(EMG_Spr2<0)=0;

EMG_Iso2=EMG_Iso;
for i=1:size(EMG_Iso,2)
    qs=quantile(EMG_Iso(:,i),[.9 .995]);
    d=qs(2)-qs(1);
    thresh=qs(2)+2*d;
    change=find(EMG_Iso(:,i)>thresh);    
    
    for j=1:length(change)
        change_idx=change(j);
        EMG_Iso2(change_idx,i)=median(EMG_Iso(change_idx-2:change_idx+2,i));
    end
end
EMG_Iso2(EMG_Iso2<0)=0;

EMG_Wm2=EMG_Wm;
for i=1:size(EMG_Wm,2)
    qs=quantile(EMG_Wm(:,i),[.9 .995]);
    d=qs(2)-qs(1);
    thresh=qs(2)+2*d;
    change=find(EMG_Wm(:,i)>thresh);
    
    for j=1:length(change)
        change_idx=change(j);
        EMG_Wm2(change_idx,i)=median(EMG_Wm(change_idx-2:change_idx+2,i));
    end
end
EMG_Wm2(EMG_Wm2<0)=0;
