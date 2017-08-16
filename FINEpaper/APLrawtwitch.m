APLrawtwitch


BaseFolder='C:\Stephanie\Data\FINEdata\CMAPoverTime\Radial\Ch15\';
SubFolder={'032013-PAM-Ch15-RadialRight-FF112701-Cnum16-RightArm-03-20-13-Recruitment Curve-trial49.mat'};
 load(strcat(BaseFolder,SubFolder{1}))
 figure;plot(rawtwitch(2400:5400))
 xlim([530 530+1150])