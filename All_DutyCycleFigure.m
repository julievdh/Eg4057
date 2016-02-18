% plot fluke strokes ABCD panel of Eg 3911 low/high drag and Eg 4057
% low/high drag 

%% load data
% load tags
rw015a = load('rw11_015aprh.mat');
eg047a = load('eg14_047aprh.mat');

% set time periods
rw015a.p1 = [1 6667]; % entangled
rw015a.p2 = [6668 15248]; % disentanglement
rw015a.p3 = [15248 22268]; % recovery
eg047a.p1 = [410 4711]; % consistent tag position, entangled
eg047a.p2 = [5133 8571]; % consistent tag position, until disentanglement begins
eg047a.p3 = [11350 13250]; % consistent tag position, entangled + telemetry

% create time vectors
rw015a.t = (1:length(rw015a.p))/rw015a.fs;
eg047a.t = (1:length(eg047a.p))/eg047a.fs;

fs = 5;
%%

% calculate pitch deviation from mean. ignore fluke stroke info here.
[rw015a.v,rw015a.ph,rw015a.mx,rw015a.fr] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 8]);
[eg047a.v,eg047a.ph,eg047a.mx,eg047a.fr] = findflukes(eg047a.Aw,eg047a.Mw,fs,0.2,0.001,[0.7 8]);

rw015a.T = finddives(rw015a.p,fs,5,1);              % find dives
eg047a.T = finddives(eg047a.p,fs,5,1);


