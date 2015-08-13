% plot pitch record of Eg3911 to show differences in record when entangled
% and not entangled. 

% load data
load('rw11_015aprh.mat')

% calculate pitch deviation from mean
[v,ph,mx,fr] = findflukes(Aw,Mw,fs,0.3,0.02,[2 8]);

% plot data: 
% Pitch Deviation and Normalized Depth
figure(1); clf
subplot('position',[0.1 0.55 0.4 0.4]); hold on
plot((1:length(ph(10*fs+11591:10*fs+12751)))/fs,ph(10*fs+11591:10*fs+12751),'b')
plot((1:length(ph(10*fs+11591:10*fs+12751)))/fs,-p(10*fs+11591:10*fs+12751)/max(p(10*fs+11591:10*fs+12751)),'color',[0.5 0.5 0.5])
text(4,0.8,'A','FontSize',18,'FontWeight','Bold')
ylabel('Pitch Deviation'); xlim([0 220]); ylim([-1 1])
subplot('position',[0.1 0.1 0.4 0.4]); hold on
plot((1:length(ph(7000*fs+60336:7000*fs+61496)))/fs,ph(7000*fs+60336:7000*fs+61496),'k')
plot((1:length(ph(7000*fs+60336:7000*fs+61496)))/fs,-p(7000*fs+60336:7000*fs+61496)/max(p(7000*fs+60336:7000*fs+61496)),'color',[0.5 0.5 0.5])
text(6,0.8,'C','FontSize',18,'FontWeight','Bold')
xlim([0 220]); ylim([-1 1])
ylabel('Pitch Deviation')
xlabel('Time (seconds)')

%%
figure(2); clf; hold on; box on
set(gcf,'position',[154 240 1300 420])
%subplot(211)
plot(ph(5200:6100),'color',[178/255 0/255 14/255])
%subplot(212)
plot(ph(8500:9400),'k')
xlabel('Time (samples)')
ylabel('Pitch deviation')

before = [11.4087301587302;33.2341269841270;54.0674603174603;71.9246031746032;90.7738095238095;125.496031746032;187.996031746032;211.805555555556;235.615079365079;257.440476190476;278.273809523810;297.123015873016;314.980158730159;330.853174603175;347.718253968254;377.480158730159;397.321428571429;423.115079365079;446.924603174603;466.765873015873;484.623015873016;503.472222222222;518.353174603175;535.218253968254;554.067460317460;578.869047619048;601.686507936508;613.591269841270;636.408730158730;659.226190476191;678.075396825397;694.940476190476;707.837301587302;741.567460317460;765.376984126984;781.250000000000;795.138888888889;811.011904761905;839.781746031746;891.369047619048;];
after = [17.3611111111111;36.2103174603174;56.0515873015873;73.9087301587302;93.7500000000000;112.599206349206;131.448412698413;150.297619047619;170.138888888889;188.988095238095;205.853174603175;224.702380952381;244.543650793651;263.392857142857;282.242063492064;305.059523809524;325.892857142857;346.726190476191;365.575396825397;386.408730158730;406.250000000000;428.075396825397;447.916666666667;466.765873015873;487.599206349206;506.448412698413;525.297619047619;544.146825396825;562.996031746032;579.861111111111;596.726190476191;614.583333333333;632.440476190476;649.305555555556;667.162698412698;685.019841269841;701.884920634921;718.750000000000;736.607142857143;754.464285714286;772.321428571429;788.194444444445;806.051587301587;819.940476190476;835.813492063492;851.686507936508;868.551587301587;885.416666666667;];
plot(before,0.2,'r.',after,0.18,'k.')


%%
figure(3); clf; hold on; box on
set(gcf,'position',[154 0 1300 420],'PaperPositionMode','auto','color','white')
%plot(ph(11277:11640),'k')
plot(ph(8500:8900),'k','LineWidth',2)
%plot(ph(12285:12550),'k')
%plot(ph(12685:13100),'k')


% figure(4); clf; hold on
%plot(ph(4775:5900),'r')
% plot(ph(3220:4000),'r')
plot(ph(5600:6000),'color',[178/255 0/255 14/255],'LineWidth',2)
xlim([0 400])
%ylim([-0.3 0.3])
xlabel('Time (samples)','FontSize',18)
ylabel('Pitch deviation','FontSize',18,'Rotation',0,'Position',[-28 0.095 1])
set(gca,'TickLength',[0 0],'XTick',[0; 400],'Ytick',[-0.4; 0; 0.6],'FontSize',18)

