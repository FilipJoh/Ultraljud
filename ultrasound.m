clear all
% close all
% % data = struct2cell(load('PostRF_Carotid.mat'));
% % data = struct2cell(load('PostRF_Fantom.mat'));
data = struct2cell(load('PreRF_BildA.mat'));
% data = struct2cell(load('PreRF_BildB.mat'));
%  data = struct2cell(load('PreRF_BildC.mat'));
% % data = struct2cell(load('PreRF_Cineloop.mat'));
%signal = data{1}.Signal;
%ima=double(rgb2gray(imread('Bild A.png')));
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


%% Highpass FIR Filters 
%
% *Equiripple Design*

% Fstop = 10; %60
% Fpass = 20; %120
% Astop = 65;
% Apass = 0.1;
% Fs = 1e3;
% d = designfilt('highpassfir', 'StopbandFrequency', Fstop, ...
%                'PassbandFrequency', Fpass, 'StopbandAttenuation', ...
%                Astop, 'PassbandRipple', Apass, 'SampleRate', Fs, ...
%                'DesignMethod', 'equiripple');

%fvtool(d)



%% butterworth filter

 

[a,b]=butter(10,0.05,'High');


%% plot stuff
image = zeros(2048,128); 
image = addUltraEchoes_2(data,1);

image = filtfilt(a,b,double(image));
image= abs(hilbert(image));

%M=plotAllSubimages(data)


%figure;

%diff=ima;%-image;

% imagesc(diff);
% colormap gray
figure;

imagesc(image);
colormap gray;

%figure;
%movie(M,10);

%axis equal
%axis([0 2048 0 128])


%%

% ThreeToTwo=squeeze(sum(data{1}.Signal,2)); 
% Bild2=abs(hilbert(ThreeToTwo)); 
% %figure; 
% 
% imagesc(Bild2); 
% colormap(gray) 
% axis equal
% axis([0 2048 0 128])



%  image = zeros(2048,64);
%  for i = 1:128
%      line = signal(:,:,i);
%      filtered_data = squeeze(filtfilt(d,line));
%      image = image + abs(hilbert(filtered_data));
%  end
% 
% figure
% imagesc(image)
% colormap gray 

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
