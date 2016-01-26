% make vector of ifi
ifi_all_3911 = vertcat(nanmean(ifi_d')',nanmean(ifi_b')',nanmean(ifi_a')');
hz_all_3911 = vertcat(hz_d',hz_b',hz_a');

% make accompanying vector of individual. should be same length (one entry
% for each dive)
indv = repmat(3911,length(ifi_all_3911),1);

% make accompanying vector of condition. should be high/low x 3
highlow = vertcat(ones(53,1),zeros(101,1));
cond = repmat(highlow,3,1);

% make accompanying vector of dive phase
phase_ifi = vertcat(repmat(-1,length(ifi_d),1),repmat(0,length(ifi_b),1),repmat(1,length(ifi_a),1));
phase_hz = vertcat(repmat(-1,length(hz_d),1),repmat(0,length(hz_b),1),repmat(1,length(hz_a),1));

% two way anova phase, condition
[p,t,stats] = anovan(ifi_all_3911,{phase_ifi,cond},'varnames',{'Phase','Condition'});
[c,m,h,names] = multcompare(stats,'dim',2);

%% LOAD 4057 STUFF IN TOO AND DO THEM TOGETHER WITH INDIVIDUAL AS PARAMETER