%% What if "periods" are descents and ascents and bottoms and surfaces?
load('rw015a_descasc')
figure(1); clf;
subplot(241); hold on; % title('3911 low descent'); 
xlim([0 5]); ylim([-1 1.25]); set(gca,'Position',[0.1300    0.5838    0.1338    0.3412])
[dur_lowdesc_3911,maxtab,mintab] = dutycycleplot_phase([rw015a.T(54:end,1) rw015a.T(54:end,1)+end_desc(54:end)'],rw015a.ph,fs);
text(0.5,-.85,strcat(num2str(nanmean(dur_lowdesc_3911(:)),'%.2f'),' \pm ',num2str(nanstd(dur_lowdesc_3911(:)),'%.2f')),'FontSize',10)

subplot(245); hold on; % title('3911 high descent'); 
xlim([0 5]); ylim([-1 1.25]); set(gca,'Position',[0.1300    0.1100    0.1338    0.3412])
[dur_highdesc_3911,maxtab,mintab] = dutycycleplot_phase([rw015a.T(1:53,1) rw015a.T(1:53,1)+end_desc(1:53)'],rw015a.ph,fs);
text(0.5,-.85,strcat(num2str(nanmean(dur_highdesc_3911(:)),'%.2f'),' \pm ',num2str(nanstd(dur_highdesc_3911(:)),'%.2f')),'FontSize',10)

subplot(243); hold on; % title('3911 low ascent'); 
xlim([0 5]); ylim([-1 1.25]); set(gca,'Position',[0.5422    0.5838    0.1338    0.3412])
[dur_lowasc_3911,maxtab,mintab] = dutycycleplot_phase([rw015a.T(54:end,1) rw015a.T(54:end,1)+start_asc(54:end)'],rw015a.ph,fs);
text(0.5,-.85,strcat(num2str(nanmean(dur_lowasc_3911(:)),'%.2f'),' \pm ',num2str(nanstd(dur_lowasc_3911(:)),'%.2f')),'FontSize',10)

subplot(247); hold on; % title('3911 high ascent');
xlim([0 5]); ylim([-1 1.25]); set(gca,'Position',[0.5422    0.1100    0.1338    0.3412])
[dur_highasc_3911,maxtab,mintab] = dutycycleplot_phase([rw015a.T(1:53,1) rw015a.T(1:53,1)+start_asc(1:53)'],rw015a.ph,fs);
text(0.5,-.85,strcat(num2str(nanmean(dur_highasc_3911(:)),'%.2f'),' \pm ',num2str(nanstd(dur_highasc_3911(:)),'%.2f')),'FontSize',10)

subplot(242); hold on; % title('3911 low bottom');
xlim([0 5]); ylim([-1 1.25]); set(gca,'Position',[0.3361    0.5838    0.1338    0.3412])
[dur_lowbot_3911,maxtab,mintab] = dutycycleplot_phase([rw015a.T(54:end,1)+end_desc(54:end)' rw015a.T(54:end,1)+start_asc(54:end)'],rw015a.ph,fs);
text(0.4,-.85,strcat(num2str(nanmean(dur_lowbot_3911(:)),'%.2f'),' \pm ',num2str(nanstd(dur_lowbot_3911(:)),'%.2f')),'FontSize',10)

subplot(246); hold on; % title('3911 high bottom'); 
xlim([0 5]); ylim([-1 1.25]); set(gca,'Position',[0.3361    0.1100   0.1338    0.3412])
[dur_highbot_3911,maxtab,mintab] = dutycycleplot_phase([rw015a.T(1:53,1)+end_desc(1:53)' rw015a.T(1:53,1)+start_asc(1:53)'],rw015a.ph,fs);
text(0.5,-.85,strcat(num2str(nanmean(dur_highbot_3911(:)),'%.2f'),' \pm ',num2str(nanstd(dur_highbot_3911(:)),'%.2f')),'FontSize',10)

subplot(244); hold on; % title('3911 low surface'); 
xlim([0 5]); ylim([-1 1.25]); set(gca,'Position',[0.7484   0.5838    0.1338    0.3412])
[dur_lowsurf_3911,maxtab,mintab] = dutycycleplot_phase([rw015a.T(54:end-1,1) rw015a.T(55:end,1)],rw015a.ph,fs);
text(0.5,-.85,strcat(num2str(nanmean(dur_lowsurf_3911(:)),'%.2f'),' \pm ',num2str(nanstd(dur_lowsurf_3911(:)),'%.2f')),'FontSize',10)

subplot(248); hold on; % title('3911 high surface');
xlim([0 5]); ylim([-1 1.25]); set(gca,'Position',[0.7484   0.1100    0.1338    0.3412])
[dur_highsurf_3911,maxtab,mintab] = dutycycleplot_phase([rw015a.T(1:52,1) rw015a.T(2:53,1)],rw015a.ph,fs);
text(0.5,-.85,strcat(num2str(nanmean(dur_highsurf_3911(:)),'%.2f'),' \pm ',num2str(nanstd(dur_highsurf_3911(:)),'%.2f')),'FontSize',10)


cd /Users/julievanderhoop/Documents/MATLAB/Eg4057/AnalysisFigs
print('PhaseDutyCycle_3911','-dsvg','-r300')

%%
figure(3); clf
subplot(241); hold on; % title('3911 low descent'); 
xlim([0 5]); ylim([-1.5 0.75])
set(gca,'YaxisLocation','right','ytick',[0 0.5],'xtick',[]); box on
histogram(dur_lowdesc_3911,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

subplot(245); hold on; % title('3911 high descent'); 
xlim([0 5]); ylim([-1.5 0.75])
set(gca,'YaxisLocation','right','ytick',[0 0.5],'xtick',[]); box on
histogram(dur_highdesc_3911,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

subplot(243); hold on; % title('3911 low ascent'); 
xlim([0 5]); ylim([-1.5 0.75])
set(gca,'YaxisLocation','right','ytick',[0 0.5],'xtick',[]); box on
histogram(dur_lowasc_3911,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

subplot(247); hold on; % title('3911 high ascent'); 
xlim([0 5]); ylim([-1.5 0.75])
set(gca,'YaxisLocation','right','ytick',[0 0.5],'xtick',[]); box on
histogram(dur_highasc_3911,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

subplot(242); hold on; % title('3911 low bottom'); 
xlim([0 5]); ylim([-1.5 0.75])
set(gca,'YaxisLocation','right','ytick',[0 0.5],'xtick',[]); box on
histogram(dur_lowbot_3911,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

subplot(244); hold on; % title('3911 low surface'); 
xlim([0 5]); ylim([-1.5 0.75]); 
set(gca,'YaxisLocation','right','ytick',[0 0.5],'xtick',[]); box on
histogram(dur_lowsurf_3911,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

subplot(246); hold on; % title('3911 high bottom'); 
xlim([0 5]); ylim([-1.5 0.75])
set(gca,'YaxisLocation','right','ytick',[0 0.5],'xtick',[]); box on
histogram(dur_lowsurf_3911,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

subplot(248); hold on; % title('3911 high surface'); 
xlim([0 5]); ylim([-1.5 0.75])
set(gca,'YaxisLocation','right','ytick',[0 0.5],'xtick',[]); box on
histogram(dur_highsurf_3911,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

print('PhaseDutyCycle_3911_2','-dsvg','-r300')
return
%% now for 4057
load('eg047a_descasc')
low = [1:6,8:12];
high = [13:15,18:20];
figure(2); clf; 
subplot(241); hold on; title('4057 low descent'); ylim([-1 1.25]); xlim([0 10])
[dur_lowdesc_4057,maxtab,mintab] = dutycycleplot_phase([eg047a.T(low,1) eg047a.T(low,1)+end_desc(low)'],eg047a.ph,fs);
text(0.5,-.8,strcat(num2str(nanmean(dur_lowdesc_4057(:)),'%.2f'),' \pm ',num2str(nanstd(dur_lowdesc_4057(:)),'%.2f')),'FontSize',10)
histogram(dur_lowdesc_4057,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

subplot(245); hold on; title('4057 high descent'); ylim([-1 1.25]); xlim([0 10])
[dur_highdesc_4057,maxtab,mintab] = dutycycleplot_phase([eg047a.T(high,1) eg047a.T(high,1)+end_desc(high)'],eg047a.ph,fs);
text(0.5,-.8,strcat(num2str(nanmean(dur_highdesc_4057(:)),'%.2f'),' \pm ',num2str(nanstd(dur_highdesc_4057(:)),'%.2f')),'FontSize',10)
histogram(dur_highdesc_4057,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

subplot(243); hold on; title('4057 low ascent'); ylim([-1 1.25]); xlim([0 10])
[dur_lowasc_4057,maxtab,mintab] = dutycycleplot_phase([eg047a.T(low,1) eg047a.T(low,1)+start_asc(low)'],eg047a.ph,fs);
text(0.5,-.8,strcat(num2str(nanmean(dur_lowasc_4057(:)),'%.2f'),' \pm ',num2str(nanstd(dur_lowasc_4057(:)),'%.2f')),'FontSize',10)
histogram(dur_lowasc_4057,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

subplot(247); hold on; title('4057 high ascent'); ylim([-1 1.25]); xlim([0 10])
[dur_highasc_4057,maxtab,mintab] = dutycycleplot_phase([eg047a.T(high,1) eg047a.T(high,1)+start_asc(high)'],eg047a.ph,fs);
text(0.5,-.8,strcat(num2str(nanmean(dur_highasc_4057(:)),'%.2f'),' \pm ',num2str(nanstd(dur_highasc_4057(:)),'%.2f')),'FontSize',10)
histogram(dur_highasc_4057,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

subplot(242); hold on; title('4057 low bottom'); ylim([-1 1.25]); xlim([0 10])
[dur_lowbot_4057,maxtab,mintab] = dutycycleplot_phase([eg047a.T(low,1)+end_desc(low)' eg047a.T(low,1)+start_asc(low)'],eg047a.ph,fs);
text(0.5,-.8,strcat(num2str(nanmean(dur_lowbot_4057(:)),'%.2f'),' \pm ',num2str(nanstd(dur_lowbot_4057(:)),'%.2f')),'FontSize',10)
histogram(dur_lowbot_4057,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

subplot(246); hold on; title('4057 high bottom'); ylim([-1 1.25]); xlim([0 10])
[dur_highbot_4057,maxtab,mintab] = dutycycleplot_phase([eg047a.T(high,1)+end_desc(high)' eg047a.T(high,1)+start_asc(high)'],eg047a.ph,fs);
text(0.5,-.8,strcat(num2str(nanmean(dur_highbot_4057(:)),'%.2f'),' \pm ',num2str(nanstd(dur_highbot_4057(:)),'%.2f')),'FontSize',10)
histogram(dur_highbot_4057,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

% this will have to be finagled because of timing
subplot(244); hold on; title('4057 low surface'); ylim([-1 1.25]); xlim([0 10])
[dur_lowsurf_4057,maxtab,mintab] = dutycycleplot_phase([eg047a.T(low(1:end-1),1) eg047a.T(low(2:end),1)],eg047a.ph,fs);
text(0.5,-.8,strcat(num2str(nanmean(dur_lowsurf_4057(:)),'%.2f'),' \pm ',num2str(nanstd(dur_lowsurf_4057(:)),'%.2f')),'FontSize',10)
histogram(dur_lowsurf_4057,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

subplot(248); hold on; title('4057 high surface'); ylim([-1 1.25]); xlim([0 10])
[dur_highsurf_4057,maxtab,mintab] = dutycycleplot_phase([eg047a.T(high(1:end-1),1) eg047a.T(high(2:end),1)],eg047a.ph,fs);
text(0.5,-.8,strcat(num2str(nanmean(dur_highsurf_4057(:)),'%.2f'),' \pm ',num2str(nanstd(dur_highsurf_4057(:)),'%.2f')),'FontSize',10)
histogram(dur_highsurf_4057,'binwidth',0.5,'displaystyle','stairs','edgecolor','k','normalization','probability')

print('PhaseDutyCycle_4057','-dtiff','-r300')


return

%% make figure
figure(10); clf; set(gcf,'position',[92 182 738 583])
% A: low drag/buoyancy fluke stroke duty cycle for Eg 3911
subplot('position',[0.12 0.57 0.4 0.4])
[dur_low_3911,maxtab,mintab] = dutycycleplot(rw015a.p3,rw015a.ph,fs); 
ylim([-1 1]); text(0.15,0.85,'A','FontSize',18,'FontWeight','Bold')
xlim([0 8]); text(5.3,-0.75,'3.37 \pm 0.65','FontSize',14)

% B: high drag/buoyancy fluke stroke duty cycle for Eg 3911
subplot('position',[0.57 0.57 0.4 0.4])
[dur_high_3911,maxtab,mintab] = dutycycleplot([rw015a.p1(1) rw015a.p2(2)],rw015a.ph,fs); 
ylim([-1 1]); text(0.15,0.85,'B','FontSize',18,'FontWeight','Bold')
xlim([0 8]); text(5.3,-0.75,'3.24 \pm 0.71','FontSize',14)

% C: low drag/buoyancy fluke stroke duty cycle for Eg 4057
subplot('position',[0.12 0.12 0.4 0.4])
[dur_low_4057_1,maxtab,mintab] = dutycycleplot(eg047a.p1,eg047a.ph,fs); 
[dur_low_4057_2,maxtab,mintab] = dutycycleplot(eg047a.p2,eg047a.ph,fs); 
dur_low_4057 = horzcat(dur_low_4057_1,dur_low_4057_2);
xlim([0 8]); ylim([-1 1]); text(0.15,0.85,'C','FontSize',18,'FontWeight','Bold')
text(5.3,-0.75,'5.02 \pm 2.83','FontSize',14)

% D: high drag/buoyancy fluke stroke duty cycle for Eg 4057
subplot('position',[0.57 0.12 0.4 0.4])
[dur_high_4057,maxtab,mintab] = dutycycleplot(eg047a.p3,eg047a.ph,fs); 
ylim([-1 1]); xlim([0 8]); text(0.15,0.85,'D','FontSize',18,'FontWeight','Bold')
[ax1,h1] = suplabel('Time (seconds)');
[ax2,h2] = suplabel('Pitch deviation from mean (deg)','y');
text(5.3,-0.75,'4.29 \pm 1.38','FontSize',14)

adjustfigurefont

print('AllDutyCycle','-dtiff','-r300')


%% Two way anova on DURATION 
individual = vertcat(repmat(4057,length(dur_low_4057),1),...
    repmat(4057,length(dur_high_4057),1),repmat(3911,length(dur_low_3911),1),...
    repmat(3911,length(dur_high_3911),1));
condition = vertcat(repmat(0,length(dur_low_4057),1),...
    repmat(1,length(dur_high_4057),1),repmat(0,length(dur_low_3911),1),...
    repmat(1,length(dur_high_3911),1));

[p,table,stats] = anovan(horzcat(dur_low_4057,dur_high_4057,dur_low_3911,dur_high_3911),...
    {individual condition},'varnames',{'Individual','Condition'});
% [c,m,h,nms] = multcompare(stats,'dim',2);
[mean(dur_low_3911) std(dur_low_3911)]
[mean(dur_high_3911) std(dur_high_3911)]
[mean(dur_low_4057) std(dur_low_4057)]
[mean(dur_high_4057) std(dur_high_4057)]
