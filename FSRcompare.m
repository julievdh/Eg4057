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
[~,rw015a.ph,~,rw015a.fr] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 8]);

rw015a.T = finddives(rw015a.p,fs,5,1);              % find dives
load('rw015a_descasc')                              % load ascents and descents

%% Calculate Fluke Stroke Rate
% use peak detection algorithm on pitch deviation. Better at detecting.
% See e.g. Figure Eg4057Dive5.fig
[maxtab,mintab] = peakdet(rw015a.ph,0.025);
%% for each dive
warning off
for i = 1:length(rw015a.T);
    % pause
    figure(1); clf; hold on
    plot(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs,-rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'color',[0.75 0.75 0.75]) % plot dive
    plot(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs,rw015a.ph(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'k') % plot pitch deviation
    % plot([end_desc(i) end_desc(i)],[-20 0],'k') % plot descent
    % plot(rw015a.T(i,1)*fs:fs:rw015a.T(i,2)*fs,rw015a.fr(rw015a.T(i,1):(rw015a.T(i,2))),'r') % plot instantaneous fluke stroke rate
    % find fluke strokes within descent
    ii = find(maxtab(:,1) > rw015a.T(i,1)*fs & maxtab(:,1) < rw015a.T(i,1)*fs+end_desc(i));
    plot(maxtab(ii,1),maxtab(ii,2),'*')
    
    % calculate mean amplitude (in radians)
    % mn_amp_d(i) = mean(amp(ii));
    % calculate mean amplitude in m
    % mn_amp_dm(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    
    % calculate mean frequency
    count = size(ii,1);
    dur = end_desc(i)/fs;
    hz_d(i) = count/dur;
    
    %     % on an ascent
    %     plot([start_asc(i) start_asc(i)],[-20 0],'k')
    
    % find fluke strokes
    ii = find(maxtab(:,1) > rw015a.T(i,1)*fs+start_asc(i) & maxtab(:,1) < rw015a.T(i,2)*fs);
    plot(maxtab(ii,1),maxtab(ii,2),'*')
    
    %     % calculate mean amplitude (in radians)
    %     % mn_amp_a(i) = mean(amp(ii(1:end-1))); % because last one is always big kick
    %     % calculate mean amplitude in m
    %     % mn_amp_am(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    
    %     % calculate mean frequency
    count = size(ii,1);
    dur = (rw015a.T(i,2)*fs - (rw015a.T(i,1)*fs+start_asc(i)))/fs;
    hz_a(i) = count/dur;
    
    % for bottom period
    % find fluke strokes
    ii = find(maxtab(:,1) > rw015a.T(i,1)*fs+end_desc(i) & maxtab(:,1) < rw015a.T(i,1)*fs+start_asc(i));
    plot(maxtab(ii,1),maxtab(ii,2),'*')
    
    %     % calculate mean amplitude (in radians)
    %     % mn_amp_b(i) = mean(amp(ii(1:end-1))); % because last one is always big kick
    %     % calculate mean amplitude in m
    %     % mn_amp_bm(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    %
    %     % calculate mean frequency
    count = size(ii,1);
    dur = (start_asc(i) - end_desc(i))/fs;
    hz_b(i) = count/dur;
end

%% replace zeros with NaNs
figure(2); clf; hold on
histogram(hz_d)
histogram(hz_a)
histogram(hz_b)

% find within phases
hz_d_high = hz_d(1:53);
hz_d_low = hz_d(54:end);
hz_b_high = hz_b(1:53);
hz_b_low = hz_b(54:end);
hz_a_high = hz_a(1:53);
hz_a_low = hz_a(54:end);

%% What about fluke stroke rate at the surface?
[~,hz_s_3911] = surfIFI(rw015a,maxtab);
figure(2)
histogram(hz_s_3911)

%%
figure(3); clf;
subplot(241); hold on
title('Eg 3911')
histogram(hz_d_low,0:0.05:1,'normalization','probability')
histogram(hz_d_high,0:0.05:1,'normalization','probability')
% ylim([0 0.5])

subplot(242); hold on
histogram(hz_b_low,0:0.05:1,'normalization','probability')
histogram(hz_b_high,0:0.05:1,'normalization','probability')
% ylim([0 0.5])

subplot(243); hold on
histogram(hz_a_low,0:0.05:1,'normalization','probability')
histogram(hz_a_high,0:0.05:1,'normalization','probability')
xlabel('Fluke Stroke Rate (Hz)')
% ylim([0 0.5])

subplot(244); hold on
histogram(hz_s_3911(54:end),0:0.05:1,'normalization','probability')
histogram(hz_s_3911(1:53),0:0.05:1,'normalization','probability')
xlabel('Fluke Stroke Rate (Hz)')
% ylim([0 0.5])

%% make figure with dive profiles and histograms
figure(5); clf;
subplot('position',[0.1 0.52 0.4 0.45]); hold on
% plot low drag and high drag 3911 dive
c = [0 0 1; 0 0 0];
for dives = 1:2
    n = [38,80];
    i = n(dives);
    dur = (1:length(rw015a.T(i,1)*fs:rw015a.T(i+1,1)*fs))/length(rw015a.T(i,1)*fs:rw015a.T(i+1,1)*fs);
    h1 = plot(dur,-rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i+1,1)*fs)); % plot dive
    h2 = plot(dur,rw015a.ph(rw015a.T(i,1)*fs:rw015a.T(i+1,1)*fs)); % plot pitch deviation
    % plot([dur(end_desc(i)) dur(end_desc(i))],[-20 0],'k') % plot descent
    % plot([dur(start_asc(i)) dur(start_asc(i))],[-20 0],'k')
    h1.Color = c(dives,:);
    h2.Color = [c(dives,:) 0.4];
end

xlabel('Normalized Duration'); ylabel('Depth (m)')

% plot histograms
subplot('position',[0.55 0.86 0.4 0.1125]); hold on
h = histogram(hz_d_low,0:0.05:1,'normalization','probability','displaystyle','stairs');
h.EdgeColor = 'k';
h = histogram(hz_d_high,0:0.05:1,'normalization','probability','displaystyle','stairs');
h.EdgeColor = 'b';
ylim([0 0.7])

subplot('position',[0.55 0.7475 0.4 0.1125]); hold on
h = histogram(hz_b_low,0:0.05:1,'normalization','probability','displaystyle','stairs');
h.EdgeColor = 'k';
h = histogram(hz_b_high,0:0.05:1,'normalization','probability','displaystyle','stairs');
h.EdgeColor = 'b';
ylim([0 0.7])

subplot('position',[0.55 0.6350 0.4 0.1125]); hold on
h = histogram(hz_a_low,0:0.05:1,'normalization','probability','displaystyle','stairs');
h.EdgeColor = 'k';
h = histogram(hz_a_high,0:0.05:1,'normalization','probability','displaystyle','stairs');
h.EdgeColor = 'b';
ylim([0 0.7])

subplot('position',[0.55 0.5225 0.4 0.1125]); hold on
h = histogram(hz_s_3911(54:end),0:0.05:1,'normalization','probability','displaystyle','stairs');
h.EdgeColor = 'k';
h = histogram(hz_s_3911(1:53),0:0.05:1,'normalization','probability','displaystyle','stairs');
h.EdgeColor = 'b';
xlabel('Fluke Stroke Frequency (Hz)')
ylim([0 0.7])

%% Standardized dive desc and asc
% subplot(121); hold on
% for i = 2:5:154
%     h = plot(-rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i,1)*fs+end_desc(i)),'color',[0.4 0.6 0.8]); % plot dive
%     if i >= 54
%         set(h,'color',[0.75 0.75 0.75]);
%     end
%        h = plot(rw015a.ph(rw015a.T(i,1)*fs:rw015a.T(i,1)*fs+end_desc(i)),'color','k'); % plot pitch deviation
%        if i < 54
%            set(h,'color','b')
%        end
% end
% ylim([-22 2])
% % align all ascents though
% subplot(122); hold on
% for i = 2:5:154
%     arb = 250+rw015a.T(i,1)*fs+start_asc(i)-rw015a.T(i,2)*fs;
%     h = plot(arb:250,-rw015a.p(rw015a.T(i,1)*fs+start_asc(i):rw015a.T(i,2)*fs),'color',[0.4 0.6 0.8]); % plot dive
%     if i >= 54
%         set(h,'color',[0.75 0.75 0.75])
%     end
%     h = plot(arb:250,rw015a.ph(rw015a.T(i,1)*fs+start_asc(i):rw015a.T(i,2)*fs),'color','k'); % plot pitch deviation
%     if i < 54
%         set(h,'color','b')
%     end
% end
% ylim([-22 2])

