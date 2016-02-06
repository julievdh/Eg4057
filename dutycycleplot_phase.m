% Plot Fluke Stroke over duty cycle

function [dur,maxtab,mintab] = dutycycleplot_phase(periods,ph,fs)
% find fluke strokes with peak detector
[allmaxtab,allmintab] = peakdet(ph,0.01);

%% Duty Cycle
% find fluke stroke cues that are within specified
for i = 1:length(periods)
    if (round(periods(i)) == [3885 | 9562 | 11009] ) == 1
        maxtab = []; mintab = [];
        dur = [];
    else
        ii = find(allmaxtab(:,1) > periods(i,1)*fs & allmaxtab(:,1) < periods(i,2)*fs);
        maxtab = allmaxtab(ii,:); mintab = allmintab(ii,:);

    
    % check
    % figure(1); hold on
    % plot(ph)
    % plot(maxtab(ii,1),ph(maxtab(ii,1)),'k.')
    
    % calculate 90% quantile
    th = quantile(diff(allmaxtab(:,1)),0.9); % in samples

    % figure(21); clf; hold on
    % get axis info
    ax1 = gca;
    for i = 1:length(ii)-1
        ind1 = maxtab(i,1);
        ind2 = maxtab(i+1,1);
        dur(1,i) = (ind2-ind1)/fs; % fluke stroke cycle duration in SECONDS
        if maxtab(i+1)-maxtab(i) < th
            % plot duration of fluke stroke in SECONDS not in CUES
            patchline((1:length(ph(ind1:ind2)))/fs,ph(ind1:ind2),'edgecolor','k','edgealpha',0.1,'parent',ax1)
        end
    end
    end
end


