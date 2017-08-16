

figure
subplot(3,1,1); MillerFigure
a=6
title(TargetNumber(a)); hold on
plot(TrajectoriesX(a,:),'b')
plot(TrajectoriesY(a,:),'g')
xlabel('Position')
set(gca,'xticklabel',{'Go', '+50' ,'+100', '+150' ,'+200', '+250','+300','+350','+400'})

subplot(3,1,2); hold on; MillerFigure
plot(VelX(a,:),'b')
plot(VelY(a,:),'g')
plot(VelTotal(a,:),'k:')
xlabel('Velocity')
set(gca,'xticklabel',{'Go', '+50' ,'+100', '+150' ,'+200', '+250','+300','+350','+400'})

subplot(3,1,3); hold on; MillerFigure
plot(AccX(a,:),'b')
plot(AccY(a,:),'g')
plot(AccTotal(a,:),'k:')
xlabel('Accel')
set(gca,'xticklabel',{'Go', '+50' ,'+100', '+150' ,'+200', '+250','+300','+350','+400'})
