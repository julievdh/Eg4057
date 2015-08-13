% plot fluke strokes ABCD panel of Eg 3911 low/high drag and Eg 4057
% low/high drag 

%% load data
load_eg047a
load_rw015a

% calculate pitch deviation from mean. ignore fluke stroke info here.
[rw015a.v,rw015a.ph,rw015a.mx,rw015a.fr] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 8]);
[eg047a.v,eg047a.ph,eg047a.mx,eg047a.fr] = findflukes(eg047a.Aw,eg047a.Mw,fs,0.2,0.001,[0.7 8]);

%% make figure
figure(1); clf; set(gcf,'position',[92 182 738 583])
% A: low drag/buoyancy fluke stroke duty cycle for Eg 3911
subplot('position',[0.12 0.57 0.4 0.4])
[ifi_low_3911,maxtab,mintab] = dutycycleplot(rw015a.p3,rw015a.ph,fs); 
ylim([-1 1]); text(0.1,0.85,'A','FontSize',18,'FontWeight','Bold')

% B: high drag/buoyancy fluke stroke duty cycle for Eg 3911
subplot('position',[0.57 0.57 0.4 0.4])
[ifi_high_3911,maxtab,mintab] = dutycycleplot([rw015a.p1(1) rw015a.p2(2)],rw015a.ph,fs); 
ylim([-1 1]); text(0.1,0.85,'B','FontSize',18,'FontWeight','Bold')

% C: low drag/buoyancy fluke stroke duty cycle for Eg 4057
subplot('position',[0.12 0.12 0.4 0.4])
[ifi_low_4057_1,maxtab,mintab] = dutycycleplot(eg047a.p1,eg047a.ph,fs); 
[ifi_low_4057_2,maxtab,mintab] = dutycycleplot(eg047a.p2,eg047a.ph,fs); 
ifi_low_4057 = horzcat(ifi_low_4057_1,ifi_low_4057_2);
xlim([0 8]); ylim([-1 1]); text(0.3,0.85,'C','FontSize',18,'FontWeight','Bold')

% D: high drag/buoyancy fluke stroke duty cycle for Eg 4057
subplot('position',[0.57 0.12 0.4 0.4])
[ifi_high_4057,maxtab,mintab] = dutycycleplot(eg047a.p3,eg047a.ph,fs); 
ylim([-1 1]); xlim([0 8]); text(0.3,0.85,'D','FontSize',18,'FontWeight','Bold')
[ax1,h1] = suplabel('Time (seconds)');
[ax2,h2] = suplabel('Pitch deviation from mean (deg)','y');

adjustfigurefont

cd C:\Users\Julie\Documents\MATLAB\Eg4057\AnalysisFigs
print('AllDutyCycle','-dtiff','-r300')

%% Two way anova
individual = vertcat(repmat(4057,length(ifi_low_4057),1),...
    repmat(4057,length(ifi_high_4057),1),repmat(3911,length(ifi_low_3911),1),...
    repmat(3911,length(ifi_high_3911),1));
condition = vertcat(repmat(0,length(ifi_low_4057),1),...
    repmat(1,length(ifi_high_4057),1),repmat(0,length(ifi_low_3911),1),...
    repmat(1,length(ifi_high_3911),1));

[p,table,stats] = anovan(horzcat(ifi_low_4057,ifi_high_4057,ifi_low_3911,ifi_high_3911),...
    {individual condition},'varnames',{'Individual','Condition'});
% [c,m,h,nms] = multcompare(stats,'dim',2);