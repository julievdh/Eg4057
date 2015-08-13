% Freq Amp Plot for 3911?

% Calculate fluke stroke frequency in a 1 s bin and mean maximum fluke
% stroke amplitude

% minute indices

% find fluke strokes within 60 sec
for i = 1:379
    ii = find(rw015a.v > i*60 & rw015a.v < (i+1)*60);
    % calculate frequency
    hz(i) = length(ii)/60;
    % calculate mean amp
    mn_amp(i) = mean(rw015a.mx(ii));
    md_amp(i) = median(rw015a.mx(ii));
end

% find those in low drag
low = round(rw015a.p2(1)/60:rw015a.p3(2)/60);

% find those in high drag
high = round(rw015a.p1(1)/60:rw015a.p1(2)/60);
high = high(2:end); % eliminate zero at beginning

% plot separately
figure(1); clf; hold on
plot(hz(low),mn_amp(low),'ko')
plot(hz(high),mn_amp(high),'bo')
xlabel('Frequency (Hz)'); ylabel('Amplitude (deg)')

figure(2); clf; hold on
plot(hz(low),md_amp(low),'ko')
plot(hz(high),md_amp(high),'bo')
xlabel('Frequency (Hz)'); ylabel('Amplitude (deg)')

%%
hz = [hz(low) hz(high)]';
md_amp = [md_amp(low) md_amp(high)]';
mn_amp = [mn_amp(low) mn_amp(high)]';
cond = [zeros(1,length(low)) ones(1,length(high))]';

%% fit lm 
clear table
tbl = table(hz,md_amp,mn_amp);
tbl.cond = nominal(cond);
fit = fitlm(tbl,'md_amp~hz*cond')

gscatter(hz,md_amp,cond,'kb')