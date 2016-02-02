% make vector of ifi
ifi_all_3911 = vertcat(nanmean(ifi_d_3911')',nanmean(ifi_b_3911')',nanmean(ifi_a_3911')',nanmean(ifi_s_3911')');
hz_all_3911 = vertcat(hz_d_3911',hz_b_3911',hz_a_3911',hz_s_3911');
ifi_all_4057 = vertcat(nanmean(ifi_d')',nanmean(ifi_b')',nanmean(ifi_a')',nanmean(ifi_s')');
hz_all_4057 = vertcat(hz_d',hz_b',hz_a',hz_s');
ifi_all = vertcat(ifi_all_3911,ifi_all_4057);
hz_all = vertcat(hz_all_3911,hz_all_4057);

%% make accompanying vector of individual. should be same length (one entry
% for each dive)
indv = vertcat(repmat(3911,length(ifi_all_3911),1),repmat(4057,length(ifi_all_4057),1));

% make accompanying vector of condition. should be high/low x 3
highlow = vertcat(ones(53,1),zeros(101,1)); % condition order for 3911
lowhigh = vertcat(zeros(17,1),ones(3,1)); % condition order for 4057
cond = vertcat(repmat(highlow,4,1),repmat(lowhigh,4,1));

% make accompanying vector of dive phase
phase_ifi = vertcat(-ones(length(ifi_d_3911),1),zeros(length(ifi_b_3911),1),ones(length(ifi_a_3911),1),repmat(2,size(ifi_s_3911,1),1),...
    -ones(size(ifi_d,1),1),zeros(size(ifi_b,1),1),ones(size(ifi_a,1),1),repmat(2,size(ifi_s,1),1));
phase_hz = vertcat(-ones(length(hz_d_3911),1),zeros(length(hz_b_3911),1),ones(length(hz_a_3911),1),repmat(2,size(ifi_s_3911,1),1),...
    -ones(size(ifi_d,1),1),zeros(size(ifi_b,1),1),ones(size(ifi_a,1),1),repmat(2,size(ifi_s,1),1));

% two way anova phase, condition
[p,t,stats] = anovan(ifi_all,{indv,phase_ifi,cond},'interaction');
[c,m,h,names] = multcompare(stats,'dim',3);

[p,t,stats] = anovan(hz_all,{indv,phase_hz,cond},'varnames',{'Individual','Phase','Condition'});
[c,m,h,names] = multcompare(stats,'dim',3);


%% FSR PLOT
figure(5); clf; hold on
load('rw015a_descasc')  
subplot(211); hold on
i = 80;
    dur = (1:length(rw015a.T(i,1)*fs:rw015a.T(i+1,1)*fs))/length(rw015a.T(i,1)*fs:rw015a.T(i+1,1)*fs);
    plot(dur,-rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i+1,1)*fs),'color',[0.75 0.75 0.75]) % plot dive
    plot(dur,rw015a.ph(rw015a.T(i,1)*fs:rw015a.T(i+1,1)*fs),'k') % plot pitch deviation
    %plot([dur(end_desc(i)) dur(end_desc(i))],[-20 0],'k') % plot descent
    %plot([dur(start_asc(i)) dur(start_asc(i))],[-20 0],'k')

subplot(212); hold on

scatter(zeros(length(hz_all(phase_hz == -1 & cond == 0)),1)-rand(length(hz_all(phase_hz == -1 & cond == 0)),1)/4,...
    hz_all(phase_hz == -1 & cond == 0),'kv','filled') % normal descent
scatter(zeros(length(hz_all(phase_hz == -1 & cond == 1)),1)+0.5-rand(length(hz_all(phase_hz == -1 & cond == 1)),1)/4,...
    hz_all(phase_hz == -1 & cond == 1),'bv','filled') % entangled descent
scatter(zeros(length(hz_all(phase_hz == 0 & cond == 0)),1)+1-rand(length(hz_all(phase_hz == 0 & cond == 0)),1)/4,...
    hz_all(phase_hz == 0 & cond == 0),'ko','filled') % normal bottom
scatter(zeros(length(hz_all(phase_hz == 0 & cond == 1)),1)+1.5-rand(length(hz_all(phase_hz == 0 & cond == 1)),1)/4,...
    hz_all(phase_hz == 0 & cond == 1),'bo','filled') % entangled bottom
scatter(zeros(length(hz_all(phase_hz == 1 & cond == 0)),1)+2-rand(length(hz_all(phase_hz == 1 & cond == 0)),1)/4,...
    hz_all(phase_hz == 1 & cond == 0),'kv','filled') % normal ascent
scatter(zeros(length(hz_all(phase_hz == 1 & cond == 1)),1)+2.5-rand(length(hz_all(phase_hz == 1 & cond == 1)),1)/4,...
    hz_all(phase_hz == 1 & cond == 1),'bv','filled') % entangled ascent
scatter(zeros(length(hz_all(phase_hz == 2 & cond == 0)),1)+3-rand(length(hz_all(phase_hz == 2 & cond == 0)),1)/4,...
    hz_all(phase_hz == 2 & cond == 0),'ks') % normal surf
scatter(zeros(length(hz_all(phase_hz == 2 & cond == 1)),1)+3.5-rand(length(hz_all(phase_hz == 2 & cond == 1)),1)/4,...
    hz_all(phase_hz == 2 & cond == 1),'bs') % entangled surf

ylabel('Fluke Stroke Rate (Hz)')

