% load tag eg14_047a

% set tag path
path = 'F:\eg14\eg14_047a\';
settagpath('cal',[path 'cal\'],'prh',[path 'prh\'],'raw',[path 'raw\'],'audit',[path 'audit\'])
settagpath('audio','F:\')
tag = 'eg14_047a';

% load prh
loadprh(tag)
%%
% put in structure
eg047a.A = A;
eg047a.Aw = Aw;
eg047a.head = head;
eg047a.M = M;
eg047a.Mw = Mw;
eg047a.p = p;
% adjust depth -- 0.5 m off. 
eg047a.p = eg047a.p+0.5;
eg047a.pitch = pitch;
eg047a.roll = roll;
eg047a.tempr = tempr;

% create time vector
eg047a.t = (1:length(eg047a.p))/fs;

% add times of interest
eg047a.p1 = [410 4711]; % consistent tag position, entangled
eg047a.p2 = [5133 10740]; % consistent tag position, entangled
% BUT MAYBE ESTABLISHED CONTROL LINE IN THIS TIME PERIOD
% TALK TO DOUG/HEATHER/ZACH/DISENTANGLERS
eg047a.p3 = [11350 13250]; % consistent tag position, entangled + telemetry

clear A Aw head M Mw p pitch roll tempr 

% reset directory
cd C:\Users\Julie\Documents\MATLAB\Eg4057