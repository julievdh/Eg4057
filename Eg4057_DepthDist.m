path = 'E:\eg14\eg14_047a\';
settagpath('cal',[path 'cal\'],'prh',[path 'prh\'],'raw',[path 'raw\'],'audit',[path 'audit\'])
settagpath('audio','E:\')
tag = 'eg14_047a';

loadprh(tag)

% create time vector (seconds since tag on)
t = [1:length(A)]/fs;

figure(1); set(gcf,'position',[320 360 1020 420])
subplot('position',[0.28 0.1 0.7 0.8]); hold on
plot(t,-p); box on

% create time cues
tagstart = [2014 2 16 15 42 10];
tagon = [2014 2 16 15 49 00];
buoyon = [2014 2 16 18 39 00];
tagoff = [2014 2 16 19 23 00]; %ish

tagon_cue = etime(tagon,tagstart);
buoyon_cue = etime(buoyon,tagstart);
tagoff_cue = etime(tagoff,tagstart);

plot([tagon_cue tagon_cue],[-30 5],'r')
plot([buoyon_cue buoyon_cue],[-30 5],'r')
plot([tagoff_cue tagoff_cue],[-30 5],'r')

% plot info/axis management
set(gca,'ytick',[-30:5:0],'yticklabel',{'30','25','20','15','10','5','0'})
set(gca,'xtick',[0:60*60:length(A)],'xticklabel',{'0','1','2','3','4'})
xlabel('Time since tag on (hours)')

% calculate depth distribution
h = histc(p(tagon_cue*fs:tagoff_cue*fs),[0:30]);
plot(t(tagon_cue*fs:tagoff_cue*fs),-p(tagon_cue*fs:tagoff_cue*fs),'k')
subplot('position',[0.05 0.1 0.2 0.8])
barh((h/max(h))*100)
axis ij; ylim([-5 30]); ylabel('Depth (m)')
set(gca,'ytick',[0:5:30])
xlabel('% Time in Depth Bin')

