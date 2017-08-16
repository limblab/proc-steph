

% Number of points 512
% Sampling frequency: Fs
% The only unknown is the size of the window

Fs=20;
[pxx,f]=pwelch(signal,256,0,512,20);
figure;loglog(f,pxx)
MillerFigure
