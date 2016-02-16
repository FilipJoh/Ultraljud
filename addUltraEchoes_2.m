function [ image ] = addUltraEchoes_2(data,dataNbr)

c = data{dataNbr}.SoundVel;
signal = data{dataNbr}.Signal;
elWidth = data{dataNbr}.ElementWidth;
sampFreq = data{dataNbr}.SampleFreq;
deadZone = data{dataNbr}.DeadZone;
nmbSamp = 2048;
nmbEl = 128;

image = zeros(nmbSamp, nmbEl);
% sampleTime=nmbSamp/(sampFreq);%*%2); %1/sampFreq;%

w = hamming(nmbEl);
mu=32;


for i = 1:nmbEl
    for j = 1:nmbSamp
        nbrOfElements=ceil(j/64);
        %nmbEl/4
        scanTime=j*1/sampFreq;  % Samples to time conversion of data
        scanTimeTot=scanTime+2*c*deadZone; % Total time from that the wave left array to reception.
        scanDistanceTot=scanTimeTot/(2*c); %Converting the total scantime to a distance between tranduce array and refelction point        
        
        for k = 1:32%nbrOfElements
            lateralDistance=(k-1/2)*elWidth; % Compensation for that none of the elements are "lin the line"
            HScanDistancsTot=sqrt(lateralDistance^2+scanDistanceTot^2); % Distance to the same reflection the elemet one "lateral" distance from the center axis.
            offsetDistance=HScanDistancsTot-scanDistanceTot; % The traveldistance differnce from reflection point to laterally offsetted element.
            offsetTime=(2*offsetDistance)/c; %compensation for total travel distance (Double that from just reflection point to element) and coversion to time by diviesion of propagation velocity
            offsetSample = offsetTime*sampFreq; % convert offset time to samples.            
            inc=floor(j+offsetSample)+1;%offsetSamples); % create matrix lookup increment.
            if inc>nmbSamp
                inc=nmbSamp;
            end
            image(j,i) = image(j,i) + signal(inc,32+k,i)*normpdf(32+k,mu,nbrOfElements/(k/8+1))./normpdf(mu,mu,nbrOfElements/(k/8+1)) + signal(inc, 33-k,i)*normpdf(33-k,mu,nbrOfElements/(k/8+1))./normpdf(mu,mu,nbrOfElements/(k/8+1));

%             image(inc,i) = image(inc,i) + ((signal(inc,32+k,i)))*normpdf(32+k,mu,nbrOfElements/4)./normpdf(mu,mu,nbrOfElements/4) + (signal(inc, 33-k,i))*normpdf(33-k,mu,nbrOfElements/4)./normpdf(mu,mu,nbrOfElements/4);
        end
    end
end

%*normpdf(k,mu,nbrOfElements)

%figure;
%plot(linspace(1,64),normpdf(linspace(1,64),mu,nbrOfElements/8)./normpdf(mu,mu,nbrOfElements/8))
end


