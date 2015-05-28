% load tag rw11_015a

% set tag path
path = 'F:\rw11\rw11_015a\';
settagpath('cal',[path 'cal\'],'prh',[path 'prh\'],'raw',[path 'raw\'],'audit',[path 'audit\'])
settagpath('audio','F:\')
tag = 'rw11_015a';

% load prh
loadprh(tag)

% put in structure
rw015a.A = A;
rw015a.Aw = Aw;
rw015a.head = head;
rw015a.M = M;
rw015a.Mw = Mw;
rw015a.p = p;
rw015a.pitch = pitch;
rw015a.roll = roll;
rw015a.tempr = tempr;

% establish time periods
rw015a.p1 = [1 6667]; % entangled
rw015a.p2 = [6668 15248]; % disentanglement
rw015a.p3 = [15248 22268]; % recovery


% create time vector
rw015a.t = (1:length(rw015a.p))/fs;

clear A Aw head M Mw p pitch roll tempr 

% reset directory
cd C:\Users\Julie\Documents\MATLAB\Eg4057