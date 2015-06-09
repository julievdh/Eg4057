% Plot Fluke Stroke over duty cycle

function [ifi,maxtab,mintab] = dutycycleplot(periods,ph,fs)
% find fluke strokes with peak detector
[maxtab,mintab] = peakdet(ph,0.01);


%% Duty Cycle
% find fluke stroke cues that are within period 1 
ii = find(maxtab(:,1) > periods(1)*fs & maxtab(:,1) < periods(2)*fs);
% check
% figure(1); hold on
% plot(ph)
% plot(maxtab(ii,1),ph(maxtab(ii,1)),'k.')

% calculate 90% quantile
th = quantile(diff(maxtab(ii,1)),0.9); % in samples

figure(21); clf; hold on
for i = 1:length(ii)-1
    ind1 = maxtab(ii(i),1);
    ind2 = maxtab(ii(i+1),1);
    ifi(1,i) = ind2-ind1;
    if maxtab(ii(i+1))-maxtab(ii(i)) < th
 % plot duration of fluke stroke in SECONDS not in CUES
    patchline((1:length(ph(ind1:ind2)))/fs,ph(ind1:ind2),'edgecolor','k','edgealpha',0.1)
    end
end
set(gca,'Xtick',[0 1 2 3 4])
xlabel('Time (s)')
ylabel('Pitch deviation from mean')
ylim([min(ph) max(ph)])
title('P1','FontSize',13)
adjustfigurefont

% 
% %% p2
% ii = find(maxtab(:,1) > periods(3)*fs & maxtab(:,1) < periods(4)*fs);
% % check
% % plot(maxtab(ii,1),ph(maxtab(ii,1)),'k.')
% 
% % calculate 90% quantile
% th = quantile(diff(maxtab(ii,1)),0.9); % in samples
% 
% figure(21); hold on
% 
% for i = 1:length(ii)-1
%     ind1 = maxtab(ii(i),1);
%     ind2 = maxtab(ii(i+1),1);
%     ifi(2,i) = ind2-ind1;
%     if maxtab(ii(i+1))-maxtab(ii(i)) < th
% %     figure(11)
% %     plot(maxtab(ii(i),1),eg047a.ph(maxtab(ii(i),1)),'k.')
%    % figure(22)
%     patchline((1:length(ph(ind1:ind2)))/fs,ph(ind1:ind2),'edgecolor','k','edgealpha',0.1)
%     end
% end
% xlabel('Time (s)')
% ylabel('Pitch deviation from mean')
% ylim([min(ph) max(ph)])
% % title('P2','FontSize',13)
% adjustfigurefont
% 
% %% p3
% clear ii
% ii = find(maxtab(:,1) > periods(5)*fs & maxtab(:,1) < periods(6)*fs);
% % check
% % plot(maxtab(ii,1),ph(maxtab(ii,1)),'k.')
% 
% % calculate 90% quantile
% th = quantile(diff(maxtab(ii,1)),0.9); % in samples
% 
% figure(23); hold on
% 
% for i = 1:length(ii)-1
%     ind1 = maxtab(ii(i),1);
%     ind2 = maxtab(ii(i+1),1);
%     ifi(3,i) = ind2-ind1;
%     if maxtab(ii(i+1))-maxtab(ii(i)) < th
% %     figure(11)
% %     plot(maxtab(ii(i),1),eg047a.ph(maxtab(ii(i),1)),'k.')
%     % figure(23)
%     patchline((1:length(ph(ind1:ind2)))/fs,ph(ind1:ind2),'edgecolor','k','edgealpha',0.1)
%     end
% end
% xlabel('Time (s)')
% ylabel('Pitch deviation from mean')
% ylim([min(ph) max(ph)])
% title('P3','FontSize',13)
% adjustfigurefont
% 
% 
