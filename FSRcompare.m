% Compare fluke stroke rate of two entangled whale tags

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

% calculate pitch deviation from mean. ignore fluke stroke info here.
[rw015a.v,rw015a.ph,rw015a.mx,rw015a.fr] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 8]);
[eg047a.v,eg047a.ph,eg047a.mx,eg047a.fr] = findflukes(eg047a.Aw,eg047a.Mw,fs,0.2,0.001,[0.7 8]);

%% use peakdet to find individual fluke strokes
[maxtab,mintab] = peakdet(eg047a.ph,0.025);
figure(11); clf; hold on
plot(eg047a.ph)
plot(maxtab(:,1),maxtab(:,2),'r.')
ylabel('Pitch Deviation from mean');

%% Calculate Inter-Fluke Interval
% calculate inter-fluke interval for periods 1, 2, 3
shift_maxtab = maxtab(2:end,1);
ifi = shift_maxtab(:,1)-maxtab(1:end-1,1); % in SAMPLES
% find within phases
ifi1 = ifi(maxtab(:,1) > eg047a.p1(1)*fs & maxtab(:,1) < eg047a.p1(2)*fs);
ifi2= ifi(maxtab(:,1) > eg047a.p2(1)*fs & maxtab(:,1) < eg047a.p2(2)*fs);
ifi3 = ifi(maxtab(:,1) > eg047a.p3(1)*fs & maxtab(:,1) < eg047a.p3(2)*fs);

% low drag = first two periods together
ifi12 = vertcat(ifi1,ifi2);


%% plot
figure(2); clf 
% set histogram bins
bins = [0:0.2:20];
subplot(212); hold on; xlim([0 20])
hist(ifi12/fs,bins) % low
hist(ifi3/fs,bins) % high
h = findobj(gca,'Type','patch');
set(h(2),'FaceColor','k','EdgeColor','w','facealpha',0.5)
set(h(1),'FaceColor','b','EdgeColor','w','facealpha',0.5)
xlabel('Inter-Fluke Interval (seconds)') 
text(0.5,132,'B','FontSize',18,'FontWeight','Bold')
plot([0 20],[0 0],'k')

figure(3); clf; hold on
h1 = cdfplot(ifi12);
h3 = cdfplot(ifi3);
set(h3,'color','k')

%% Repeat for Eg 3911
[maxtab,mintab] = peakdet(rw015a.ph,0.04);
figure(11); clf; hold on
plot(rw015a.ph)
plot(maxtab(:,1),maxtab(:,2),'r.')
ylabel('Pitch Deviation from mean');

shift_maxtab = maxtab(2:end,1);
ifi = shift_maxtab(:,1)-maxtab(1:end-1,1); % in SAMPLES
% find within phases
ifi1_3911 = ifi(maxtab(:,1) > rw015a.p1(1)*fs & maxtab(:,1) < rw015a.p1(2)*fs); % high drag
ifi2_3911 = ifi(maxtab(:,1) > rw015a.p2(1)*fs & maxtab(:,1) < rw015a.p3(2)*fs); % low drag

figure(2); subplot(211); hold on; xlim([0 20])
hist(ifi2_3911/fs,bins) % low
hist(ifi1_3911/fs,bins) % high
h = findobj(gca,'Type','patch');
set(h(2),'FaceColor','k','EdgeColor','w','facealpha',0.5) 
set(h(1),'FaceColor','b','EdgeColor','w','facealpha',0.5)
legend('Low Drag','High Drag'); text(0.5,1.35E3,'A','FontSize',18,'FontWeight','Bold')
plot([0 20],[0 0],'k')
adjustfigurefont

cd C:\Users\Julie\Documents\MATLAB\Eg4057\AnalysisFigs
print('IFIdistribution','-dtiff')

figure(3); hold on
h1 = cdfplot(ifi1_3911);
h2 = cdfplot(ifi2_3911);
set(h1,'color','b')
set(h2,'color','k')

%% KS test, with bonferroni correction
% Are conditions different in 3911 low drag and high drag?
[h,p,ks2stat] = kstest2(ifi1_3911,ifi2_3911,'alpha',0.05/2)

% Are conditions different in 4057 low drag and high drag?
[h,p,ks2stat] = kstest2(ifi12,ifi3,'alpha',0.05/2)

%% descriptive statistics

mnsd3911 = [mean(vertcat(ifi1_3911,ifi2_3911))/fs std(vertcat(ifi1_3911,ifi2_3911))/fs]
mnsd4057_low = [mean(ifi12/fs) std(ifi12/fs)]
mnsd4057_high = [mean(ifi3/fs) std(ifi3/fs)]