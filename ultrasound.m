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



%% load in correct data. 


%% butterworth filter
load('Matrices');
imagProc=BeforeFiltering;

 

[a,b]=butter(10,0.05,'High');


%% plot stuff
lowest=1000;
M=[];
Mov=[];
for i=1:32
image = zeros(2048,128); 
image = addUltraEchoes_2(data,1,i);

image = filtfilt(a,b,double(image));
image= abs(hilbert(image));


%M=plotAllSubimages(data)

imagProc=filtfilt(a,b,double(imagProc));
imagProc= abs(hilbert(imagProc));


%figure;
figure;
diff=abs(imagProc-image);
 if max(max(diff))<lowest
     lowest=max(max(diff));
     lowestindex=i;
 end
 imagesc(diff);
 title('difference')
  M=[M getframe];
  close all

 
figure;

imagesc(image);
colormap gray;
title('Our image')
 Mov=[Mov getframe];
 close all;
 end
figure;
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
