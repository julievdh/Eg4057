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
