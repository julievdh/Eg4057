% Power Timeline Detailed
% Detailed timeline of entanglement/disentanglement of EG 4057
 
% gear on animal = 115 m estimate
Dtot = EstDrag(155,0);

% removed 104 m, then 12 m on Feb 16 2014
Ddiff = (EstDrag(104,0))-EstDrag(155,0); % difference in drag with removal of gear
Dnew1 = Dtot+Ddiff;

Ddiff = (EstDrag(104,0))-EstDrag(155,0); % difference in drag with removal of gear
Dnew2 = Dnew1+Ddiff;

% load TOWDRAG
load('TOWDRAG')

% calculate total drag with telemetry
D_wtelem1 = Dnew1+mean(abs(TOWDRAG(21).mn_dragN));
D_wtelem2 = Dnew2+mean(abs(TOWDRAG(21).mn_dragN));

%% plot to check
figure(1); clf; hold on
plot(Dtot,'o')
plot(Dnew1,'o')
plot(Dnew2,'o')
plot(D_wtelem1,'o')
plot(D_wtelem2,'o')
ylabel('Drag (N)')
legend('Entangled','Partially Disentangled','Partially Disentangled',...
    'Partially Disentangled with Telemetry')
xlim([0.5 2.5])

%% create timeline -- based on cues from DTAG
Timeline = [0; ... % prior to orion arrival on scene
    8571;... % orion on scene, removed 104 m, added telemetry
    9922;... % orion on scene, removed additional 12 m, kept telemetry
    10610;... % telemetry released
    13270]; % tag off

figure(2); clf; hold on
plot([Timeline(1) Timeline(2)],[Dtot Dtot])
plot([Timeline(2) Timeline(3)],[Dnew1 Dnew1])
plot([Timeline(2) Timeline(3)],[D_wtelem1 D_wtelem1])
plot([Timeline(3) Timeline(4)],[Dnew2 Dnew2])
plot([Timeline(4) Timeline(5)],[D_wtelem2 D_wtelem2])

%% interpolate points in timeline for plotting
Tplot(1,:) = [Timeline(1) Dtot]; % baseline
Tplot(2,:) = [Timeline(2) Dtot]; 
Tplot(3,:) = [Timeline(2) Dnew1]; % decrease @ orion on scene disentangling
Tplot(4,:) = [Timeline(2)+100 Dnew1]; 
Tplot(5,:) = [Timeline(2)+100 D_wtelem1]; % added telemetry buoy
Tplot(6,:) = [Timeline(3) D_wtelem1]; 
Tplot(7,:) = [Timeline(3) Dnew2]; % removed line
Tplot(8,:) = [Timeline(3)+100 Dnew2]; 
Tplot(9,:) = [Timeline(3)+100 D_wtelem2]; 
Tplot(10,:) = [Timeline(4) D_wtelem2]; 
Tplot(11,:) = [Timeline(5) D_wtelem2];

plot(Tplot(:,1),Tplot(:,2))
%%
% 
% Timeline(2,1) Timeline(3,2); % increase @ LSGF
%     Timeline(3,:); Timeline(4,1) Timeline(3,2); % entangled and increase
%     Timeline(4,:); Timeline(5,1) Timeline(5,2); % with telemetry
%     Timeline(5,:); Timeline(6,1) Timeline(5,2); % removal of telemetry and some gear
%     Timeline(6,:)];


% plot
figure(3); clf; hold on
set(gcf,'position',[1395 128 1257 384])
plot(maxTimeline(:,1),maxTimeline(:,2),'k:')
% plot(maxTimeline(:,1),maxTimeline(:,2),'k.')
plot(minTimeline(:,1),minTimeline(:,2),'k')
plot([0 0],[7000 9000],'--','color',[0.5 0.5 0.5])

xlabel('Days Relative to Disentanglement'); ylabel('Power (W)')
title('J120808; EG 3294','FontSize',14,'FontWeight','bold')
adjustfigurefont
