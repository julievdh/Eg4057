% Power Timeline Detailed
% Detailed timeline of entanglement/disentanglement of EG 4057

warning off

% gear on animal = 115 m estimate
Dtot = EstDrag(155,0);

% removed 104 m, then 12 m on Feb 16 2014
Ddiff = (EstDrag(104,0))-EstDrag(155,0); % difference in drag with removal of gear
Dnew1 = Dtot+Ddiff;

Ddiff = (EstDrag(92,0))-EstDrag(104,0); % difference in drag with removal of gear
Dnew2 = Dnew1+Ddiff;

% load TOWDRAG
load('TOWDRAG')

% calculate total drag with telemetry
D_wtelem1 = Dnew1+mean(abs(TOWDRAG(21).mn_dragN));
D_wtelem2 = Dnew2+mean(abs(TOWDRAG(21).mn_dragN));

%% Buoyancy
% Estimate from Bob Bowman is net 156.8 N
buoy = 156.8;

%% create timeline -- based on cues from DTAG
Timeline = [0; ... % prior to orion arrival on scene
    8571;... % orion on scene, removed 104 m, added telemetry
    9922;... % orion on scene, removed additional 12 m, kept telemetry
    10610;... % telemetry released
    13270]; % tag off

%% interpolate points in timeline for plotting
Tplot(1,:) = [Timeline(1) Dtot 0]; % baseline
Tplot(2,:) = [Timeline(2) Dtot 0]; 
Tplot(3,:) = [Timeline(2) Dnew1 0]; % decrease @ orion on scene disentangling
Tplot(4,:) = [Timeline(2)+100 Dnew1 0]; 
Tplot(5,:) = [Timeline(2)+100 D_wtelem1 buoy]; % added telemetry buoy
Tplot(6,:) = [Timeline(3) D_wtelem1 buoy]; 
Tplot(7,:) = [Timeline(3) Dnew2 0]; % removed line
Tplot(8,:) = [Timeline(3)+100 Dnew2 0]; 
Tplot(9,:) = [Timeline(3)+100 D_wtelem2 buoy]; 
Tplot(10,:) = [Timeline(4) D_wtelem2 buoy]; 
Tplot(11,:) = [Timeline(5) D_wtelem2 buoy];

figure(2); clf; hold on
plot(Tplot(:,1)/3600,Tplot(:,2))
plot(Tplot(:,1)/3600,Tplot(:,3),':')

%% load in DTAG and plot
load_eg047a

t = (1:length(eg047a.p))/fs;
plot(t/3600,-eg047a.p,'k') % plot depth

xlabel('Time since tag on (s)'); ylabel('        Depth (m)            Estimated Drag and Buoyancy (N)')

%% add cues
% known time cues
tagstart = [2014 2 16 15 42 10];
tagon = [2014 2 16 15 49 00];
FWC_0733 = [2014 2 16 15 51 32]; % photo FWC 0733
FWC_0739 = [2014 2 16 15 52 32]; % photo FWC 0739
FWC_1251 = [2014 2 16 17 57 06]; % photo FWC 1251
orion = [2014 2 16 18 05 00]; % arrived on scene
buoyon = [2014 2 16 18 39 00];
tagoff = [2014 2 16 19 23 00]; %ish

tagon_cue = etime(tagon,tagstart);
FWC_0733_cue = etime(FWC_0733,tagstart);
FWC_0739_cue = etime(FWC_0739,tagstart);
FWC_1251_cue = etime(FWC_1251,tagstart);
orion_cue = etime(orion,tagstart);
buoyon_cue = etime(buoyon,tagstart);
tagoff_cue = etime(tagoff,tagstart);

plot([tagon_cue/3600 tagon_cue/3600],[-40 140],'k--')
plot([orion_cue/3600 orion_cue/3600],[-40 140],'r-')
plot([buoyon_cue/3600 buoyon_cue/3600],[-40 140],'r-')
plot([tagoff_cue/3600 tagoff_cue/3600],[-40 140],'k--')

adjustfigurefont

%% try with plotyy
figure(5); clf; hold on
set(gcf,'position',[120 240 915 420])
[hAx,hLine1,hLine2] = plotyy(t/3600,-eg047a.p,[Tplot(:,1)/3600 Tplot(:,1)/3600],[Tplot(:,2),Tplot(:,3)]);
set(hAx(1),'ylim',[-32 30],'ytick',[-30:5:0],...
    'yticklabels',{'30','25','20','15','10','5','0'})
set(hAx(2),'ylim',[-181 170],'ytick',[0:40:160])
xlabel('Time since tag on (hours)'); 
ylabel(hAx(1),'Depth (m)                       ') % left y-axis
ylabel(hAx(2),'                             Force (N)') % right y-axis
adjustfigurefont