after = [17.1875000000000;36.8303571428572;55.5803571428571;74.3303571428572;94.4196428571429;111.830357142857;131.473214285714;150.223214285714;170.312500000000;188.616071428571;206.473214285714;224.776785714286;244.419642857143;263.169642857143;283.258928571429;305.580357142857;325.669642857143;346.651785714286;366.294642857143;385.937500000000;];
before = [22.0982142857143;45.7589285714286;66.2946428571429;84.1517857142857;102.901785714286;118.080357142857;135.044642857143;153.794642857143;176.116071428571;202.455357142857;213.616071428571;236.383928571429;258.258928571429;278.794642857143;294.866071428572;308.258928571429;320.312500000000;342.187500000000;365.848214285714;381.473214285714;394.866071428571];

plot(before,0.24,'.','color',[178/255 0/255 14/255],'MarkerSize',15)
plot(after,0.22,'k.','MarkerSize',15)

% print('-depsc','PitchDeviation_3911')

%% Eg 4057
load('eg14_047aprh.mat')

% calculate pitch deviation from mean
[v,ph,mx,fr] = findflukes(Aw,Mw,fs,0.3,0.02,[2 8]);

%% plot data
figure(1);
subplot('position',[0.55 0.55 0.4 0.4]); hold on
% ZOOM IN on one dive, consistent tag position, High drag
plot((1:length(ph(11350*fs+3850:11350*fs+7450)))/fs,ph(11350*fs+3850:11350*fs+7450),'b'); 
plot((1:length(ph(11350*fs+3850:11350*fs+7450)))/fs,-p(11350*fs+3850:11350*fs+7450)/max(p(11350*fs+3850:11350*fs+7450)),'color',[0.5 0.5 0.5])
xlim([0 700]); ylim([-1 1])
text(10,0.82,'B','FontSize',18,'FontWeight','Bold')

% ZOOM IN on one dive, consistent tag position, Low Drag
subplot('position',[0.55 0.1 0.4 0.4]); hold on
plot((1:length(ph(410*fs+10500:410*fs+14100)))/fs,ph(410*fs+10500:410*fs+14100),'k')
plot((1:length(ph(410*fs+10500:410*fs+14100)))/fs,-p(410*fs+10500:410*fs+14100)/max(p(410*fs+10440:410*fs+14100)),'color',[0.5 0.5 0.5])
xlabel('Time (seconds)')
xlim([0 700]); ylim([-1 1])
text(20,0.82,'D','FontSize',18,'FontWeight','Bold')

adjustfigurefont

cd C:\Users\Julie\Documents\MATLAB\Eg4057\AnalysisFigs
print('DiveFlukeCompare','-dtiff')
%%

figure(5); clf; hold on; box on
set(gcf,'position',[131 203 1300 420])
% HIGH DRAG
plot(ph(11350*fs+3838:11350*fs+6767),'color',[178/255 0/255 14/255]); 
% LOW DRAG
plot(ph(410*fs+10440:410*fs+13369),'k')
xlabel('Time (samples)')
ylabel('Pitch deviation')

%before = [11.4087301587302;33.2341269841270;54.0674603174603;71.9246031746032;90.7738095238095;125.496031746032;187.996031746032;211.805555555556;235.615079365079;257.440476190476;278.273809523810;297.123015873016;314.980158730159;330.853174603175;347.718253968254;377.480158730159;397.321428571429;423.115079365079;446.924603174603;466.765873015873;484.623015873016;503.472222222222;518.353174603175;535.218253968254;554.067460317460;578.869047619048;601.686507936508;613.591269841270;636.408730158730;659.226190476191;678.075396825397;694.940476190476;707.837301587302;741.567460317460;765.376984126984;781.250000000000;795.138888888889;811.011904761905;839.781746031746;891.369047619048;];
%after = [17.3611111111111;36.2103174603174;56.0515873015873;73.9087301587302;93.7500000000000;112.599206349206;131.448412698413;150.297619047619;170.138888888889;188.988095238095;205.853174603175;224.702380952381;244.543650793651;263.392857142857;282.242063492064;305.059523809524;325.892857142857;346.726190476191;365.575396825397;386.408730158730;406.250000000000;428.075396825397;447.916666666667;466.765873015873;487.599206349206;506.448412698413;525.297619047619;544.146825396825;562.996031746032;579.861111111111;596.726190476191;614.583333333333;632.440476190476;649.305555555556;667.162698412698;685.019841269841;701.884920634921;718.750000000000;736.607142857143;754.464285714286;772.321428571429;788.194444444445;806.051587301587;819.940476190476;835.813492063492;851.686507936508;868.551587301587;885.416666666667;];
%plot(before,0.2,'r.',after,0.18,'k.')
