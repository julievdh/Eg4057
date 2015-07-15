% calculate proportional depth

% run DepthDist to get tag data, depth data, ground data
DepthDist

%% find dives on both records
eg047a.T = finddives(eg047a.p,fs,1,1,0);
rw015a.T = finddives(rw015a.p,fs,1,1,0);

% interpolate ground data to dive times
% sample points = ground_4057(:,9), corresponding values (depths) = 
% ground_4057(:,8), query points = cue at max depth for dives = T(:,4)
vq_4057 = interp1(ground_4057(:,9),ground_4057(:,8),eg047a.T(:,4));
vq_3911 = interp1(ground_3911(:,9),ground_3911(:,8),rw015a.T(:,4));

% calculate proportional depth of dives
eg047a.pdepth = eg047a.T(:,3)./vq_4057;
rw015a.pdepth = rw015a.T(:,3)./vq_3911;

% plot this
figure(2)
plot(rw015a.t,-rw015a.p)
hold on
plot(ground_3911(:,9),-ground_3911(:,8),'.-')
plot(rw015a.T(:,1),-rw015a.T(:,3),'r*')
plot(rw015a.T(:,1),-vq_3911,'c.')

%% are proportional dives shallower in high drag/buoyancy condition?

% find dives in high/low drag/buoyancy conditions
% 0 = low, 1 = high
eg047a.pdepth(:,2) = eg047a.T(:,1) > 8571; % high drag is later
rw015a.pdepth(:,2) = rw015a.T(:,1) < rw015a.p1(2); % high drag is before

% boxplot
figure(1)
[h3,b] = hist(rw015a.pdepth(rw015a.T(:,1) > rw015a.p1(2))); % low drag/buoyancy
[h4,b] = hist(rw015a.pdepth(rw015a.T(:,1) < rw015a.p1(2))); % high drag/buoyancy
[h1,b] = hist(eg047a.pdepth(eg047a.T(:,1) < 8571)); % low drag/buoyancy
[h2,b] = hist(eg047a.pdepth(eg047a.T(:,1) > 8571)); % high drag/buoyancy
h3 = h3/sum(h3);
h4 = h4/sum(h4);
h1 = h1/sum(h1);
h2 = h2/sum(h2);

subplot('position',[0.05 0.55 0.2 0.4])
h = barh(b,[h3;h4]','grouped');
axis ij; ylabel('Depth (m)')
set(gca,'ytick',[0:5:30])
set(h(1),'FaceColor','k')
set(h(2),'FaceColor','b')

subplot('position',[0.05 0.1 0.2 0.4])
h = barh(b,[h1;h2]','grouped');
axis ij; ylabel('Depth (m)')
set(gca,'ytick',[0:5:30])
set(h(1),'FaceColor','k')
set(h(2),'FaceColor','b')


% ANOVA -- individual and condition
individual = vertcat(repmat(4057,length(eg047a.T),1),repmat(3911,length(rw015a.T),1));
condition = vertcat(eg047a.pdepth(:,2),rw015a.pdepth(:,2));
[p,table,stats] = anovan(vertcat(eg047a.pdepth(:,1),rw015a.pdepth(:,1)),{individual condition},'varnames',{'Individual','Condition'});
[c,m,h,nms] = multcompare(stats,'dim',2);

%% is there a difference in duration? 
[p,table,stats] = anovan(vertcat(eg047a.T(:,2)-eg047a.T(:,1),rw015a.T(:,2)-rw015a.T(:,1)),{individual condition},'varnames',{'Individual','Condition'});
[c,m,h,nms] = multcompare(stats,'dim',2);

dur_4057 = eg047a.T(:,2)-eg047a.T(:,1); % dive duration in sec
mean(dur_4057(eg047a.T(:,2) < 8571,1)) % low drag 
mean(dur_4057(eg047a.T(:,2) > 8571,1)) % high drag

dur_3911 = rw015a.T(:,2)-rw015a.T(:,1); % dive duration in sec
mean(dur_3911(rw015a.T(:,2) > rw015a.p1(2),1)) % low drag 
mean(dur_3911(rw015a.T(:,2) < rw015a.p1(2),1)) % high drag

%% 
figure(5); clf; hold on
errorbar(mean(eg047a.pdepth(eg047a.pdepth(:,2) == 0,1)),mean(eg047a.pdepth(eg047a.pdepth(:,2) == 1,1)),std(eg047a.pdepth(eg047a.pdepth(:,2) == 1,1)),'^')
errorbar(mean(rw015a.pdepth(rw015a.pdepth(:,2) == 0,1)),mean(rw015a.pdepth(rw015a.pdepth(:,2) == 1,1)),std(rw015a.pdepth(rw015a.pdepth(:,2) == 1,1)),'r^')
plot([0 1],[0 1],'k')
xlabel('Low Drag'); ylabel('High Drag')

