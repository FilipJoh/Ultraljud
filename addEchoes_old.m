function [ image ] = addEchoes(data,dataNbr)

c=data{dataNbr}.SoundVel;                       %Get sound velocity
Signal=data{dataNbr}.Signal;                    %Get signal data
Elwidth=data{dataNbr}.ElementWidth;             %get Element width
image=zeros(2048,128);                          %matrix containing the final image
focalIncrement=2048/64;                         %increments for dynamic focus
    for k=1:64                                  % loop through all dynamic focuszones
        for j=1:128                             % loop through all imagelines
            for i=1:k/2                         % increase  number of elements used to create the image line as the depth increases.
                CompSignal1=sqrt(Elwidth^2+Signal(((k-1)*focalIncrement+1):k*focalIncrement,i+32,j).^2); %contribution from channels higher than 32
                CompSignal2=sqrt(Elwidth^2+Signal(((k-1)*focalIncrement+1):k*focalIncrement,32-1,j).^2); %contribution from channels lower than 32
                image(((k-1)*focalIncrement+1):k*focalIncrement,j)= image(((k-1)*focalIncrement+1):k*focalIncrement,j)+CompSignal1+CompSignal2; %Add all line contributions
            end
        end
    end
end

