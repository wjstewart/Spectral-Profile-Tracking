clear all
close all
clc

%% FBG Shapes
%This is where your FBG data is put in.
Shape_Determination

%% Cross-Correlation
count=0; loc=zeros(size(s,2)/2,size(FBG,2));
for i=2:2:size(s,2)
        %Iterating a Counting Variable
    count=count+1;
    
        %Cross Correlation Analysis
    [Correlation_Results,Correlation]=Cross_Corr_Ranked(s(:,i),FBG);
    
        %Plotting Individual Spetra
    [loc(count,:)]=Spectrum_Plot(s(:,i),FBG,Correlation_Results,count,s(:,i-1));
    
        %Calculating Each FBG Spectral Location
    loc(count,:)=loc(count,:)+halfwidth;
end

%% Data Output
count=0; output=zeros(size(s,2)/2,size(FBG,2)*2);
for i=1:2:size(FBG,2)*2
        %Iterating a Counting Variable
    count=count+1;
    
        %Spacing Out the FBG Locations
    output(:,i)=loc(:,count);
    
        %Calculating the FBG Shift amounts
    for j=1:1:size(s,2)/2
        
        if j==1 %This Sets the First Shift to be Zero.
            output(j,i+1)=0;
        else    %Each Shift is the Current Location Minus the Previous.
            output(j,i+1)=output(j,i)-output(j-1,i);
        end
    end
end

%Enable to write the Data to a .csv file.
%csvwrite('Data.csv',output);
%Format is of the form:
%   Column 1:FBG 1 location in spectrum
%   Column 2:delta_lambda between current location and previous location

%% Actual Strain Calculations (Varies for experiment conducted)
%Measured change in length of specimen:
delL=[85.13-84.14;85.81-84.14;86.20-84.14;86.45-84.14;87.28-84.14;87.84-84.14;88.25-84.14;89.19-84.14];
%Calculated strain from delL above:
Normalized=(delL+84.14)/84.14-1;
%From calibration done of system at time of experiment:
p=1000*[-0.169161572771762 0.040412766108891 1.561618980178803];
Actual_Strain(:,1)=p(1)*Normalized.^2+p(2)*Normalized+p(3);
Actual_Strain(:,2)=loc(1,2);

%% Trendline
%This is the results from the Cross-Correlation:
Measured_Strain(:,1)=loc(:,1);
Measured_Strain(:,2)=loc(:,2);
%Calculating the Root-Mean_Square Error for the Cross-Correlation:
RMSError=zeros(1,size(FBG,2));
for k=1:1:size(FBG,2)
    diff=Actual_Strain-Measured_Strain;
    avg=mean(diff(:,k));
    deviation=(diff(:,k)-avg).^2/size(diff,1);
    RMSError(k)=sqrt(sum(deviation));
end

%% Error Plotting
close all
Error_Plot(Actual_Strain,Measured_Strain)

