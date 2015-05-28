% plot depth record and depth distribution for two tags

% load tags
load_eg047a
load_rw015a

figure(1); clf; set(gcf,'position',[320 360 1020 420])
subplot('position',[0.28 0.55 0.7 0.4]); hold on
plot(rw015a.t(rw015a.p1(1)*fs:rw015a.p1(2)*fs),-rw015a.p(rw015a.p1(1)*fs:rw015a.p1(2)*fs),'k'); box on
plot(rw015a.t(rw015a.p2(1)*fs:rw015a.p3(2)*fs),-rw015a.p(rw015a.p2(1)*fs:rw015a.p3(2)*fs),'b'); box on

% plot info/axis management
ylim([-22 1]); xlim([0 22532])
set(gca,'ytick',[-20:5:0],'yticklabel',{'20','15','10','5','0'})
set(gca,'xtick',[0:60*60:length(rw015a.p)],'xticklabel',{'0','1','2','3','4','5','6'})

% calculate depth distribution
% while entangled
[h1,b] = hist(rw015a.p(rw015a.p1(1)*fs:rw015a.p1(2)*fs),[0:2:22]);
[h2,b] = hist(rw015a.p(rw015a.p2(1)*fs:rw015a.p3(2)*fs),[0:2:22]);
h1 = h1/sum(h1);
h2 = h2/sum(h2);
subplot('position',[0.05 0.55 0.2 0.4])
h = barh(b,[h1;h2]','grouped');
axis ij; ylim([-1 22]); ylabel('Depth (m)')
set(gca,'ytick',[0:5:30])
set(h(1),'FaceColor','k')
set(h(2),'FaceColor','b')

%% Eg 4057
subplot('position',[0.28 0.1 0.7 0.4]); hold on
plot(eg047a.t(eg047a.p1(1)*fs:10610*fs),-eg047a.p(eg047a.p1(1)*fs:10610*fs),'k'); box on
plot(eg047a.t(10610*fs:eg047a.p3(2)*fs),-eg047a.p(10610*fs:eg047a.p3(2)*fs),'r'); box on

% plot info/axis management
ylim([-31 1]); xlim([eg047a.p1(1) 13364])
set(gca,'ytick',[-31:5:0],'yticklabel',{'30','25','20','15','10','5','0'})
set(gca,'xtick',[0:60*60:length(eg047a.p)],'xticklabel',{'0','1','2','3','4','5','6'})
xlabel('Time since tag on (hours)')

% calculate depth distribution
% while entangled
[h3,b] = hist(eg047a.p(eg047a.p1(1)*fs:10610*fs),[0:2:31]);
[h4,b] = hist(eg047a.p(10610*fs:eg047a.p3(2)*fs),[0:2:31]);
h3 = h3/sum(h3);
h4 = h4/sum(h4);
subplot('position',[0.05 0.1 0.2 0.4])
h = barh(b,[h3;h4]','grouped');
axis ij; ylim([-1 31]); ylabel('Depth (m)')
set(gca,'ytick',[0:5:31])
set(h(1),'FaceColor','k')
set(h(2),'FaceColor','r')
xlabel('% Time in Depth Bin')