%% Influence of output threshold on "gain" of estimated linear system

%Create input
X=randn(10000,1);
SRate=200;
t=(0:9999)/SRate;

%System filter
[b,a]=butter(2,0.1);

%Baseline o/p; STD ~ 0.1
Y=filter(b,a,X);

%% Create new outputs with different amplitudes. Threshold all at 0.15
% thr=0.15;
% 
% amp=1;
% YY=amp*Y-thr;      %shift to place thr at zero
% Y1=(abs(YY)+YY)/2;  %half-wave rectify
% 
% amp=1.5;
% YY=amp*Y-thr;      %shift to place thr at zero
% Y2=(abs(YY)+YY)/2;  %half-wave rectify
% 
% amp=2;
% YY=amp*Y-thr;      %shift to place thr at zero
% Y3=(abs(YY)+YY)/2;  %half-wave rectify
% 
% amp=3;
% YY=amp*Y-thr;      %shift to place thr at zero
% Y4=(abs(YY)+YY)/2;  %half-wave rectify


%% same amplitude of signal, different threshold

thr=0.1;
amp=1;
YY=amp*Y-thr;      %shift to place thr at zero
Y1=(abs(YY)+YY)/2;  %half-wave rectify

thr=0.2;
amp=1;
YY=amp*Y-thr;      %shift to place thr at zero
Y2=(abs(YY)+YY)/2;  %half-wave rectify

thr=0.3;
amp=1;
YY=amp*Y-thr;      %shift to place thr at zero
Y3=(abs(YY)+YY)/2;  %half-wave rectify

thr=0.4;
amp=1;
YY=amp*Y-thr;      %shift to place thr at zero
Y4=(abs(YY)+YY)/2;  %half-wave rectify

%% Check out histograms for non-zero values
figure(1)
h(4)=subplot(221);hist(Y1(Y1>0))
h(3)=subplot(222);hist(Y2(Y2>0))
h(2)=subplot(223);hist(Y3(Y3>0))
h(1)=subplot(224);hist(Y4(Y4>0))
linkaxes(h)

%% Estimate transfer functions
[S1,f]=spectrum(X,Y1,512,256,[],SRate);
[S2,f]=spectrum(X,Y2,512,256,[],SRate);
[S3,f]=spectrum(X,Y3,512,256,[],SRate);
[S4,f]=spectrum(X,Y4,512,256,[],SRate);

figure(2)
subplot(211)
loglog(f,abs([S1(:,4) S2(:,4) S3(:,4) S4(:,4)]))
ylabel 'Frequency Response Gain'
legend('Amp1 (lowest)','Amp2','Amp3','Amp4 (highest)')

subplot(212)
semilogx(f,[S1(:,5) S2(:,5) S3(:,5) S4(:,5)])
ylabel 'Frequency Response Coherence'
xlabel 'Frequency (Hz)'


figure; hold on
plot(Y1);plot(Y2);plot(Y3);plot(Y4)