% store values
hz_d_3911 = hz_d;
hz_b_3911 = hz_b;
hz_a_3911 = hz_a;

%% For Eg 4057
clear ii hz_d hz_b hz_a hz_s

[~,eg047a.ph,~,eg047a.fr] = findflukes(eg047a.Aw,eg047a.Mw,fs,0.16,0.001,[0.6 10]);
[maxtab,mintab] = peakdet(eg047a.ph,0.025); % use peak detection algorithm on pitch deviation. This gives better detection of fluke strokes (see Eg4057 Fig 5.fig)

eg047a.T = finddives(eg047a.p,fs,5,1);              % find dives
load('eg047a_descasc')                              % load ascents and descents
low = [1:6,8:12];                                   % dive 7 tag moves
high = [13:15,18:20];                               % dives 16, 17 tag moves

%% Calculate Fluke Stroke Rate
%% for each dive
for i = 1:length(eg047a.T)
    figure(1); clf; hold on
    plot(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs,-eg047a.p(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs),'color',[0.75 0.75 0.75]) % plot dive
    plot(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs,eg047a.ph(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs),'k') % plot pitch deviation
    % plot([end_desc(i) end_desc(i)],[-20 0],'k') % plot descent
    % plot(eg047a.T(i,1)*fs:fs:eg047a.T(i,2)*fs,eg047a.fr(eg047a.T(i,1):(eg047a.T(i,2))),'r') % plot instantaneous fluke stroke rate
    % find fluke strokes within descent
    ii = find(maxtab(:,1) > eg047a.T(i,1)*fs & maxtab(:,1) < eg047a.T(i,1)*fs+end_desc(i));
    plot(maxtab(ii,1),maxtab(ii,2),'*')
    
    
    % calculate mean amplitude (in radians)
    % mn_amp_d(i) = mean(amp(ii));
    % calculate mean amplitude in m
    % mn_amp_dm(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    
    % calculate mean frequency
    count = size(ii,1);
    dur = end_desc(i)/fs;
    hz_d(i) = count/dur;
    
    % on an ascent
    % find fluke strokes
    ii = find(maxtab(:,1) > eg047a.T(i,1)*fs+start_asc(i) & maxtab(:,1) < eg047a.T(i,2)*fs);
    plot(maxtab(ii,1),maxtab(ii,2),'*')
    
    % calculate mean amplitude (in radians)
    % mn_amp_a(i) = mean(amp(ii(1:end-1))); % because last one is always big kick
    % calculate mean amplitude in m
    % mn_amp_am(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    
    % calculate mean frequency
    count = size(ii,1);
    dur = (eg047a.T(i,2)*fs - (eg047a.T(i,1)*fs+start_asc(i)))/fs;
    hz_a(i) = count/dur;
    
    % for bottom period
    % find fluke strokes
    ii = find(maxtab(:,1) > eg047a.T(i,1)*fs+end_desc(i) & maxtab(:,1) < eg047a.T(i,1)*fs+start_asc(i));
    plot(maxtab(ii,1),maxtab(ii,2),'*')
    
    % calculate mean amplitude (in radians)
    % mn_amp_b(i) = mean(amp(ii(1:end-1))); % because last one is always big kick
    % calculate mean amplitude in m
    % mn_amp_bm(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    
    % calculate mean frequency
    count = size(ii,1);
    dur = (start_asc(i) - end_desc(i))/fs;
    hz_b(i) = count/dur;
end

% at the surface
[~,hz_s] = surfIFI(eg047a,maxtab);

%%
figure(3);
subplot(245); hold on
title('Eg 4057')
histogram(hz_d(low),0:0.05:1,'normalization','probability')
histogram(hz_d(high),0:0.05:1,'normalization','probability')
ylim([0 0.7])

subplot(246); hold on
histogram(hz_b(low),0:0.05:1,'normalization','probability')
histogram(hz_b(high),0:0.05:1,'normalization','probability')
ylim([0 0.7])

subplot(247); hold on
histogram(hz_a(low),0:0.05:1,'normalization','probability')
histogram(hz_a(high),0:0.05:1,'normalization','probability')
ylim([0 0.7])

subplot(248); hold on
histogram(hz_s(low),0:0.05:1,'normalization','probability')
histogram(hz_s(high),0:0.05:1,'normalization','probability')
xlabel('Fluke Stroke Rate (Hz)')
legend('low','high')
ylim([0 0.7])

%% make figure with dive profiles of low and high for two animals, and with histograms
figure(5)
subplot('position',[0.1 0.06 0.4 0.45]); hold on
for i = [10,18]
    dur = (1:length(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs))/length(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs);
    plot(dur,-eg047a.p(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs),'color',[0.75 0.75 0.75]) % plot dive
    plot(dur,eg047a.ph(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs),'k') % plot pitch deviation
    plot([dur(end_desc(i)) dur(end_desc(i))],[-20 0],'k') % plot descent
    plot([dur(start_asc(i)) dur(start_asc(i))],[-20 0],'k')
end

% plot histograms
subplot('position',[0.55 0.36 0.4 0.15]); hold on
histogram(hz_d(low),0:0.05:1,'normalization','probability')
histogram(hz_d(high),0:0.05:1,'normalization','probability')
ylim([0 0.5])

subplot('position',[0.55 0.21 0.4 0.15]); hold on
histogram(hz_b(low),0:0.05:1,'normalization','probability')
histogram(hz_b(high),0:0.05:1,'normalization','probability')
ylim([0 0.5])

subplot('position',[0.55 0.06 0.4 0.15]); hold on
histogram(hz_a(low),0:0.05:1,'normalization','probability')
histogram(hz_a(high),0:0.05:1,'normalization','probability')
ylim([0 0.5])


subplot('position',[0.55 0.06 0.4 0.15]); hold on
histogram(hz_s(low),0:0.05:1,'normalization','probability')
histogram(hz_s(high),0:0.05:1,'normalization','probability')
xlabel('Inter-Fluke-Interval (seconds)')
ylim([0 0.5])


%% Run stats
FSRstats


