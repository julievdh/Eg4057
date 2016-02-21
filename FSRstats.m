% make vector of all hz
hz_all_3911 = vertcat(hz_d_3911',hz_b_3911',hz_a_3911',hz_s_3911');
% for 4057: low = [1:6,8:12];                                   % dive 7 tag moves
%           high = [13:15,18:20];                               % dives 16, 17 tag moves
low_4057 = [1:6,8:12]; high_4057 = [13:15,18:20]; 
% select only those ones
hz_d_4057 = hz_d_4057([low_4057 high_4057]);
hz_b_4057 = hz_b_4057([low_4057 high_4057]);
hz_a_4057 = hz_a_4057([low_4057 high_4057]);
hz_s_4057 = hz_s_4057([low_4057 high_4057]);

hz_all_4057 = vertcat(hz_d_4057',hz_b_4057',hz_a_4057',hz_s_4057');
hz_all = vertcat(hz_all_3911,hz_all_4057);

%% make accompanying vector of individual. should be same length (one entry
% for each dive)
indv = vertcat(repmat(3911,length(hz_all_3911),1),repmat(4057,length(hz_all_4057),1));

% make accompanying vector of condition. should be high/low x 4  
highlow = vertcat(ones(53,1),zeros(101,1)); % condition order for 3911size(
lowhigh = vertcat(zeros(11,1),ones(6,1)); % condition order for 4057
cond = vertcat(repmat(highlow,4,1),repmat(lowhigh,4,1));

% make accompanying vector of dive phase
phase_hz = vertcat(-ones(length(hz_d_3911),1),zeros(length(hz_b_3911),1),ones(length(hz_a_3911),1),repmat(2,length(hz_s_3911),1),...
    -ones(length(hz_d_4057),1),zeros(length(hz_b_4057),1),ones(length(hz_a_4057),1),repmat(2,length(hz_s_4057),1));

% three way anova individual, phase, condition
[p,t,stats] = anovan(hz_all,{indv,phase_hz,cond},'varnames',{'Individual','Phase','Condition'});
[c,m,h,names] = multcompare(stats,'dim',3);

return

%% FSR PLOT
rw015a = load('rw11_015aprh.mat'); fs = 5;
rw015a.T = finddives(rw015a.p,fs,5,1);              % find dives
[~,rw015a.ph,~,rw015a.fr] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 8]);


warning off
figure(5); clf; hold on
set(gcf,'position',[785 11 455 595],'paperpositionmode','auto')
subplot('position',[0.1 0.8 0.8 0.2]); hold on
i = 80;
t = (1:length(rw015a.T(i,1)*fs:rw015a.T(i+1,1)*fs))/fs;
plot(t,-rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i+1,1)*fs),'color',[0.75 0.75 0.75]) % plot dive
plot(t,rw015a.ph(rw015a.T(i,1)*fs:rw015a.T(i+1,1)*fs),'k') % plot pitch deviation
ylabel('Depth (m)'); xlabel('Time (sec)'); 
set(gca,'ytick',-15:5:0)

subplot('position',[0.1 0.1 0.8 0.65]); hold on
ylabel('Fluke Stroke Rate (Hz)'); set(gca,'ytick',0:0.5:3); ylim([0 1])
xlim([0 100]); set(gca,'xtick',[6 36 66 91],'xticklabels',...
    {'Descent','Bottom','Ascent','Surface'},'ytick',[0 0.2 0.3 0.5 1])

scatter(zeros(length(hz_all(phase_hz == -1 & cond == 0 & indv == 3911)),1)+5-rand(length(hz_all(phase_hz == -1 & cond == 0 & indv == 3911)),1)*4,...
    hz_all(phase_hz == -1 & cond == 0 & indv == 3911),'kv','filled') % normal descent 3911
scatter(zeros(length(hz_all(phase_hz == -1 & cond == 0 & indv == 4057)),1)+5-rand(length(hz_all(phase_hz == -1 & cond == 0 & indv == 4057)),1)*4,...
    hz_all(phase_hz == -1 & cond == 0 & indv == 4057),'kv') % normal descent 4057
scatter(zeros(length(hz_all(phase_hz == -1 & cond == 1 & indv == 3911)),1)+10-rand(length(hz_all(phase_hz == -1 & cond == 1 & indv == 3911)),1)*4,...
    hz_all(phase_hz == -1 & cond == 1 & indv == 3911),'bv','filled') % entangled descent 3911
