function [ Out,Correlation ] = Cross_Corr_Ranked( f,g )
%Cross_Corr  This function cross correlates the given vectors
f=transpose(f);

%% Pre-allocating for speed
L=size(g,2);             %Number of FBGs
L2=size(f,2)*2-1;        %Size of Correlation Vector
Out=zeros(2,L);          %Output Pre-Allocating
Correlation=zeros(L2,L); %Correlation Vector Pre-Allocating
ranks=zeros(1,L);        %Shape Ranking Pre-Allocating
gnew=g;                  %Temporary variable for reference shapes
fnew=f;                  %Temporary variable for measured spectrums

%% Looping through each FBG
for i=1:1:L
    %Finding the Biggest Area to rank the FBGs
    for j=1:1:L
        ranks(j)=trapz(gnew(:,j)); %MATLAB function for numerical integration
    end
    [~,location]=max(ranks); %Figuring out which FBG has biggest area.

    %Cross Correlating
    Correlation(:,location)=xcorr(gnew(:,location),fnew); %Generates correlation vector
    [max_value,index]=max(Correlation(:,location));       %Finds the maximum of the correlation vector
    %   max_value=the value of the maximum point in the correlation vector
    %   index=the location of the maximum value in the correlation vector
    
    %Recording values to output from the function
    Out(1,location)=max_value;
    Out(2,location)=index;
    
    %Resetting for the next run
    count=1;
    
    %This loop subtracts the cross-correlated FBG reference spectrum from 
    %the from the measured spectrum, this is to prevent the subsequent 
    %(smaller) FBG from being found "inside the larger shape of the current
    %FBG.
    for k=size(f,2)-1-index:1:size(f,2)-1-index+size(g,1)-1
        fnew(k)=fnew(k)-(gnew(count,location));
        count=count+1;
    end
    
    %This removes the current FBG from the lineup of FBGs, so that it will
    %not be cross-correlated a second time.
    gnew(:,location)=0;
    
end

end

