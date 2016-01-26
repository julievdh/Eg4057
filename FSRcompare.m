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
[~,rw015a.ph,~,~] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 8]);
[eg047a.v,eg047a.ph,eg047a.mx,eg047a.fr] = findflukes(eg047a.Aw,eg047a.Mw,fs,0.2,0.001,[0.7 8]);

rw015a.T = finddives(rw015a.p,fs,5,1);              % find dives
load('rw015a_descasc')                              % load ascents and descents


%% use peakdet to find individual fluke strokes
[maxtab,mintab] = peakdet(rw015a.ph,0.04);

%% Calculate Inter-Fluke Interval
%% for each dive
for i = 1:length(rw015a.T);
    figure(1); clf; hold on
    plot(-rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'color',[0.75 0.75 0.75]) % plot dive
    plot(rw015a.ph(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'k') % plot pitch deviation
    plot([end_desc(i) end_desc(i)],[-20 0],'k') % plot descent
    % find fluke strokes within descent
    ii = find(maxtab(:,1) > rw015a.T(i,1)*fs & maxtab(:,1) < rw015a.T(i,1)*fs+end_desc(i));
    
    % calculate mean amplitude (in radians)
    % mn_amp_d(i) = mean(amp(ii));
        % calculate mean amplitude in m
    % mn_amp_dm(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    
    % calculate mean frequency
    count = size(ii,1);
    dur = end_desc(i)/fs;
    hz_d(i) = count/dur;
    shift_maxtab = maxtab(ii(2):ii(end),1);
    ifi_d(i,1:count-1) = shift_maxtab(:,1)-maxtab(ii(1):ii(end)-1,1); % in SAMPLES

    % on an ascent
    plot([start_asc(i) start_asc(i)],[-20 0],'k')
    
    % find fluke strokes
    ii = find(maxtab(:,1) > rw015a.T(i,1)*fs+start_asc(i) & maxtab(:,1) < rw015a.T(i,2)*fs);
    
    % calculate mean amplitude (in radians)
    % mn_amp_a(i) = mean(amp(ii(1:end-1))); % because last one is always big kick
    
    % calculate mean amplitude in m
    % mn_amp_am(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    
    % calculate mean frequency
    count = size(ii,1);
    dur = end_desc(i)/fs;
    hz_a(i) = count/dur;
    shift_maxtab = maxtab(ii(2):ii(end),1);
    ifi_a(i,1:count-1) = shift_maxtab(:,1)-maxtab(ii(1):ii(end)-1,1); % in SAMPLES


    % for bottom period
    % find fluke strokes
    ii = find(maxtab(:,1) > rw015a.T(i,1)*fs+end_desc(i) & maxtab(:,1) < rw015a.T(i,1)*fs+start_asc(i));
    
    % calculate mean amplitude (in radians)
    % mn_amp_b(i) = mean(amp(ii(1:end-1))); % because last one is always big kick
    
    % calculate mean amplitude in m
    % mn_amp_bm(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    
    % calculate mean frequency
    count = size(ii,1);
    dur = end_desc(i)/fs;
    hz_b(i) = count/dur;
    if count > 1
    shift_maxtab = maxtab(ii(2):ii(end),1);
    ifi_b(i,1:count-1) = shift_maxtab(:,1)-maxtab(ii(1):ii(end)-1,1); % in SAMPLES
    end
end

% replace zeros with NaNs
ifi_d(ifi_d == 0) = NaN;
ifi_a(ifi_a == 0) = NaN;
ifi_b(ifi_b == 0) = NaN;

figure(2); clf; hold on
histogram(ifi_d)
histogram(ifi_a)
histogram(ifi_b)

% find within phases
ifi_d_high = ifi_d(1:53,:);
ifi_d_low = ifi_d(54:end);
ifi_b_high = ifi_b(1:53,:);
ifi_b_low = ifi_b(54:end);
ifi_a_high = ifi_a(1:53,:);
ifi_a_low = ifi_a(54:end);

%%
figure(3); clf;
subplot(231); hold on
title('Eg 3911')
histogram(ifi_d_low/fs,0:0.25:20,'normalization','probability')
histogram(ifi_d_high/fs,0:0.25:20,'normalization','probability')
ylim([0 0.5])

subplot(232); hold on
histogram(ifi_b_low/fs,0:0.25:20,'normalization','probability')
histogram(ifi_b_high/fs,0:0.25:20,'normalization','probability')
ylim([0 0.5])

subplot(233); hold on
histogram(ifi_a_low/fs,0:0.25:20,'normalization','probability')
histogram(ifi_a_high/fs,0:0.25:20,'normalization','probability')
xlabel('Inter-Fluke-Interval (seconds)')
legend('low','high')
ylim([0 0.5])

% figure(4); 
% subplot(231); hold on
% histogram(hz_d(54:end))
% histogram(hz_d(1:53))
% 
% subplot(232); hold on
% histogram(hz_b(54:end))
% histogram(hz_b(1:53))
% 
% subplot(233); hold on
% histogram(hz_a(54:end))
% histogram(hz_a(1:53))

%% make figure with dive profiles and histograms
figure(5); clf; 
subplot('position',[0.1 0.52 0.4 0.45]); hold on
% plot low drag and high drag 3911 dive
for i = [38,80]
    dur = (1:length(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs))/length(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs);
    plot(dur,-rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'color',[0.75 0.75 0.75]) % plot dive
    plot(dur,rw015a.ph(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'k') % plot pitch deviation
    plot([dur(end_desc(i)) dur(end_desc(i))],[-20 0],'k') % plot descent
    plot([dur(start_asc(i)) dur(start_asc(i))],[-20 0],'k')
end

% plot histograms
subplot('position',[0.55 0.8 0.4 0.15]); hold on
histogram(ifi_d_low/fs,0:0.25:20,'normalization','probability')
histogram(ifi_d_high/fs,0:0.25:20,'normalization','probability')
ylim([0 0.5])

subplot('position',[0.55 0.65 0.4 0.15]); hold on
histogram(ifi_b_low/fs,0:0.25:20,'normalization','probability')
histogram(ifi_b_high/fs,0:0.25:20,'normalization','probability')
ylim([0 0.5])

subplot('position',[0.55 0.5 0.4 0.15]); hold on
histogram(ifi_a_low/fs,0:0.25:20,'normalization','probability')
histogram(ifi_a_high/fs,0:0.25:20,'normalization','probability')
xlabel('Inter-Fluke-Interval (seconds)')
ylim([0 0.5])


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
ifi_d_low_3911 = ifi_d_low;
ifi_d_high_3911 = ifi_d_high;
ifi_b_low_3911 = ifi_b_low;
ifi_b_high_3911 = ifi_b_high;
ifi_a_low_3911 = ifi_a_low;
ifi_a_high_3911 = ifi_a_high;
hz_d_low_3911 = hz_d(54:end);
hz_d_high_3911 = hz_d(1:53);
hz_b_low_3911 = hz_b(54:end);
hz_b_high_3911 = hz_b(1:53);
hz_a_low_3911 = hz_a(54:end);
hz_a_high_3911 = hz_a(1:53);

return

%% For Eg 4057
clear maxtab mintab ifi_d ifi_b ifi_a ii hz_d hz_b hz_a

[eg047a.v,eg047a.ph,eg047a.mx,eg047a.fr] = findflukes(eg047a.Aw,eg047a.Mw,fs,0.2,0.001,[0.7 8]);

eg047a.T = finddives(eg047a.p,fs,5,1);              % find dives
load('eg047a_descasc')                              % load ascents and descents

%% use peakdet to find individual fluke strokes
[maxtab,mintab] = peakdet(eg047a.ph,0.025);

%% Calculate Inter-Fluke Interval
%% for each dive
for i = 1:length(eg047a.T);
    figure(1); clf; hold on
    plot(-eg047a.p(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs),'color',[0.75 0.75 0.75]) % plot dive
    plot(eg047a.ph(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs),'k') % plot pitch deviation
    plot([end_desc(i) end_desc(i)],[-20 0],'k') % plot descent
    % find fluke strokes within descent
    ii = find(maxtab(:,1) > eg047a.T(i,1)*fs & maxtab(:,1) < eg047a.T(i,1)*fs+end_desc(i));
    
    % calculate mean amplitude (in radians)
    % mn_amp_d(i) = mean(amp(ii));
        % calculate mean amplitude in m
    % mn_amp_dm(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    
    % calculate mean frequency
    count = size(ii,1);
    dur = end_desc(i)/fs;
    hz_d(i) = count/dur;
    shift_maxtab = maxtab(ii(2):ii(end),1);
    ifi_d(i,1:count-1) = shift_maxtab(:,1)-maxtab(ii(1):ii(end)-1,1); % in SAMPLES

    % on an ascent
    plot([start_asc(i) start_asc(i)],[-20 0],'k')
    
    % find fluke strokes
    ii = find(maxtab(:,1) > eg047a.T(i,1)*fs+start_asc(i) & maxtab(:,1) < eg047a.T(i,2)*fs);
    
    % calculate mean amplitude (in radians)
    % mn_amp_a(i) = mean(amp(ii(1:end-1))); % because last one is always big kick
    
    % calculate mean amplitude in m
    % mn_amp_am(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    
    % calculate mean frequency
    count = size(ii,1);
    dur = end_desc(i)/fs;
    hz_a(i) = count/dur;
    shift_maxtab = maxtab(ii(2):ii(end),1);
    ifi_a(i,1:count-1) = shift_maxtab(:,1)-maxtab(ii(1):ii(end)-1,1); % in SAMPLES


    % for bottom period
    % find fluke strokes
    ii = find(maxtab(:,1) > eg047a.T(i,1)*fs+end_desc(i) & maxtab(:,1) < eg047a.T(i,1)*fs+start_asc(i));
    
    % calculate mean amplitude (in radians)
    % mn_amp_b(i) = mean(amp(ii(1:end-1))); % because last one is always big kick
    
    % calculate mean amplitude in m
    % mn_amp_bm(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
    
    % calculate mean frequency
    count = size(ii,1);
    dur = end_desc(i)/fs;
    hz_b(i) = count/dur;
    if count > 1
    shift_maxtab = maxtab(ii(2):ii(end),1);
    ifi_b(i,1:count-1) = shift_maxtab(:,1)-maxtab(ii(1):ii(end)-1,1); % in SAMPLES
    end
end

% replace zeros with NaNs
ifi_d(ifi_d == 0) = NaN;
ifi_a(ifi_a == 0) = NaN;
ifi_b(ifi_b == 0) = NaN;

figure(2); clf; hold on
histogram(ifi_d)
histogram(ifi_a)
histogram(ifi_b)

% find within phases
ifi_d_low = ifi_d(1:17,:);
ifi_d_high = ifi_d(18:end,:);
ifi_b_low = ifi_b(1:17,:);
ifi_b_high = ifi_b(18:end,:);
ifi_a_low = ifi_a(1:17,:);
ifi_a_high = ifi_a(18:end,:);

%%
figure(3);
subplot(234); hold on
title('Eg 4057')
histogram(ifi_d_low/fs,0:0.25:20,'normalization','probability')
histogram(ifi_d_high/fs,0:0.25:20,'normalization','probability')
ylim([0 0.5])

subplot(235); hold on
histogram(ifi_b_low/fs,0:0.25:20,'normalization','probability')
histogram(ifi_b_high/fs,0:0.25:20,'normalization','probability')
ylim([0 0.5])

subplot(236); hold on
histogram(ifi_a_low/fs,0:0.25:20,'normalization','probability')
histogram(ifi_a_high/fs,0:0.25:20,'normalization','probability')
xlabel('Inter-Fluke-Interval (seconds)')
legend('low','high')
ylim([0 0.5])

% figure(4); 
% subplot(234); hold on
% histogram(hz_d(1:17))
% histogram(hz_d(18:end))
% 
% subplot(235); hold on
% histogram(hz_b(1:17))
% histogram(hz_b(18:end))
% 
% subplot(236); hold on
% histogram(hz_a(1:17))
% histogram(hz_a(18:end))


%% make figure with dive profiles of low and high for two animals, and with histograms
figure(5)
subplot('position',[0.1 0.06 0.4 0.45]); hold on
for i = [10,19]
    dur = (1:length(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs))/length(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs);
    plot(dur,-eg047a.p(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs),'color',[0.75 0.75 0.75]) % plot dive
    plot(dur,eg047a.ph(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs),'k') % plot pitch deviation
    plot([dur(end_desc(i)) dur(end_desc(i))],[-20 0],'k') % plot descent
    plot([dur(start_asc(i)) dur(start_asc(i))],[-20 0],'k')
end

% plot histograms
subplot('position',[0.55 0.36 0.4 0.15]); hold on
histogram(ifi_d_low/fs,0:0.25:20,'normalization','probability')
histogram(ifi_d_high/fs,0:0.25:20,'normalization','probability')
ylim([0 0.5])

subplot('position',[0.55 0.21 0.4 0.15]); hold on
histogram(ifi_b_low/fs,0:0.25:20,'normalization','probability')
histogram(ifi_b_high/fs,0:0.25:20,'normalization','probability')
ylim([0 0.5])

subplot('position',[0.55 0.06 0.4 0.15]); hold on
histogram(ifi_a_low/fs,0:0.25:20,'normalization','probability')
histogram(ifi_a_high/fs,0:0.25:20,'normalization','probability')
xlabel('Inter-Fluke-Interval (seconds)')
ylim([0 0.5])


return

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