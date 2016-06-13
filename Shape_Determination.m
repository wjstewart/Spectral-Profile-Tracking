%% Import First Measured Spectrum
clear all
close all
clc

tdfread('sample_1.txt');
s01=Conv_Wavelength(x,y);
s(:,1)=s01(:,1);
s(:,2)=s01(:,2);

%% Determining FBG Shapes
%Preparing to plot the spectrum
c(:,1)=s(:,1);
c(:,2)=s(:,2);
c(:,3)=1:1:size(c,1);

%These outline the FBG locations
st1=13548; %Start of FBG 1
ed1=13742; %End of FBG 1
st2=13742; %Start of FBG 2
ed2=13978; %End of FBG 2
%st3=num; %Enable these to add FBGs 
%ed3=num;  

%%Enable this section to modify st1,ed1,st2,ed2,...
% plot(c(:,3),c(:,2))
% keyboard

%Cutting out the FBG shapes defined by the above st# and ed# locations
count=0;
for i=st1:1:ed1  %This iterates the span of FBG1
    count=count+1;
    FBG1(count,1)=c(i,1);
    FBG1(count,2)=c(i,2);
end
count=0;
for j=st2:1:ed2  %This iterates the span of FBG2
    count=count+1;
    FBG2(count,1)=c(j,1);
    FBG2(count,2)=c(j,2);
end
f1=size(FBG1,1);  %Assigning Variables for the size of the two FBGs 
f2=size(FBG2,1);  %Assigning Variables for the size of the two FBGs 

%% Enable this section to verify FBG Shape choices (st1,ed1,st2,ed2,...)
% figure('units','normalized','outerposition',[0 0 1 1]);
% hold on
% plot(FBG1(:,1),FBG1(:,2),'Color','b','LineWidth',2.5)
% plot(FBG2(:,1),FBG2(:,2),'Color','g','LineWidth',2.5)
% xlabel('Wavelength (nm)')
% ylabel('Intensity (AU)')
% set(gca,'FontSize',18)
% keyboard

%% Padding with "zeros" such that FBG1 and FBG2 are the same length
%The loop finds the average reflectivity after the last FBG in the spectrum
sum=0;
for l=ed2+1:1:size(s,1)        
    sum=sum+c(l,2);  
end                      
avg=sum/(size(c,1)-(ed2+1));                 

%The shorter FBG is padded with the avg found in the loop above
for m=1:1:f2
    if m<=f1
        FBG1_new(m,2)=FBG1(m,2);
        FBG2_new(m,2)=FBG2(m,2);
    end
    if m>f1
        FBG1_new(m,2)=avg;
        FBG2_new(m,2)=FBG2(m,2);
    end
end

%This part makes sure that the reflectivities are >=0
FBG(:,1)=FBG1_new(:,2)-avg;
FBG(:,2)=FBG2_new(:,2)-avg;

%% Width Analysis
%This section of code is used to find the midpoint of the FBG shape. 
%This is used later to track the change in FBG location needed to determine
%the strain.
for j=1:1:size(FBG,2)
    [~,index]=max(FBG(:,j));
    ind(:,j)=index;
end
halfwidth(:,1)=c(st1+ind(1),1)-c(st1,1);
halfwidth(:,2)=c(st2+ind(2),1)-c(st2,1);

%% Enable to verify modifications to FBG shape arrays has been successful.
% figure
% hold on
% plot(1:1:f2,FBG1_new(:,2)-avg,'Color','b')
% plot(1:1:f2,FBG2_new(:,2)-avg,'Color','g')
% xlabel('Wavelength (nm)')
% ylabel('Intensity (AU)')
% keyboard

%% This part brings in all the rest of the data
TheRawData

%This loop reformats the new measured spectrum data using the avg
%calculated above.
for n=2:2:size(s,2)
    s(:,n)=s(:,n)-avg;
end


%% Clearing Variables
clear tar01 tar02 count i j c ans avg1 avg2 l k x y j maxim index ind
clear fin sum m f1 f2 FBG1_new FBG2_new FBG1 FBG2 h s01 n st1 st2 ed1 ed2

