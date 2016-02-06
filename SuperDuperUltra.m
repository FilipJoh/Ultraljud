load('PostRF_Carotid.mat')
%struct2cell(PostRF);
s=PostRF.Signal;

load('PostRF_Fantom');
f=PostRF.Signal;

%% Highpass FIR Filters 
%
% *Equiripple Design*

Fstop = 100;
Fpass = 120;
Astop = 65;
Apass = 0.1;
Fs = 1e3;

d = designfilt('highpassfir','StopbandFrequency',Fstop, ...
  'PassbandFrequency',Fpass,'StopbandAttenuation',Astop, ...
  'PassbandRipple',Apass,'SampleRate',Fs,'DesignMethod','equiripple');

%fvtool(d)
sd=double(s);

filtered=filtfilt(d,sd);

% figure;
% p=surf(abs(filtered))
% colormap jet
% set(p,'edgecolor','none')

figure;
imagesc(abs(hilbert(filtered)))
% set(p,'edgecolor','none')
colormap gray
% 
% figure;
% p=surf(abs(s))
% colormap jet
% set(p,'edgecolor','none')

figure;
imagesc(abs(hilbert(s)))
% set(p,'edgecolor','none')
colormap gray


%% next image

ff=filtfilt(d,double(f));

figure;
imagesc(abs(hilbert(ff)));
colormap gray;

figure;
imagesc(abs(hilbert(f)));
colormap gray
