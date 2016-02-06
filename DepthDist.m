% plot depth record and depth distribution for two tags

close all; clear all

% load tags
load_eg047a
load_rw015a

%% get ground depth
GroundDepth

%% get power timeline 3911
PowerTimelineDetailed_3911

%% plot
figure(1); clf; set(gcf,'position',[320 360 1020 420])
subplot('position',[0.28 0.55 0.62 0.4]); hold on
plot(ground_3911(:,9)/3600,-ground_3911(:,8),'-','color',[0.5 0.5 0.5])
plot(rw015a.t(rw015a.p1(1)*fs:rw015a.p1(2)*fs)/3600,-rw015a.p(rw015a.p1(1)*fs:rw015a.p1(2)*fs),'b'); box on
[hAx,hLine1,hLine2] = plotyy(rw015a.t(rw015a.p2(1)*fs:rw015a.p3(2)*fs)/3600,-rw015a.p(rw015a.p2(1)*fs:rw015a.p3(2)*fs),...
    Tplot(:,1)/3600,Tplot(:,2:5));
set(hAx(1),'ylim',[-32 30],'ytick',[-30:10:0],...
    'yticklabels',{'30','20','10','0'},'xlim',[0 6.182],'ycolor',[0 0 0]); 
set(hAx(2),'ylim',[-1294 1200],'ytick',[0:400:1200], 'xlim',[0 6.182])
set(hLine1,'color','k')
set(hLine2(1:3),'color',[0 0.5 0])
set(hLine2(2:3),'linestyle',':')
set(hLine2(4),'color','r')
ylabel(hAx(2),'                             Force (N)') % right y-axis


%% calculate depth distribution
% while entangled
[h1,b] = hist(rw015a.p(rw015a.p1(1)*fs:rw015a.p1(2)*fs),[0:5:22]);
[h2,b] = hist(rw015a.p(rw015a.p2(1)*fs:rw015a.p3(2)*fs),[0:5:22]);
h1 = h1/sum(h1);
h2 = h2/sum(h2);
subplot('position',[0.05 0.55 0.2 0.4])
h = barh(b,[h1;h2]','grouped');
axis ij; ylim([-30 32]); ylabel('Depth (m)                    ')
set(gca,'ytick',[0:5:30])
set(h(1),'FaceColor','b')
set(h(2),'FaceColor','k')

%% Eg 4057

% get power timeline
PowerTimelineDetailed_4057

% plot
figure(1)
subplot('position',[0.28 0.1 0.62 0.4]); hold on
plot(ground_4057(:,9)/(3600),-ground_4057(:,8),'-','color',[0.5 0.5 0.5])
plot(eg047a.t(eg047a.p1(1)*fs:10610*fs)/3600,-eg047a.p(eg047a.p1(1)*fs:10610*fs),'k'); box on
[hAx,hLine1,hLine2] = plotyy(eg047a.t(8571*fs:eg047a.p3(2)*fs)/3600,-eg047a.p(8571*fs:eg047a.p3(2)*fs),...
    Tplot(:,1)/3600,Tplot(:,2:5));
set(hAx(1),'ylim',[-32 30],'ytick',[-30:10:0],...
    'yticklabels',{'30','20','10','0'},'xlim',[0 6.182],'xtick',[0 1 2 3],'ycolor',[0 0 0])
set(hAx(2),'ylim',[-181 170],'ytick',[0:40:160],'xlim',[0 6.182],'xtick',[0 1 2 3])
set(hLine2(1:3),'color',[0 0.5 0])
set(hLine2(4),'color','r')
set(hLine2(2:3),'linestyle',':')
xlabel('Time since tag on (hours)'); 
ylabel(hAx(2),'                             Force (N)') % right y-axis

% calculate depth distribution
% while entangled
[h3,b] = hist(eg047a.p(eg047a.p1(1)*fs:10610*fs),[0:5:31]);
[h4,b] = hist(eg047a.p(8571*fs:eg047a.p3(2)*fs),[0:5:31]);
h3 = h3/sum(h3);
h4 = h4/sum(h4);
subplot('position',[0.05 0.1 0.2 0.4])
h = barh(b,[h3;h4]','grouped');
axis ij; ylim([-30 32]); ylabel('Depth (m)                    ')
set(gca,'ytick',[0:5:31])
set(h(1),'FaceColor','k')
set(h(2),'FaceColor','b')
xlabel('% Time in Depth Bin')

% adjustfigurefont
%% print

cd C:\Users\Julie\Documents\MATLAB\Eg4057\AnalysisFigs
print('DepthDist','-dtiff','-r300')