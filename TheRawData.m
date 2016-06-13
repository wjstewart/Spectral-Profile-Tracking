
i=0;
%% Raw Data
i=i+1;
disp(['Spec ',num2str(i)])
tdfread('sample_1.txt');
s01=Conv_Wavelength(x,y);
s(:,1)=s01(:,1);
s(:,2)=s01(:,2);

i=i+1;
disp(['Spec ',num2str(i)])
tdfread('sample_2.txt');
s02=Conv_Wavelength(x,y);
s(:,3)=s02(:,1);
s(:,4)=s02(:,2);

i=i+1;
disp(['Spec ',num2str(i)])
tdfread('sample_3.txt');
s03=Conv_Wavelength(x,y);
s(:,5)=s03(:,1);
s(:,6)=s03(:,2);

i=i+1;
disp(['Spec ',num2str(i)])
tdfread('sample_4.txt');
s04=Conv_Wavelength(x,y);
s(:,7)=s04(:,1);
s(:,8)=s04(:,2);

i=i+1;
disp(['Spec ',num2str(i)])
tdfread('sample_5.txt');
s05=Conv_Wavelength(x,y);
s(:,9)=s05(:,1);
s(:,10)=s05(:,2);

i=i+1;
disp(['Spec ',num2str(i)])
tdfread('sample_6.txt');
s06=Conv_Wavelength(x,y);
s(:,11)=s06(:,1);
s(:,12)=s06(:,2);

i=i+1;
disp(['Spec ',num2str(i)])
tdfread('sample_7.txt');
s07=Conv_Wavelength(x,y);
s(:,13)=s07(:,1);
s(:,14)=s07(:,2);

i=i+1;
disp(['Spec ',num2str(i)])
tdfread('sample_8.txt');
s08=Conv_Wavelength(x,y);
s(:,15)=s08(:,1);
s(:,16)=s08(:,2);



%% Clean up
clear x y s01 s02 s03 s04 s05 s06 s07 s08 i
clc