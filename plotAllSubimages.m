function[M]=plotAllSubfigures(data)

image=zeros(2048,64);
M=[];
figure;
for i=1:128
   image(:,:)=data{1}.Signal(:,:,i); 
   image=abs(hilbert(image));
   imagesc(image);
   colormap gray;
   M=[M getframe];
end
