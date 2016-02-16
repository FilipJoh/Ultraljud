function [ image ] = addEchoes(data,dataNbr)

c = data{dataNbr}.SoundVel;
signal = data{dataNbr}.Signal;
elWidth = data{dataNbr}.ElementWidth;
sampFreq = data{dataNbr}.SampleFreq;
deadZone = data{dataNbr}.DeadZone;
nmbSamp = 2048;
nmbEl = 128;

image = zeros(nmbSamp, nmbEl);
sampleLength = nmbSamp/sampFreq;
mu = nmbEl/4;
W = normpdf(1:nmbEl/2,mu,mu/8)./normpdf(mu,mu,mu/8);

for i = 1:nmbEl
    for j = 1:nmbSamp
        nbrOfElements=ceil(j/64);
        for k = 1:nbrOfElements
            dt = sqrt(((elWidth*(k-1))/c)^2 + (deadZone/c+sampleLength*j)^2);           %time from echo to element k
            inc = floor(dt/sampleLength);
            image(inc,i) = image(inc,i) + W(32+k)*signal(inc,32+k,i) + W(33-k)*signal(inc,33-k,i);
        end
    end
end

end

