% Strouhal for 3911
% Strouhal = AF/U
% A = peak to peak amplitude
% f = frequency
% U = speed
% We can't get peak to peak amplitude but at least will use fluke stroke
% amplitude?
% U is only available for vertical speed
% This is the best we can do, I think.

close all; clear all; clc

% load data
rw015a = load('rw11_015aprh.mat');
fs = 5;                                             % sampling frequency

% calculate pitch deviation
[~,rw015a.ph,~,~] = findflukes(rw015a.Aw,rw015a.Mw,fs);

rw015a.T = finddives(rw015a.p,fs,5,1);              % find dives
load('rw015a_descasc')                              % load ascents and descents


[maxtab,mintab] = peakdet(rw015a.ph,0.025);         % find fluke strokes
amp = maxtab(1:end-1,2) - mintab(:,2);              % calculate amplitude
% amp = rw015a.mx(1:end-1) - rw015a.mx(2:end);      % calculate amplitude from mark's method
% and check
figure(1); clf; hold on
for i = 1:length(amp)
    plot([maxtab(i,1) maxtab(i,1)],[maxtab(i,2) maxtab(i,2)-amp(i)],'k')
end

% find amplitude cues in LOW condition
lowfluke = find(maxtab(:,1) > 6667 & maxtab(:,1) < 22268);
highfluke = find(maxtab(:,1) < 6667);

% find amplitude of these fluke strokes, calibration to mean = 2 m amplitude
% normal swimming conditions we assume fluke stroke amplitude 0.2*L (m)
corctn = 2/mean(amp(lowfluke));

% correct all amplitudes
ampcorctn = corctn*amp;
% plot
figure(1); clf; hold on
histogram(ampcorctn(lowfluke))
histogram(ampcorctn(highfluke))

