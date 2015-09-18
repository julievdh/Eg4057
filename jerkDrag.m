% Jerk
load_rw015a
loadprh(tag)
%%
% calculate jerk and MSA
j = njerk(rw015a.A,fs);
m = msa(rw015a.A);
t = (1:length(rw015a.A))/fs;

% get pitch deviation
[~,rw015a.ph,~,~] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 8]);

%% plot 
figure(1); clf
subplot(121);hold on
plot(t(rw015a.p1(1)*fs:rw015a.p1(2)*fs),j(rw015a.p1(1)*fs:rw015a.p1(2)*fs))
plot(t(rw015a.p1(1)*fs:rw015a.p1(2)*fs),-rw015a.p(rw015a.p1(1)*fs:rw015a.p1(2)*fs),'k')
plot(t(rw015a.p1(1)*fs:rw015a.p1(2)*fs),rw015a.ph(rw015a.p1(1)*fs:rw015a.p1(2)*fs),'r')
plot(t(rw015a.p1(1)*fs:rw015a.p1(2)*fs),m(rw015a.p1(1)*fs:rw015a.p1(2)*fs),'g')
ylim([-30 50]); xlim([0 6670])
plot([0 6670],[mean(j)+2*std(j) mean(j)+2*std(j)],'k')

subplot(122);hold on
plot(t(rw015a.p2(1)*fs:rw015a.p3(2)*fs),j(rw015a.p2(1)*fs:rw015a.p3(2)*fs))
plot(t(rw015a.p2(1)*fs:rw015a.p3(2)*fs),-rw015a.p(rw015a.p2(1)*fs:rw015a.p3(2)*fs),'k')
plot(t(rw015a.p2(1)*fs:rw015a.p3(2)*fs),rw015a.ph(rw015a.p2(1)*fs:rw015a.p3(2)*fs),'r')
plot(t(rw015a.p2(1)*fs:rw015a.p3(2)*fs),m(rw015a.p2(1)*fs:rw015a.p3(2)*fs),'g')
ylim([-30 50]); xlim([6600 22300])
plot([6600 22300],[mean(j)+2*std(j) mean(j)+2*std(j)],'k')


%% find dives
rw015a.T = finddives(rw015a.p,fs,5,1);              % find dives
figure(3); clf; hold on; ylim([-30 50])
% plot random high drag dive
i = randi([1,53]);
plot(-rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'b')
plot(j(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'b')
% plot random low drag dive
i = randi([54,154]);
plot(-rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'k')
plot(j(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'k')

%% what is meanSD jerk within dives?
for i = 1:length(rw015a.T)
    mn_j(i) = mean(j(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs));
std_j(i) = std(j(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs));
end
figure(4); hold on
bins = 0:0.5:6;
h1 = hist(mn_j(1:53),bins);
h2 = hist(mn_j(54:end),bins);
h = bar(bins,[h1;h2]',1.2,'grouped');
legend('High','Low')
% so then this+2SD should be the cutoff for transients within dives
cutoff = mean(mn_j)+2*(mean(std_j));
%% FIND NUMBER OF TRANSIENTS IN DIVE
% NOT WITHIN FIRST OR LAST FEW SECONDS DUE TO SURFACING

for i = 1:154;
j_select = j(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs);
ii = find(j_select >= cutoff);
% eliminate those within first and last second of dive, high jerk is
% caused by surfacing
ii(ii<5) = NaN;
ii(ii>length(j_select)-5) = NaN;
ii(isnan(ii))=[]; % remove NaNs
% plot
figure(5); clf; hold on
plot(-rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'b')
plot(j_select,'b')
plot(ii,j_select(ii),'g*')
plot([0 length(j_select)],[cutoff cutoff],'g')
% store
trans(i) = length(ii)-sum(isnan(ii));
% pause
end

