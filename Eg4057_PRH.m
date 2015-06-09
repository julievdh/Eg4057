% Eg4057 PRH Attempt and Problems

% set tag path
path = 'F:\eg14\eg14_047a\';
settagpath('cal',[path 'cal\'],'prh',[path 'prh\'],'raw',[path 'raw\'],'audit',[path 'audit\'])
settagpath('audio','F:\')
tag = 'eg14_047a';

% load prh
loadprh(tag)

% create time vector
t = (1:length(p))/fs;

% known time cues
tagstart = [2014 2 16 15 42 10];
tagon = [2014 2 16 15 49 00];
FWC_0733 = [2014 2 16 15 51 32]; % photo FWC 0733
FWC_0739 = [2014 2 16 15 52 32]; % photo FWC 0739
FWC_1251 = [2014 2 16 17 57 06]; % photo FWC 1251
orion = [2014 2 16 18 05 00]; % arrived on scene
buoyon = [2014 2 16 18 39 00];
tagoff = [2014 2 16 19 23 00]; %ish

tagon_cue = etime(tagon,tagstart);
FWC_0733_cue = etime(FWC_0733,tagstart);
FWC_0739_cue = etime(FWC_0739,tagstart);
FWC_1251_cue = etime(FWC_1251,tagstart);
orion_cue = etime(orion,tagstart);
removed_cue = 9922; % orion on scene, removed additional 12 m, kept telemetry
buoyon_cue = etime(buoyon,tagstart);
tagoff_cue = etime(tagoff,tagstart);


figure(10); clf; hold on
set(gcf,'position',[5 378 1595 420])
plot(t,norm2(A)) % plot norm to see if major slips/rubs that caused tag to move
% plot(PRH(1:end-1,1),PRH(1:end-1,2:4),'.-') % plot PRH predicted values
plot(t,-p/max(p),'k') % plot normalized depth

plot([tagon_cue tagon_cue],[-3 3],'k--')
plot([orion_cue orion_cue],[-3 3],'r-')
plot([removed_cue removed_cue],[-3 3],'r--')
plot([buoyon_cue buoyon_cue],[-3 3],'r--')
plot([tagoff_cue tagoff_cue],[-3 3],'k--')

xlabel('Time since tag start (s)')
legend('norm2(A)','p','r','h','depth','location','SE')
box on

%
% used ginput to guess consistent periods
p1 = [tagon_cue 4711];
p2 = [5133 orion_cue];
p3 = [11350 tagoff_cue];

plot(p1,[2.5 2.5],'k','LineWidth',3)
plot(p2,[2.5 2.5],'k','LineWidth',3)
plot(p3,[2.5 2.5],'k','LineWidth',3)

return

%% make OTAB based on three periods identified in Fig 10
% 
% OTAB(1,:) = [0 0 mean(PRH(1:7,2:4))];
% OTAB(2:8,:) = [PRH(1:7,1) PRH(2:8,1) repmat(mean(PRH(1:7,2:4)),7,1)];
% OTAB(9:20,:) = [PRH(8:19,1) PRH(9:20,1) repmat(mean(PRH([8 10:19],2:4)),12,1)];
% OTAB(21:22,:) = [PRH(20:21,1) PRH(21:22,1) PRH(20:21,2:4)];
% OTAB(23:28,:) = [PRH(24:29,1) PRH(25:30,1) repmat(mean(PRH(24:29,2:4)),6,1)];
% OTAB(29,:) = [PRH(30,1) tagoff_cue mean(PRH(24:29,2:4))];
% plot(OTAB(:,1),OTAB(:,3:5),':')
% 
% % calculate tag2whale
% [Aw,Mw]=tag2whale(A,M,OTAB,fs);
% mean(Aw(p1(1)*fs:p1(2)*fs,:)) % average values
% mean(Aw(p2(1)*fs:p2(2)*fs,:)) 
% mean(Aw(p3(1)*fs:p3(2)*fs,:))

%% plot Aw and check pitch of sections
figure(12); clf; hold on
% plot(PRH(1:end-1,1),PRH(1:end-1,2:4),'.-')
plot(t,Aw)
plot(t,-p/max(p),'k')
plot(OTAB(:,1),OTAB(:,3:5),':')

% % change OTAB a little
% OTAB(9:24,:) = [PRH(8:23,1) PRH(9:24,1) repmat(mean(PRH([8 10:23],2:4)),16,1)];
% % OTAB(23:24,:) = [PRH(22:23,1) PRH(23:24,1) repmat(mean(PRH(22:23,2:4)),2,1)];
% OTAB(25:30,:) = [PRH(24:29,1) PRH(25:30,1) repmat(mean(PRH(24:29,2:4)),6,1)];
% OTAB(31,:) = [PRH(30,1) tagoff_cue mean(PRH(24:29,2:4))];
% plot(OTAB(:,1),OTAB(:,3:5),':')
% % calculate Aw again
% [Aw_new,Mw_new]=tag2whale(A,M,OTAB,fs);
% plot(t,Aw_new(:,1),'c'); plot(t,Aw_new(:,2),'m'); plot(t,Aw_new(:,3),'y')
% mean(Aw_new(p1(1)*fs:p1(2)*fs,:))
% mean(Aw_new(p2(1)*fs:p2(2)*fs,:)) % average values
% mean(Aw_new(p3(1)*fs:p3(2)*fs,:))

% % Aw new is worse.

%% plot Aw_new with periods and final OTAB
figure(20); hold on
set(gcf,'position',[5 378 1595 420])
plot(t,Aw)
plot(t,-p/max(p),'k') % plot normalized depth
plot([tagon_cue tagon_cue],[-3 3],'k--')
plot([buoyon_cue buoyon_cue],[-3 3],'k--')
plot([tagoff_cue tagoff_cue],[-3 3],'k--')
plot(p1,[2.5 2.5],'k','LineWidth',3)
plot(p2,[2.5 2.5],'k','LineWidth',3)
plot(p3,[2.5 2.5],'k','LineWidth',3)
plot(OTAB(:,1),OTAB(:,3:5),'.-')

% plot time of photos
plot([FWC_0733_cue FWC_0733_cue],[-2 3],'k')
plot([FWC_1251_cue FWC_1251_cue],[-2 3],'k')


% plot time Orion present + attaching buoy
patch([orion_cue buoyon_cue buoyon_cue orion_cue],[-2 -2 3 3],'k','FaceAlpha',0.5)


ylim([-2 3])
xlabel('Time since tag start (s)')
legend('p','r','h','depth','location','NE')
box on
