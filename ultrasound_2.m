clear all
close all
% % data = struct2cell(load('PostRF_Carotid.mat'));
% % data = struct2cell(load('PostRF_Fantom.mat'));
% data = struct2cell(load('PreRF_BildA.mat'));
% data = struct2cell(load('PreRF_BildB.mat'));
data = struct2cell(load('PreRF_BildC.mat'));
% % data = struct2cell(load('PreRF_Cineloop.mat'));
signal = data{1}.Signal;

Fpass = 60;
Fstop = 120;
Apass = 1;
Astop = 65;
Fs = 5e3;

d = designfilt('lowpassfir', ...
  'PassbandFrequency',Fpass,'StopbandFrequency',Fstop, ...
  'PassbandRipple',Apass,'StopbandAttenuation',Astop, ...
  'DesignMethod','equiripple','SampleRate',Fs);

image = zeros(2048,64);
for i = 1:128
    line = signal(:,:,i);
    filtered_data = squeeze(filtfilt(d,line));
    image = image + abs(hilbert(filtered_data));
end

figure
imagesc(image)
colormap gray 

% line = signal(:,:,1);
% 
% % imagesc(signal)
% % colormap gray
% 
% Fpass = 60;
% Fstop = 120;
% Apass = 1;
% Astop = 65;
% Fs = 5e3;
% 
% d = designfilt('lowpassfir', ...
%   'PassbandFrequency',Fpass,'StopbandFrequency',Fstop, ...
%   'PassbandRipple',Apass,'StopbandAttenuation',Astop, ...
%   'DesignMethod','equiripple','SampleRate',Fs);
% 
% filtered_data = squeeze(filtfilt(d,sum(line,2)));
% image = abs(hilbert(filtered_data));
% 
% figure
% imagesc(image)
% colormap gray
% 
% % figure
% % plot(filtered_data(:,1))
% 
% unfiltered_data=squeeze(sum(line,2)); 
% image2=abs(hilbert(unfiltered_data)); 
% figure
% imagesc(image2)
% colormap(gray) 