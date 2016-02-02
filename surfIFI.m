function [ifi_s,hz_s] = surfIFI(tag,maxtab)

for i = 1:length(tag.T)-1;
    figure(1); clf; hold on
    plot(-tag.p(tag.T(i,2)*tag.fs:tag.T(i+1,1)*tag.fs),'color',[0.75 0.75 0.75]) % plot surface interval
    plot(tag.ph(tag.T(i,2)*tag.fs:tag.T(i+1,1)*tag.fs),'k') % plot pitch deviation
    % find fluke strokes
    ii = find(maxtab(:,1) > tag.T(i,2)*tag.fs & maxtab(:,1) < tag.T(i+1,1)*tag.fs);
    if isempty(ii) == 1 | size(ii) < 2
        count = NaN;
    else
        % calculate mean amplitude (in radians)
        % mn_amp_d(i) = mean(amp(ii));
        % calculate mean amplitude in m
        % mn_amp_dm(i) = mean(abs(sin(rad2deg(amp(ii))*(2/3)*10)));
        
        % calculate mean frequency
        count = size(ii,1);
        dur = tag.T(i+1,1)-tag.T(i,2);
        hz_s(i) = count/dur;
        shift_maxtab = maxtab(ii(2):ii(end),1);
        ifi_s(i,1:count-1) = shift_maxtab(:,1)-maxtab(ii(1):ii(end)-1,1); % in SAMPLES
    end
end

ifi_s(ifi_s == 0) = NaN;
ifi_s(i+1,:) = NaN;
hz_s(i+1) = NaN;
% histogram(ifi_s)
ifi_s_high = ifi_s(1:3,:);
ifi_s_low = ifi_s(54:end);
end