scatter(zeros(length(hz_all(phase_hz == -1 & cond == 1 & indv == 4057)),1)+10-rand(length(hz_all(phase_hz == -1 & cond == 1 & indv == 4057)),1)*4,...
    hz_all(phase_hz == -1 & cond == 1 & indv == 4057),'bv') % entangled descent 4057

scatter(zeros(length(hz_all(phase_hz == 0 & cond == 0 & indv == 3911)),1)+35-rand(length(hz_all(phase_hz == 0 & cond == 0 & indv == 3911)),1)*4,...
    hz_all(phase_hz == 0 & cond == 0 & indv == 3911),'ko','filled') % normal bottom 3911
scatter(zeros(length(hz_all(phase_hz == 0 & cond == 0 & indv == 4057)),1)+35-rand(length(hz_all(phase_hz == 0 & cond == 0 & indv == 4057)),1)*4,...
    hz_all(phase_hz == 0 & cond == 0 & indv == 4057),'ko') % normal bottom 4057
scatter(zeros(length(hz_all(phase_hz == 0 & cond == 1 & indv == 3911)),1)+40-rand(length(hz_all(phase_hz == 0 & cond == 1 & indv == 3911)),1)*4,...
    hz_all(phase_hz == 0 & cond == 1 & indv == 3911),'bo','filled') % entangled bottom 3911
scatter(zeros(length(hz_all(phase_hz == 0 & cond == 1 & indv == 4057)),1)+40-rand(length(hz_all(phase_hz == 0 & cond == 1 & indv == 4057)),1)*4,...
    hz_all(phase_hz == 0 & cond == 1 & indv == 4057),'bo') % entangled bottom 4057

scatter(zeros(length(hz_all(phase_hz == 1 & cond == 0 & indv == 3911)),1)+65-rand(length(hz_all(phase_hz == 1 & cond == 0 & indv == 3911)),1)*4,...
    hz_all(phase_hz == 1 & cond == 0 & indv == 3911),'k^','filled') % normal ascent 3911
scatter(zeros(length(hz_all(phase_hz == 1 & cond == 0 & indv == 4057)),1)+65-rand(length(hz_all(phase_hz == 1 & cond == 0 & indv == 4057)),1)*4,...
    hz_all(phase_hz == 1 & cond == 0 & indv == 4057),'k^') % normal ascent 4057
scatter(zeros(length(hz_all(phase_hz == 1 & cond == 1 & indv == 3911)),1)+70-rand(length(hz_all(phase_hz == 1 & cond == 1 & indv == 3911)),1)*4,...
    hz_all(phase_hz == 1 & cond == 1 & indv == 3911),'b^','filled') % entangled ascent
scatter(zeros(length(hz_all(phase_hz == 1 & cond == 1 & indv == 4057)),1)+70-rand(length(hz_all(phase_hz == 1 & cond == 1 & indv == 4057)),1)*4,...
    hz_all(phase_hz == 1 & cond == 1 & indv == 4057),'b^') % entangled ascent 4057

scatter(zeros(length(hz_all(phase_hz == 2 & cond == 0 & indv == 3911)),1)+90-rand(length(hz_all(phase_hz == 2 & cond == 0 & indv == 3911)),1)*4,...
    hz_all(phase_hz == 2 & cond == 0 & indv == 3911),'ks','filled') % normal surf 3911
scatter(zeros(length(hz_all(phase_hz == 2 & cond == 0 & indv == 4057)),1)+90-rand(length(hz_all(phase_hz == 2 & cond == 0 & indv == 4057)),1)*4,...
    hz_all(phase_hz == 2 & cond == 0 & indv == 4057),'ks') % normal surf 4057
scatter(zeros(length(hz_all(phase_hz == 2 & cond == 1 & indv == 3911)),1)+95-rand(length(hz_all(phase_hz == 2 & cond == 1 & indv == 3911)),1)*4,...
    hz_all(phase_hz == 2 & cond == 1 & indv == 3911),'bs','filled') % entangled surf 3911
scatter(zeros(length(hz_all(phase_hz == 2 & cond == 1 & indv == 4057)),1)+95-rand(length(hz_all(phase_hz == 2 & cond == 1 & indv == 4057)),1)*4,...
    hz_all(phase_hz == 2 & cond == 1 & indv == 4057),'bs') % entangled surf 4057

adjustfigurefont
cd /Users/julievanderhoop/Documents/MATLAB/Eg4057/AnalysisFigs
print -dsvg DivePhaseHz

cd /Users/julievanderhoop/Documents/MATLAB/Eg4057
save('FSRvars','cond','hz_all','indv','phase_hz')