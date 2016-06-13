function [  ] = Error_Plot( Actual,Measured )
%% Pre-plotting Preparation
%This is setting arbitrary time steps
s=size(Actual,1);
time=transpose(0:1:s-1);

%% Plotting
h=figure('units','normalized','outerposition',[0 0 1 1]);
hold on
plot(time,Actual(:,1),'Color','b','LineWidth',2.5)
plot(time,Actual(:,2),'Color','r','LineWidth',2.5)
plot(time,Measured(:,1),'--k','LineWidth',2.5)
plot(time,Measured(:,2),'-.k','LineWidth',2.5)

%% Format Plot
xlabel('Time (AU)','FontSize',30)
ylabel('Spectral Location (nm)','FontSize',30)
legend('Actual FBG 1 Location','Actual FBG 2 Location','Measured FBG 1 Location','Measured FBG 2 Location','Location','NorthWest')
set(gca,'FontSize',30)
set(h,'PaperSize',[18 15])
set(h,'PaperPosition',[.25 .45 17.5 11.5])

%% Output File Format
strpdf=['.\','Error_Plot.pdf'];
streps=['.\','Error_Plot.eps'];
strfig=['Error_Plot.fig'];

%% Enable this section to save generated figure
%print(h,strpdf,'-dpdf')
%print(h,streps,'-depsc')
%savefig(h,strfig)

end

