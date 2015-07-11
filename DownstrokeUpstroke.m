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
% find within phases
ds1 = ds(maxtab(:,1) > eg047a.p1(1)*fs & maxtab(:,1) < eg047a.p1(2)*fs);
ds2= ds(maxtab(:,1) > eg047a.p2(1)*fs & maxtab(:,1) < eg047a.p2(2)*fs);
ds3 = ds(maxtab(:,1) > eg047a.p3(1)*fs & maxtab(:,1) < eg047a.p3(2)*fs);

us1 = us(maxtab(:,1) > eg047a.p1(1)*fs & maxtab(:,1) < eg047a.p1(2)*fs);
us2= us(maxtab(:,1) > eg047a.p2(1)*fs & maxtab(:,1) < eg047a.p2(2)*fs);
us3 = us(maxtab(:,1) > eg047a.p3(1)*fs & maxtab(:,1) < eg047a.p3(2)*fs);

% low drag = first two periods together
ds12 = vertcat(ds1,ds2);
us12 = vertcat(us1,us2);

% plot
figure(1); clf; hold on
plot(ds12/fs,us12/fs,'ko')
plot(ds3/fs,us3/fs,'bo')
xlabel('Downstroke Duration (sec)'); ylabel('Upstroke Duration (sec)')
legend('Low Drag','High Drag')




