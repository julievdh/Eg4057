% look at fluke stroke rate of two entangled whale tags
%
%

% load tags
load_rw015a
load_eg047a

% calculate pitch deviation from mean. ignore fluke stroke info here.
[rw015a.v,rw015a.ph,rw015a.mx,rw015a.fr] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 8]);
[eg047a.v,eg047a.ph,eg047a.mx,eg047a.fr] = findflukes(eg047a.Aw,eg047a.Mw,fs,0.2,0.001,[0.7 8]);

% %% plot
% figure(1); clf
% subplot(211); hold on
% plot(rw015a.t,rw015a.ph)
% plot(rw015a.v,rw015a.mx,'r.')
% plot(rw015a.t,-rw015a.p/max(rw015a.p),'k')
% subplot(212);  hold on
% plot(eg047a.t,eg047a.ph)
% plot(eg047a.v,eg047a.mx,'r.')
% plot(eg047a.t,-eg047a.p/max(eg047a.p),'k')
% plot((1:length(eg047a.fr)),eg047a.fr,'g.')

%% use peakdet to find individual fluke strokes
[maxtab,mintab] = peakdet(eg047a.ph,0.01);
figure(11); hold on
plot(eg047a.ph)
plot(maxtab(:,1),maxtab(:,2),'r.')
ylabel('Pitch Deviation from mean');

% %% RECOMPUTE FLUKE STROKE RATE OWN OWN
%% compare fluke stroke rate
FSRp1 = eg047a.fr(eg047a.p1(1):eg047a.p1(2));
FSRp12 = eg047a.fr(eg047a.p1(1):eg047a.p2(2));
FSRp2 = eg047a.fr(eg047a.p2(1):eg047a.p2(2));
FSRp3 = eg047a.fr(eg047a.p3(1):eg047a.p3(2));

%% vertcat to boxplot
FSRall = vertcat(FSRp12, FSRp3);
FSRall(:,2) = vertcat(repmat(1,length(FSRp12),1), repmat(3,length(FSRp3),1));
figure(12)
boxplot(FSRall(:,1),FSRall(:,2))

%% Duty Cycle

% calculate inter-fluke interval for periods 1, 2, 3
ifi1 = dutycycleplot(eg047a.p1,eg047a.ph,fs); % in SAMPLES
ifi2= dutycycleplot(eg047a.p2,eg047a.ph,fs); 
ifi3 = dutycycleplot(eg047a.p3,eg047a.ph,fs); 

ifi1(ifi1 == 0) = NaN; % convert 0's to NaN
ifi2(ifi2 == 0) = NaN;
ifi3(ifi3 == 0) = NaN;

% set histogram bins
bins = [0:0.5:20];

% plot
figure(2); clf 
subplot(211); hold on; xlim([0 20])
hist(ifi1/fs,bins)
hist(ifi2/fs,bins)
hist(ifi3/fs,bins)
h = findobj(gca,'Type','patch');
set(h(2),'FaceColor','r','EdgeColor','w','facealpha',0.5)
set(h(1),'FaceColor','y','EdgeColor','w','facealpha',0.5)
xlabel('Inter-fluke-interval (seconds)'); 
legend('P1','P2','P3')

figure(3); clf; hold on
h1 = cdfplot(ifi1);
h2 = cdfplot(ifi2);
h3 = cdfplot(ifi3);
set(h2,'color','r')
set(h3,'color','k')

% Repeat for Eg 3911
ifi1 = dutycycleplot(rw015a.p1,rw015a.ph,fs); % in SAMPLES
ifi2= dutycycleplot(rw015a.p2,rw015a.ph,fs); 
ifi3 = dutycycleplot(rw015a.p3,rw015a.ph,fs); 

ifi1(ifi1 == 0) = NaN; % convert 0's to NaN
ifi2(ifi2 == 0) = NaN;
ifi3(ifi3 == 0) = NaN;

figure(2); subplot(212); hold on; xlim([0 20])
hist(ifi1/fs,bins)
hist(ifi2/fs,bins)
hist(ifi3/fs,bins)
h = findobj(gca,'Type','patch');
set(h(2),'FaceColor','r','EdgeColor','w','facealpha',0.5)
set(h(1),'FaceColor','y','EdgeColor','w','facealpha',0.5)
xlabel('Inter-fluke-interval (seconds)'); 

figure(3)
h1 = cdfplot(ifi1);
h2 = cdfplot(ifi2);
h3 = cdfplot(ifi3);
set(h1,'color','c')
set(h2,'color','m')
set(h3,'color','y')