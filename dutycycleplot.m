% Plot Fluke Stroke over duty cycle

function [ifi,maxtab,mintab] = dutycycleplot(periods,ph,fs)
% find fluke strokes with peak detector
[maxtab,mintab] = peakdet(ph,0.01);


%% Duty Cycle
% find fluke stroke cues that are within specified 
ii = find(maxtab(:,1) > periods(1)*fs & maxtab(:,1) < periods(2)*fs);
maxtab = maxtab(ii,:); mintab = mintab(ii,:);
% check
% figure(1); hold on
% plot(ph)
% plot(maxtab(ii,1),ph(maxtab(ii,1)),'k.')

% calculate 90% quantile
th = quantile(diff(maxtab(:,1)),0.9); % in samples

% figure(21); clf; hold on
for i = 1:length(ii)-1
    ind1 = maxtab(i,1);
    ind2 = maxtab(i+1,1);
    ifi(1,i) = ind2-ind1;
    if maxtab(i+1)-maxtab(i) < th
 % plot duration of fluke stroke in SECONDS not in CUES
    patchline((1:length(ph(ind1:ind2)))/fs,ph(ind1:ind2),'edgecolor','k','edgealpha',0.1)
    end
end
 
