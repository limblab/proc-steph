function Plot_T2Tfirst_equation(T2TfirstStruct)

failedTrials=find(T2TfirstStruct(:,1)==-1);
x=[1:length(T2TfirstStruct)]';
x(failedTrials)=[];
T2TfirstStruct(failedTrials,:)=[];

y=T2TfirstStruct(:,1);
X=[ones(length(x),1),x];
b=X\y;
yCalc = X*b;
%plot(x,y,'*')
hold on
plot(x,yCalc,'c-','LineWidth',1.2)
xlabel([strcat('Slope: ',num2str(b(2)))]);

end