% Markos Delaportas

clc; clear; close all;

N = 512;
n = 0:N-1;

bw = 1/4;
x = sinc((n-N/2)*bw);

rng default

SNR = 20;
noise = randn(size(x))*std(x)/db2mag(SNR);
x = x + noise;

periodogram(x)

wc = pi/2;

x1 = x.*cos(wc*n)*sqrt(2);

periodogram(x1)
legend('Modulated')

Hhilbert = designfilt('hilbertfir','FilterOrder',64, ...
    'TransitionWidth',0.1);

xh = filter(Hhilbert,x);

gd = mean(grpdelay(Hhilbert));
xh = xh(gd+1:end);
eh = zeros(size(x));
eh(1:length(xh)) = xh;

x2 = eh.*sin(wc*n)*sqrt(2);

y = x1+x2;

periodogram([x1;y]')
legend('Modulated','SSB')

ym = y.*cos(wc*n)*sqrt(2);

periodogram(ym)
legend('Downconverted')

d = designfilt('lowpassfir','FilterOrder',64, ...
    'CutoffFrequency',0.5);
dem = filter(d,ym);

gd = mean(grpdelay(d));
dem = dem(gd+1:end);

dm = zeros(size(x));
dm(1:length(dem)) = dem;

periodogram([x;dm]')
legend('Original','Recovered')

plot(n,[x;dm]')
legend('Original','Recovered')
axis tight