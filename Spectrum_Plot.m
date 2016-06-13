function [ Out ] = Spectrum_Plot( f,g,Correlation_Results,fig,lambda )

%% Figure Setup and Measured Spectrum Plotting
h=figure('units','normalized','outerposition',[0 0 1 1]);              % Generates the figure window and size
plot(lambda,f,'Color','b','LineWidth',2.5)                             % Plots the measured spectrum
xlim([1561.5 1564.5]);                                                 % Plot window
ylim([-50 500]);                                                       % Plot window
xlabel('Wavelength (nm)')                                              % x axis label
ylabel('Intensity (AU)')                                               % y axis label
str=['Measurement ',num2str(fig)];                                     % Generating figure title
title(str)                                                             % Figure title
set(gca,'FontSize',18)                                                 % Axis marks font size
set(findall(gcf,'type','text'),'FontSize',18)                          % Label font size
frmt=['k','r','g','m','c','y'];                                        % Color vector for use later
hold on

%% Plotting Reference Spectra
Out=zeros(size(g,2),1);
for i=1:1:size(g,2)   %Cycling through each cross-correlated FBG vector.                           
    tshape=lambda(size(lambda,1)-Correlation_Results(2,i)+1:size(lambda,1)-Correlation_Results(2,i)+size(g,1));
    plot(tshape,g(:,i),'--','Color',frmt(i),'LineWidth',2.5)
    Out(i)=tshape(1);
end
legend('Full Spectrum','FBG Profile')

%% Output File Format
strpdf=['.\','Measurement_',num2str(fig),'.pdf'];
streps=['.\','Measurement_',num2str(fig),'.eps'];
strfig=['Measurement_',num2str(fig),'.fig'];

%% Enable this section to save the generated figures
%print(h,strpdf,'-dpdf')
%print(h,streps,'-depsc')
%savefig(h,strfig)

end

