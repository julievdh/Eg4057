% calculate proportional depth

% run DepthDist to get tag data, depth data, ground data
DepthDist

%% find dives on both records
eg047a.T = finddives(eg047a.p,fs,5,1,0);
rw015a.T = finddives(rw015a.p,fs,5,1,0);

% interpolate ground data to dive times
% sample points = ground_4057(:,9), corresponding values (depths) = 
% ground_4057(:,8), query points = cue at max depth for dives = T(:,4)
vq_4057 = interp1(ground_4057(:,9),ground_4057(:,8),eg047a.T(:,4));
vq_3911 = interp1(ground_3911(:,9),ground_3911(:,8),rw015a.T(:,4));

% calculate proportional depth of dives
eg047a.pdepth = eg047a.T(:,3)./vq_4057;
rw015a.pdepth = rw015a.T(:,3)./vq_3911;

%% are proportional dives shallower in high drag/buoyancy condition?

% find dives in high/low drag/buoyancy conditions
% 0 = low, 1 = high
eg047a.pdepth(:,2) = eg047a.T(:,1) < 8571;
rw015a.pdepth(:,2) = rw015a.T(:,1) < rw015a.p1(2);

% boxplot
figure
boxplot(rw015a.pdepth(:,1),rw015a.pdepth(:,2))
boxplot(eg047a.pdepth(:,1),eg047a.pdepth(:,2))

% ANOVA -- individual and condition
individual = vertcat(repmat(4057,length(eg047a.T),1),repmat(3911,length(rw015a.T),1));
condition = vertcat(eg047a.pdepth(:,2),rw015a.pdepth(:,2));
[p,table,stats] = anovan(vertcat(eg047a.pdepth(:,1),rw015a.pdepth(:,1)),{individual condition},'varnames',{'Individual','Condition'});
[c,m,h,nms] = multcompare(stats,'dim',2);