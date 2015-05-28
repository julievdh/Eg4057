% NormalizedDive
% plot dives, normalized in time

% inputs:
% dive = dive info from finddives
% p = pressure sensor reading from tag
% fs = sampling rate (Hz)
% optional state = entangled, non entangled, buoy added; default = black
% color
% optional figno = figure number on which to plot depth by normalized time
function [dstart,dend,ntime] = NormalizedDive(dive,p,fs,state,figno)

if nargin < 4
    state = 1;
    figno = 199;
end


dstart = dive(1);
dend = dive(2);
time = 0:length(-p(fs*dstart:fs*dend))-1;

% plot
% figure(9); hold on
% patchline(time,-p(fs*dstart:fs*dend),'edgecolor','k','edgealpha',0.1)

% normalize time
ntime = time/time(end);

% choose color
if state == 1; % entangled
    c = [0 0 0];
else if state == 0; % disentangled
        c = [0 0 1];
    else if state == 2; % buoy
            c = [1 0 0];
        end
    end
end


% plot 
figure(figno); hold on
patchline(ntime,-p(fs*dstart:fs*dend),'edgecolor',c,'edgealpha',0.9)

end