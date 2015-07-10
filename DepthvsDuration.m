% depth vs duration

% run DepthDist to get tag data, depth data, ground data
DepthDist

%% find dives on both records
eg047a.T = finddives(eg047a.p,fs,1,1,0);
rw015a.T = finddives(rw015a.p,fs,1,1,0);

%% establish other relevant information
% find dives in high/low drag/buoyancy conditions
% 0 = low, 1 = high
eg047a.cond = eg047a.T(:,1) > 8571; % high drag is later
rw015a.cond = rw015a.T(:,1) < rw015a.p1(2); % high drag is before

individual = vertcat(repmat(4057,length(eg047a.T),1),repmat(3911,length(rw015a.T),1));
condition = vertcat(eg047a.cond,rw015a.cond);

Depths = vertcat(eg047a.T(:,3),rw015a.T(:,3));
Durations = vertcat(eg047a.T(:,2)-eg047a.T(:,1),rw015a.T(:,2)-rw015a.T(:,1));

%% dive duration vs. depth
figure(4); clf; hold on
gscatter(Depths,Durations,{individual,condition},'kbgr')
legend('Location','NW')
ylabel('Dive Duration (sec)'); xlabel('Dive Depth (m)')

% log?
figure(5); clf; hold on
gscatter(log(Depths),log(Durations),{individual,condition},'kbgr')
legend('Location','NW')
xlabel('Dive Depth (m)'); ylabel('Dive Duration (sec)')
%% fit linear models to different relationships
Depths = log(Depths);
Durations = log(Durations);
d = table(Depths,Durations);
d.Condition = nominal(condition);
d.Individual = nominal(individual);
lm = fitlm(d,'Durations ~ Depths*Condition*Individual')

w = linspace(min(Depths),max(Depths));
figure(4);
line(w,feval(lm,w,'false','3911'),'Color','k','LineWidth',2)
line(w,feval(lm,w,'true','3911'),'Color','b','LineWidth',2)
line(w,feval(lm,w,'false','4057'),'Color','g','LineWidth',2)
line(w,feval(lm,w,'true','4057'),'Color','r','LineWidth',2)
