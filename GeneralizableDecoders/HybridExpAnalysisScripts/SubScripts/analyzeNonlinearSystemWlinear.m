% analyze non-linear system with linear methods

%% synthesize non-linear data

%Create input
X=randn(10000,1);
SRate=200;
t=(0:9999)/SRate;

%System filter
[b,a]=butter(2,0.1);

%Baseline o/p; STD ~ 0.1
Y=filter(b,a,X);

% Create new outputs with different amplitudes. Threshold all at 0.15
thr=0.15;

for amp=1:50
YY=amp*Y-thr;      %shift to place thr at zero
Yrect(:,amp)=(abs(YY)+YY)/2;  %half-wave rectify
end



%%
% Now build simple linear filter between input X and output Yrect
figure;hold on
for iteration=1:50

    LinearH=[];PSD=[];P_at_2=[];YMag=[];PredictedData=[];
    
    % Calc linear filter between white noise X and Yrectified
    [LinearH]=filMIMO3(X,Yrect(:,iteration),10,1,200);
    
    % Make new white noise input data
    X1=randn(10000,1);
    % Make predss using new inputs and the linear filter calc'ed above
    [PredictedData]=predMIMO3(X1,LinearH,1,200,Yrect(:,iteration));
    
    % POWER TIME
    PSD=pwelch(PredictedData,[],[],[],200); %default params, go back and change
    %loglog(PSD); hold on
    %Plot Power v Ymagnitude
    P_at_2=PSD(2);
    YMag=quantile(Yrect(:,iteration),.99);
    plot(YMag,P_at_2,'k*')
end

% Now build simple cascade between input X and output Yrect
figure
for iteration=1:50
    H=[];PSDc=[];P_at_2Cas=[];YMagCas=[];
    % Calc linear filter between white noise X and Yrectified
    [H]=filMIMO3(X,Yrect(:,iteration),10,1,200);
    % Use filt to make predictions
    [PredictedData2]=predMIMO3(X,H,1,200,Yrect(:,iteration));
    % Get cascade polynomials
    [P] = WienerNonlinearity(PredictedData2,Yrect(:,iteration),3,0);
    CascadeDataForSanityCheck = polyval(P,PredictedData2);
    
    % Generate new input data
    X2=randn(10000,1);
    % Make cascade predictions using H and P from above
    [PredictedData3]=predMIMO3(X2,H,1,200,[]);
    CascadeData = polyval(P,PredictedData3);
    
    % POWER TIME
    PSDc=pwelch(CascadeData,[],[],[],200); %default params, go back and change
    %loglog(PSDc); hold on
    % Plot Power v Ymagnitude
    P_at_2Cas=PSDc(2);
    YMagCas=quantile(CascadeData,.99);
    plot(YMagCas,P_at_2Cas,'k*'); hold on
end




% meh
% Implement half wave rectification that I know is there
figure
for iteration=1:50
    H=[];PSDc=[];P_at_2Cas=[];YMagCas=[];
    % Calc linear filter between white noise X and Yrectified
    [H]=filMIMO3(X,Yrect(:,iteration),10,1,200);
    % Use filt to make predictions
    [PredictedData2]=predMIMO3(X,H,1,200,Yrect(:,iteration));
    % Half wave rectify
    Yrect(:,amp)=(abs(YY)+YY)/2; 
    
    % Generate new input data
    X2=randn(10000,1);
    % Make cascade predictions using H and P from above
    [PredictedData3]=predMIMO3(X2,H,1,200,[]);
    CascadeData = polyval(P,PredictedData3);
    
    % POWER TIME
    PSDc=pwelch(CascadeData,[],[],[],200); %default params, go back and change
    loglog(PSDc); hold on
    % Plot Power v Ymagnitude
    P_at_2Cas=PSDc(2);
    YMagCas=quantile(CascadeData,.99);
    %plot(YMagCas,P_at_2Cas,'k*')
end




