% Strouhal for 3911
% Strouhal = AF/U
% A = peak to peak amplitude
% f = frequency
% U = speed
% We can't get peak to peak amplitude but at least will use fluke stroke
% amplitude?
% U is only available for vertical speed
% This is the best we can do, I think.

% load data
load_rw015a
loadprh(tag)

% calculate pitch deviation
[~,rw015a.ph,~,~] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 8]);

rw015a.T = finddives(rw015a.p,fs,5,1);              % find dives
load('rw015a_descasc')                              % load ascents and descents

% on a descent
[maxtab,mintab] = peakdet(rw015a.ph,0.04);          % find fluke strokes
amp = maxtab(1:end-1,2) - mintab(:,2);              % calculate amplitude
% and check
% for i = 1:length(amp)
% plot([maxtab(i,1) maxtab(i,1)],[maxtab(i,2) maxtab(i,2)-amp(i)],'k')
% end

for i = 1:length(rw015a.T);
    % find fluke strokes within dive
    ii = find(maxtab(:,1) > rw015a.T(i,1)*fs & maxtab(:,1) < rw015a.T(i,1)*fs+end_desc(i));
    
    % calculate mean amplitude (in radians)
    mn_amp_d(i) = mean(amp(ii));
    
    % calculate mean amplitude in m
    % mn_amp_dm(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    
    % calculate mean frequency
    count = size(ii,1);
    dur = end_desc(i)/fs;
    hz_d(i) = count/dur;
end

% calculate mean vertical speed
v = vertical(rw015a.p,fs);
for i = 1:length(rw015a.T)
    desc_vspeed_015a(i) = mean(v(rw015a.T(i,1)*fs:rw015a.T(i,1)*fs+end_desc(1)));
    desc_maxspeed(i) = max(v(rw015a.T(i,1)*fs:rw015a.T(i,1)*fs+end_desc(1)));
    asc_vspeed_015a(i) = mean(abs(v(rw015a.T(i,1)*fs+start_asc(i):rw015a.T(i,2)*fs)));
    asc_maxspeed(i) = max(abs(v(rw015a.T(i,1)*fs+start_asc(i):rw015a.T(i,2)*fs)));
end

% on an ascent
for i = 1:length(rw015a.T);
    % find fluke strokes
    ii = find(maxtab(:,1) > rw015a.T(i,1)*fs+start_asc(i) & maxtab(:,1) < rw015a.T(i,2)*fs);
    
  % calculate mean amplitude (in radians)
    mn_amp_a(i) = mean(amp(ii(1:end-1))); % because last one is always big kick
    
    % calculate mean amplitude in m
    % mn_amp_am(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    
    % calculate mean frequency
    count = size(ii,1);
    dur = end_desc(i)/fs;
    hz_a(i) = count/dur;
end
%%
% calculate mean amplitude in meters
mn_amp_am = sin(mn_amp_a)*5;
mn_amp_dm = sin(mn_amp_d)*5;

% calculate St = Af/U
St_dm = (mn_amp_dm.*hz_d)./desc_maxspeed;
St_am = (mn_amp_am.*hz_a)./asc_maxspeed;

% plot St
figure(2); clf; hold on
plot(St_dm,'b--'); plot(abs(St_am),'r--')

% find those in low drag (late in record), 
% high drag (early in
% record)
low = find(rw015a.T(:,1) > rw015a.p2(1));
high = find(rw015a.T(:,1) < rw015a.p1(2));

%% make table

FSR = [mean(hz_d(low)) std(hz_d(low)) mean(hz_d(high)) std(hz_d(high)) mean(hz_a(low)) std(hz_a(low)) mean(hz_a(high)) std(hz_a(high))]';
AMP = [mean(mn_amp_dm(low)) std(mn_amp_dm(low)) mean(mn_amp_dm(high)) std(mn_amp_dm(high)) mean(mn_amp_am(low)) std(mn_amp_am(low)) mean(mn_amp_am(high)) std(mn_amp_am(high))]';
SPD = [mean(desc_vspeed_015a(low)) std(desc_vspeed_015a(low)) mean(desc_vspeed_015a(high)) std(desc_vspeed_015a(high)) mean(asc_vspeed_015a(low)) std(asc_vspeed_015a(low)) mean(asc_vspeed_015a(high)) std(asc_vspeed_015a(high))]';
MX_SPD = [mean(desc_maxspeed(low)) std(desc_maxspeed(low)) mean(desc_maxspeed(high)) std(desc_maxspeed(high)) mean(asc_maxspeed(low)) std(asc_maxspeed(low)) mean(asc_maxspeed(high)) std(asc_maxspeed(high))]';
ST = (FSR.*AMP)./SPD;
MX_ST = (FSR.*AMP)./MX_SPD;
names = {'Descent Low Mean';'Descent Low STD';'Descent High Mean';'Descent High STD';'Ascent Low Mean';'Ascent Low STD';'Ascent High Mean';'Ascent High STD'};
table(FSR, AMP, SPD, MX_SPD, ST, MX_ST,'RowNames',names)

%% histograms of strouhal, low and high, ascent and descent

st_d = (hz_d.*mn_amp_dm)./desc_vspeed_015a;
st_a = (hz_a.*mn_amp_am)./asc_vspeed_015a;
st_dmax = (hz_d.*mn_amp_dm)./desc_maxspeed;
st_amax = (hz_a.*mn_amp_am)./asc_maxspeed;

bins = 0:0.25:2.5;
figure(15); clf;
h1 = hist(st_d(low),bins);
h2 = hist(st_d(high),bins);
subplot(221);
h = bar(bins,[h1;h2]',1.2,'grouped');
title('St Descent')
legend('low','high')
subplot(222);
h3 = hist(st_a(low),bins);
h4 = hist(st_a(high),bins);
h = bar(bins,[h3;h4]',1.2,'grouped');
title('St Ascent')
subplot(223); 
h5 = hist(st_dmax(low),bins);
h6 = hist(st_dmax(high),bins);
h = bar(bins,[h5;h6]',1.2,'grouped');
title('St Descent, max speed')
subplot(224);
h7 = hist(st_amax(low),bins);
h8 = hist(st_amax(high),bins);
h = bar(bins,[h7;h8]',1.2,'grouped');
title('St Ascent, max speed')

cd C:\Users\Julie\Documents\MATLAB\Eg4057\AnalysisFigs
print('ST_histograms_3911','-dtiff')
