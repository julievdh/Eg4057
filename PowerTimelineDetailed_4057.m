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

%% create timeline -- based on cues from DTAG
Timeline = [0; ... % prior to orion arrival on scene
    8571;... % orion on scene, removed 104 m, added telemetry
    9922;... % orion on scene, removed additional 12 m, kept telemetry
    10610;... % telemetry released
    13270]; % tag off

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

figure(2); clf; hold on
plot(Tplot(:,1),Tplot(:,2))
