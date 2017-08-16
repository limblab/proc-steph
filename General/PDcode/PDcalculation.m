function [PD,Rsquared,Pvalue] = PDcalculation(FRandTheta)
% The math, explained -----------------------------------------------------
% We want to fit FR = a+b*sin(theta)+c*sin(theta)
% Identity: b*sin(theta)+c*cos(theta) = d*sin(theta+PD) where 
% c = sqrt(b^2+c^2) and PD = arctan(c/b)

% So: FR = a+d*sin(theta+PD)

% Input: 
% FR: a column of firing rate durng the epoch for each trial
% theta: a column of target angle for each trial

for NeuronNumber = 1:length(FRandTheta(1,1,:))
    
theta = FRandTheta(:,2,NeuronNumber);
FR = FRandTheta(:,1,NeuronNumber);
    
st = sin(theta);
ct = cos(theta);
X = [ones(size(theta)) st ct];

% model is b0+b1*cos(theta)+b2*sin(theta)
[b,~,~,~,stats] = regress(FR,X);
% convert to model b0 + b1*cos(theta+b2)
c  = [b(1); sqrt(b(2).^2 + b(3).^2); atan2(b(2),b(3))];

% Plot the curve
% figure; hold on;
% curve = c(1) + c(2)*cos(theta-c(3));
% [~,I] = sort(theta);
% plot(theta(I),curve(I),'b','LineWidth',2)
% plot(theta,FR,'r.')
% plot([c(3) c(3)],[0 20],'k')


PD(NeuronNumber,1) = radtodeg(c(3));
%Make it so the numbers go from 0 to 360
if PD(NeuronNumber,1)>0
    PD(NeuronNumber,1)=PD(NeuronNumber,1)+180;
else if PD(NeuronNumber,1)<0
        PD(NeuronNumber,1)=180-abs(PD(NeuronNumber,1));
    end
end

Rsquared(NeuronNumber,1)=stats(1); % r^2 value
Pvalue(NeuronNumber,1) = stats(3); % p value

end

end
