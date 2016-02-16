function [ image ] = addUltraEchoes(data,dataNbr)

c = data{dataNbr}.SoundVel;
signal = data{dataNbr}.Signal;
elWidth = data{dataNbr}.ElementWidth;
sampFreq = data{dataNbr}.SampleFreq;
deadZone = data{dataNbr}.DeadZone;
nmbSamp = 2048;
nmbEl = 128;

image = zeros(nmbSamp, nmbEl);
sampleLength = nmbSamp/(sampFreq*2);

w = hamming(nmbEl);
mu=32;


for i = 1:nmbEl
    for j = 1:nmbSamp
        nbrOfElements=ceil(j/64);
        %nmbEl/4
        for k = 1:32%nbrOfElements
            dt = sqrt(((elWidth*(k))/c)^2 + (deadZone/c+sampleLength*j)^2);           %time from echo to element k
            inc = floor(dt/sampleLength);
            offset=nmbSamp-inc;
            if nmbSamp-inc==0
               offset=1;
            end
            offset;
            image(offset,i) = image(offset,i) + ((signal(offset,32+k,i)))*normpdf(32+k,mu,nbrOfElements/4)./normpdf(mu,mu,nbrOfElements/4) + (signal(offset, 33-k,i))*normpdf(33-k,mu,nbrOfElements/4)./normpdf(mu,mu,nbrOfElements/4);
        end
    end
end

%*normpdf(k,mu,nbrOfElements)
%figure;
%plot(linspace(1,64),normpdf(linspace(1,64),mu,nbrOfElements/4)./normpdf(mu,mu,nbrOfElements/4))
end


