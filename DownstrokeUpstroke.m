% Downstroke vs. upstroke

% load tags
load_rw015a
load_eg047a

% calculate pitch deviation from mean. ignore fluke stroke info here.
[rw015a.v,rw015a.ph,rw015a.mx,rw015a.fr] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 8]);
[eg047a.v,eg047a.ph,eg047a.mx,eg047a.fr] = findflukes(eg047a.Aw,eg047a.Mw,fs,0.2,0.001,[0.7 8]);

%% use peakdet to find individual fluke strokes
[maxtab,mintab] = peakdet(eg047a.ph,0.025);
% shift to get next maxtab values aligned (vectorize instead of for loop)
shift_maxtab = maxtab(2:end,1);
% inter-fluke interval
ifi = shift_maxtab(:,1)-maxtab(1:end-1,1); % in SAMPLES
% duration of downstroke in SAMPLES
ds = mintab(:,1)-maxtab(:,1);
% duration of upstroke in SAMPLES
us = shift_maxtab(:,1)-mintab(1:end-1,1);

% find within phases
ds1 = ds(maxtab(:,1) > eg047a.p1(1)*fs & maxtab(:,1) < eg047a.p1(2)*fs);
ds2= ds(maxtab(:,1) > eg047a.p2(1)*fs & maxtab(:,1) < eg047a.p2(2)*fs);
ds_high_4057 = ds(maxtab(:,1) > eg047a.p3(1)*fs & maxtab(:,1) < eg047a.p3(2)*fs);

us1 = us(maxtab(:,1) > eg047a.p1(1)*fs & maxtab(:,1) < eg047a.p1(2)*fs);
us2= us(maxtab(:,1) > eg047a.p2(1)*fs & maxtab(:,1) < eg047a.p2(2)*fs);
us_high_4057 = us(maxtab(:,1) > eg047a.p3(1)*fs & maxtab(:,1) < eg047a.p3(2)*fs);

% low drag = first two periods together
ds_low_4057 = vertcat(ds1,ds2);
us_low_4057 = vertcat(us1,us2);

% plot
figure(1); clf; hold on
plot(ds_low_4057/fs,us_low_4057/fs,'ko')
plot(ds_high_4057/fs,us_high_4057/fs,'bo')
xlabel('Downstroke Duration (sec)'); ylabel('Upstroke Duration (sec)')
legend('Low Drag','High Drag')

%% 3911
clear maxtab mintab ds us
[maxtab,mintab] = peakdet(rw015a.ph,0.04);
% figure(11); clf; hold on
% plot(rw015a.ph)
% plot(maxtab(:,1),maxtab(:,2),'r*')
% plot(mintab(:,1),mintab(:,2),'g*')
% ylabel('Pitch Deviation from mean');

% shift to get next maxtab values aligned (vectorize instead of for loop)
shift_maxtab = maxtab(2:end,1);
% inter-fluke interval
ifi = shift_maxtab(:,1)-maxtab(1:end-1,1); % in SAMPLES
% duration of downstroke in SAMPLES
ds = mintab(:,1)-maxtab(1:end-1,1);
% duration of upstroke in SAMPLES
us = shift_maxtab(1:end-1,1)-mintab(1:end-1,1);

% find within phases
ds_high_3911 = ds(maxtab(:,1) > rw015a.p1(1)*fs & maxtab(:,1) < rw015a.p1(2)*fs);
ds_low_3911= ds(maxtab(:,1) > rw015a.p2(1)*fs & maxtab(:,1) < rw015a.p3(2)*fs);

us_high_3911 = us(maxtab(:,1) > rw015a.p1(1)*fs & maxtab(:,1) < rw015a.p1(2)*fs);
us_low_3911= us(maxtab(:,1) > rw015a.p2(1)*fs & maxtab(:,1) < rw015a.p3(2)*fs);

% plot
plot(ds_low_3911/fs,us_low_3911/fs,'ro')
plot(ds_high_3911/fs,us_high_3911/fs,'go')
xlabel('Downstroke Duration (sec)'); ylabel('Upstroke Duration (sec)')
legend('Low Drag','High Drag')

%% 
bins = 0:0.25:8;
figure(2); clf;
subplot(221); hold on
hist(ds_low_3911/fs,bins)
hist(ds_high_3911/fs,bins)
h = findobj(gca,'Type','patch');
set(h(2),'FaceColor','k','EdgeColor','w','facealpha',0.5) 
set(h(1),'FaceColor','b','EdgeColor','w','facealpha',0.5)
xlim([0 8])

subplot(223); hold on
hist(ds_low_4057/fs,bins)
hist(ds_high_4057/fs,bins)
h = findobj(gca,'Type','patch');
set(h(2),'FaceColor','k','EdgeColor','w','facealpha',0.5) 
set(h(1),'FaceColor','b','EdgeColor','w','facealpha',0.5)
xlim([0 8]); ylim([0 350])

subplot(222); hold on
hist(us_low_3911/fs,bins)
hist(us_high_3911/fs,bins)
h = findobj(gca,'Type','patch');
set(h(2),'FaceColor','k','EdgeColor','w','facealpha',0.5) 
set(h(1),'FaceColor','b','EdgeColor','w','facealpha',0.5)
xlim([0 8])

subplot(224); hold on
hist(us_low_4057/fs,bins)
hist(us_high_4057/fs,bins)
h = findobj(gca,'Type','patch');
set(h(2),'FaceColor','k','EdgeColor','w','facealpha',0.5) 
set(h(1),'FaceColor','b','EdgeColor','w','facealpha',0.5)
xlim([0 8]); ylim([0 350])