%% for each dive
for i = 1:length(rw015a.T);
    %%
    figure(2); clf; hold on
    plot(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs,...
        -rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'color',[0.75 0.75 0.75]) % plot dive
    plot(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs,...
        rw015a.ph(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'k')                      % plot pitch deviation
    
    % find fluke strokes within descent
    ii = find(maxtab(:,1) > rw015a.T(i,1)*fs & maxtab(:,1) < rw015a.T(i,1)*fs+end_desc(i));
    plot(maxtab(ii,1),maxtab(ii,2),'*')
    
    % calculate mean corrected amplitude (in m)
    mn_amp_d(i) = mean(ampcorctn(ii));
    
    % calculate mean frequency
    count = size(ii,1);
    dur = end_desc(i)/fs;
    hz_d(i) = count/dur;
    
    % calculate mean vertical speed
    v = vertical(rw015a.p,fs);
    
    desc_vspeed(i) = mean(v(rw015a.T(i,1)*fs:rw015a.T(i,1)*fs+end_desc(i)));            % checked indices
    desc_maxspeed(i) = max(v(rw015a.T(i,1)*fs:rw015a.T(i,1)*fs+end_desc(i)));
    asc_vspeed(i) = mean(abs(v(rw015a.T(i,1)*fs+start_asc(i):rw015a.T(i,2)*fs)));       % checked indices
    asc_maxspeed(i) = max(abs(v(rw015a.T(i,1)*fs+start_asc(i):rw015a.T(i,2)*fs)));
    
    % on an ascent
    plot([rw015a.T(i,1)*fs+start_asc(i) rw015a.T(i,1)*fs+start_asc(i)],[-20 0],'k')
    
    % find fluke strokes
    ii = find(maxtab(:,1) > rw015a.T(i,1)*fs+start_asc(i) & maxtab(:,1) < rw015a.T(i,2)*fs);
    plot(maxtab(ii,1),maxtab(ii,2),'*')
    
    % calculate mean corrected amplitude (m)
    mn_amp_a(i) = mean(ampcorctn(ii));
    % plot amplitudes ** remember these are corrected amplitudes, so larger
    % than signal cause are plotting original signal.
    for j = 1:length(ii)
        plot([maxtab(ii(j),1) maxtab(ii(j),1)],[maxtab(ii(j),2) maxtab(ii(j),2)-ampcorctn(ii(j))],'k')
    end
    
    % calculate mean frequency (Hz)
    count = size(ii,1);
    dur = (rw015a.T(i,2)*fs - (rw015a.T(i,1)*fs+start_asc(i)))/fs;
    hz_a(i) = count/dur;
    
    
end

return

%% plot frequency vs amplitude
figure(3); clf; hold on
plot(hz_d(1:53),mn_amp_d(1:53),'bv','markerfacecolor','b')
plot(hz_d(54:154),mn_amp_d(54:154),'kv','markerfacecolor','k')
plot(hz_a(1:53),mn_amp_a(1:53),'b^')
plot(hz_a(54:154),mn_amp_a(54:154),'k^')
xlabel('Frequency'); ylabel('Amplitude')
adjustfigurefont

%% plot speed vs frequency: achieve much higher speeds at the same frequency
figure(10); clf; hold on
plot(asc_vspeed(1:53),hz_a(1:53),'b^')
plot(asc_vspeed(54:end),hz_a(54:end),'k^')
plot(desc_vspeed(54:end),hz_d(54:end),'kv','markerfacecolor','k')
plot(desc_vspeed(1:53),hz_d(1:53),'bv','markerfacecolor','b')
xlabel('Mean vertical speed (m/s)'); ylabel('Frequency (Hz)')
adjustfigurefont

%%

% calculate St = Af/U
St_d = (mn_amp_d.*hz_d)./desc_maxspeed;
St_a = (mn_amp_a.*hz_a)./asc_maxspeed;

% plot St
figure(2); clf; hold on
plot(St_d,'b--'); plot(St_a,'r--')
xlabel('Dive Number')
ylabel('Strouhal Number on Desc or Asc')

% find those in low drag (late in record),
% high drag (early in record)
low = find(rw015a.T(:,1) > 6667);
high = find(rw015a.T(:,1) < 6667);

%% make table

FSR = [mean(hz_d(low)) std(hz_d(low)) mean(hz_d(high)) std(hz_d(high)) mean(hz_a(low)) std(hz_a(low)) mean(hz_a(high)) std(hz_a(high))]';
AMP = [mean(mn_amp_d(low)) std(mn_amp_d(low)) nanmean(mn_amp_d(high)) nanstd(mn_amp_d(high)) nanmean(mn_amp_a(low)) nanstd(mn_amp_a(low)) nanmean(mn_amp_a(high)) nanstd(mn_amp_a(high))]';
SPD = [mean(desc_vspeed(low)) std(desc_vspeed(low)) mean(desc_vspeed(high)) std(desc_vspeed(high)) mean(asc_vspeed(low)) std(asc_vspeed(low)) mean(asc_vspeed(high)) std(asc_vspeed(high))]';
MX_SPD = [mean(desc_maxspeed(low)) std(desc_maxspeed(low)) mean(desc_maxspeed(high)) std(desc_maxspeed(high)) mean(asc_maxspeed(low)) std(asc_maxspeed(low)) mean(asc_maxspeed(high)) std(asc_maxspeed(high))]';
ST = [mean(St_d(low)) std(St_d(low)) mean(St_d(high)) std(St_d(high)) nanmean(St_a(low)) nanstd(St_a(low)) nanmean(St_a(high)) nanstd(St_a(high))]';
names = {'Descent Low Mean';'Descent Low STD';'Descent High Mean';'Descent High STD';'Ascent Low Mean';'Ascent Low STD';'Ascent High Mean';'Ascent High STD'};
table(FSR, AMP, SPD, MX_SPD, ST, 'RowNames',names)

%% histograms of strouhal, low and high, ascent and descent

st_d = (hz_d.*mn_amp_d)./desc_vspeed;
st_a = (hz_a.*mn_amp_a)./asc_vspeed;
st_dmax = (hz_d.*mn_amp_d)./desc_maxspeed;
st_amax = (hz_a.*mn_amp_a)./asc_maxspeed;

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

cd /Users/julievanderhoop/Documents/MATLAB/Eg4057/AnalysisFigs
print('ST_histograms_3911','-dtiff')
