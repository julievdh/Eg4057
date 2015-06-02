% Power Timeline Detailed
% Detailed timeline of entanglement/disentanglement of EG 3911
 
% drag on removed gear = 159.2 N as measured from tensiometer (van der Hoop et al.
% 2013 Marine Mammal Science)
Ddiff = 159.2;
 
% approx. 21 m of line and a 35 cm gangion was left on animal, collected
% from carcass at necropsy on 3 Feb 2011
Dleft = EstDrag(22,0); % drag left on animal 
Dtot = Ddiff+Dleft;

%% Buoyancy
% 1 lb force = 4.448 N
% 45.4 cm diam NB60 = 127 lbs buoyancy, weighs 6.6 lbs
buoy1 = (127-6.6)*4.448;
% 42.5 cm diam A3 polyform buoy = 121 lbs buoyancy, weighs 6.8 lbs
buoy2 = (121-6.8)*4.448;

buoys = buoy1+buoy2;

%% create timeline -- based on cues from DTAG
Timeline = rw015a.p1; % entangled period

%% interpolate points in timeline for plotting
Tplot(1,:) = [Timeline(1) Dtot buoys]; % baseline
Tplot(2,:) = [Timeline(2) Dtot buoys]; 
Tplot(3,:) = [Timeline(2) Dleft 0]; % decrease at disentanglement
Tplot(4,:) = [22268 Dleft 0]; % until end of tag

figure(2); clf; hold on
plot(Tplot(:,1),Tplot(:,2))
plot(Tplot(:,1),Tplot(:,3),':')

%% load in DTAG and plot
load_rw015a

t = (1:length(rw015a.p))/fs;
plot(t,-rw015a.p,'k') % plot depth

xlabel('Time since tag on (s)'); ylabel('        Depth (m)            Estimated Drag and Buoyancy (N)')

%% add cues
% known time cues
plot([rw015a.p1(2) rw015a.p1(2)],[-40 1100],'k--')
plot([rw015a.p2(2) rw015a.p2(2)],[-40 1100],'k--')
plot([rw015a.p1(2) rw015a.p1(2)],[-40 140],'r-')
plot([rw015a.p1(2) rw015a.p1(2)],[-40 140],'k--')

ylim([-40 1100])


