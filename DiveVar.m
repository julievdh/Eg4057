% Dive Variance

% Calculates variance in depth when below mean depth
% Inputs
% dives = dive cues and depths from finddives
% p = depth record from tag
% fs = sampling rate
% i = dive number 

function [diveVar,fullVar] = DiveVar(dives,p,fs,i)
dstart = dives(i,1);
dend = dives(i,2);
time = 0:length(-p(fs*dstart:fs*dend))-1;

figure(100); clf; hold on;
ylim([-30 0])
plot(time,-p(dstart*fs:dend*fs))
plot(time,-repmat(dives(i,3),length(time),1))
plot(time,-repmat(dives(i,5),length(time),1))

% find below mean depth
ind = find(p(dstart*fs:dend*fs) > dives(i,5));
% find first and last times below mean depth
ind1 = ind(1); ind2 = ind(end);
plot(time(ind1),-p(dstart*fs+ind1),'r.')
plot(time(ind2),-p(dstart*fs+ind2),'r.')

% find indices in p vector (for ease and familiarity)
pind = dstart*fs+ind1:dstart*fs+ind2;

% plot depth below mean depth
plot(time(ind1:ind2),-p(pind),'g')

% calculate RMS within this time period
diveVar = var(p(pind));
fullVar = var(dstart*fs:dend*fs);

text(10,-20,num2str(diveVar))
text(10,-22,num2str(fullVar))

end
