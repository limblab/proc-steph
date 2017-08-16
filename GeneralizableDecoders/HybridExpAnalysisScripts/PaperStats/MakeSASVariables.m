
numDays=2;

% Iso=1, Wm = 2, Spr = 3;
DayVar=[];FoldVar= []; TaskVar = [];
for a=1:numDays;
    tempDay = a*ones(15,1);
    DayVar = cat(1,DayVar,tempDay);
        tempFold = [1 2 3 4 5 1 2 3 4 5 1 2 3 4 5]';
    FoldVar = cat(1,FoldVar,tempFold);
    tempTask = [1 1 1 1 1 2 2 2 2 2 3 3 3 3 3]';
    TaskVar = cat(1,TaskVar,tempTask);
end

SASvars = cat(2, DayVar, TaskVar, FoldVar);

% Column 4: VAF_HonI, HonW, HonS across folds for each day


VAF_HonAll_Day1 = cat(1,AllDaysHonI(1:5), AllDaysHonW(1:5), AllDaysHonS(1:5));
VAF_HonAll_Day2 = cat(1,AllDaysHonI(6:10), AllDaysHonW(6:10), AllDaysHonS(6:10));
VAF_HonAll= cat(1,VAF_HonAll_Day1,VAF_HonAll_Day2);

VAF_IonAll_Day1 = cat(1,AllDaysIonI(1:5), AllDaysIonW(1:5), AllDaysIonS(1:5));
VAF_IonAll_Day2 = cat(1,AllDaysIonI(6:10), AllDaysIonW(6:10), AllDaysIonS(6:10));
VAF_IonAll= cat(1,VAF_IonAll_Day1,VAF_IonAll_Day2);


VAF_WonAll_Day1 = cat(1,AllDaysWonI(1:5), AllDaysWonW(1:5), AllDaysWonS(1:5));
VAF_WonAll_Day2 = cat(1,AllDaysWonI(6:10), AllDaysWonW(6:10), AllDaysWonS(6:10));
VAF_WonAll= cat(1,VAF_WonAll_Day1,VAF_WonAll_Day2);

SASvars = cat(2, SASvars, VAF_HonAll,VAF_IonAll,VAF_WonAll);

SASlabels = {'Day', 'Fold','Task','Hpreds','Ipreds','Wpreds'};


