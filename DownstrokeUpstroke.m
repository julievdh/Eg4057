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
bins = 0:0.25:10;
figure(2); clf;
subplot(221); hold on
h1 = hist(ds_low_3911/fs,bins);
h2 = hist(ds_high_3911/fs,bins);
h1 = h1/sum(h1);
h2 = h2/sum(h2);
h = bar(bins,[h1;h2]',1.2,'grouped');
xlim([0 8])
set(h(1),'FaceColor','k')
set(h(2),'FaceColor','b')

subplot(223); hold on
h3 = hist(ds_low_4057/fs,bins);
h4 = hist(ds_high_4057/fs,bins);
h3 = h3/sum(h3);
h4 = h4/sum(h4);
h = bar(bins,[h3;h4]',1.2,'grouped');
set(h(1),'FaceColor','k')
set(h(2),'FaceColor','b')
xlim([0 8])
xlabel('Downstroke Duration (sec)')

subplot(222); hold on
h5 = hist(us_low_3911/fs,bins);
h6 = hist(us_high_3911/fs,bins);
h5 = h5/sum(h5);
h6 = h6/sum(h6);
h = bar(bins,[h5;h6]',1.2,'grouped');
set(h(1),'FaceColor','k')
set(h(2),'FaceColor','b')
xlim([0 8])

subplot(224); hold on
h7 = hist(us_low_4057/fs,bins);
h8 = hist(us_high_4057/fs,bins);
h7 = h7/sum(h7);
h8 = h8/sum(h8);
h = bar(bins,[h7;h8]',1.2,'grouped');
set(h(1),'FaceColor','k')
set(h(2),'FaceColor','b')
xlim([0 8])
xlabel('Upstroke Duration (sec)')

%% stats
% individual = vertcat(repmat(3911,length(ds_low_3911),1),repmat(3911,length(ds_high_3911),1),...
%     repmat(4057,length(ds_low_4057),1),repmat(4057,length(ds_high_4057),1));
% condition = vertcat(zeros(length(ds_low_3911),1),ones(length(ds_high_3911),1),...
%     zeros(length(ds_low_4057),1),ones(length(ds_high_4057),1));
% 
% figure
% [p,table,stats] = anovan(vertcat(ds_low_3911,ds_high_3911,ds_low_4057,ds_high_4057),{individual condition},'varnames',{'Individual','Condition'});
% [c,m,h,nms] = multcompare(stats,'dim',2);

%% proportion of stroke that is upstroke vs downstroke?
propds_high_4057 = ds_high_4057./(ds_high_4057+us_high_4057);
propds_low_4057 = ds_low_4057./(ds_low_4057+us_low_4057);
propds_high_3911 = ds_high_3911./(ds_high_3911+us_high_3911);
propds_low_3911 = ds_low_3911./(ds_low_3911+us_low_3911);


figure(10)
bins = 0:0.1:1;
h10 = hist(propds_high_4057,bins);
h11 = hist(propds_low_4057,bins);
h12 = hist(propds_high_3911,bins);
h13 = hist(propds_low_3911,bins);

h10 = h10/sum(h10);
h11 = h11/sum(h11);
h12 = h12/sum(h12);
h13 = h13/sum(h13);
h = bar(bins,[h10;h11;h12;h13]',1.2,'grouped');
