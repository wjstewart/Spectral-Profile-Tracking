function [ spectrum ] = Conv_Wavelength( x,y )
% This function converts raw data from the Micron Optics SM-130 interogator
% to an array of reflectivities at given wavelengths

%This part maps out the Micron Optics Range 1510nm to 1590nm
s=size(x,1);
dnm=(1590-1510)/s;

%This part assigns the wavelength-reflectivities relationship
%   Column 1 is wavelength
%   Column 2 is the light intensity at that wavelength(AU)
spectrum(:,1)=1510+x*dnm;
spectrum(:,2)=y;

end

