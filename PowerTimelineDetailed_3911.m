% Power Timeline Detailed
% Detailed timeline of entanglement/disentanglement of EG 3911
 
% drag on removed gear = 159.2 N as measured from tensiometer (van der Hoop et al.
% 2013 Marine Mammal Science)
Ddiff = 73.9;
 
% approx. 21 m of line and a 35 cm gangion was left on animal, collected
% from carcass at necropsy on 3 Feb 2011
[Dleft,Dleft_range] = EstDrag(22,0); % drag left on animal 
Dtot = Ddiff+Dleft;
Dtot_range = Ddiff+Dleft_range;

%% Buoyancy
% 1 lb force = 4.448 N
% 45.4 cm diam NB60 = 127 lbs buoyancy, weighs 6.6 lbs
buoy1 = (127-6.6)*4.448;
% 42.5 cm diam A3 polyform buoy = 121 lbs buoyancy, weighs 6.8 lbs
buoy2 = (121-6.8)*4.448;

buoys = buoy1+buoy2;

%% create timeline -- based on cues from DTAG
% load_rw015a
Timeline = rw015a.p1; % entangled period

%% interpolate points in timeline for plotting
Tplot(1,:) = [Timeline(1) Dtot Dtot_range(1) Dtot_range(2) buoys]; % baseline
Tplot(2,:) = [Timeline(2) Dtot Dtot_range(1) Dtot_range(2) buoys]; 
Tplot(3,:) = [Timeline(2) Dleft Dleft_range(1) Dleft_range(2) 0]; % decrease at disentanglement
Tplot(4,:) = [22268 Dleft Dleft_range(1) Dleft_range(2) 0]; % until end of tag

return

figure(2); clf; hold on
plot(Tplot(:,1),Tplot(:,2),Tplot(:,1),Tplot(:,3),'b:',Tplot(:,1),Tplot(:,4),'b:')

%% plot
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

%% plot on separate axes (depth, forces)
warning off
figure(5); clf; hold on; set(gcf,'position',[120 240 915 420])
[hAx,hLine1,hLine2] = plotyy(t/3600,-rw015a.p,[Tplot(:,1)/3600 Tplot(:,1)/3600],[Tplot(:,2),Tplot(:,3)]);
set(hAx(1),'ylim',[-25 30],'ytick',[-20:5:0],...
    'yticklabels',{'20','15','10','5','0'}); 
set(hAx(2),'ylim',[-1000 1200])
xlabel('Time since tag on (hours)'); 
ylabel(hAx(1),'Depth (m)                       ') % left y-axis
ylabel(hAx(2),'                             Force (N)') % right y-axis
adjustfigurefont

cd C:\Users\Julie\Documents\MATLAB\Eg4057\AnalysisFigs
print('eg3911_timeline','-dtiff','-r300')