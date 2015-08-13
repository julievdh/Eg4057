% Descent and Ascent Speeds
% calculate descent and ascent speeds for both tags, using dives > 5m
% 8 July 2015 Julie van der Hoop

% load tag
load_rw015a

%% find flukes and dives
[rw015a.v,rw015a.ph,rw015a.mx,rw015a.fr] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 4]);
rw015a.T = finddives(rw015a.p,fs,5,1,0);

% load descents and ascents
load('rw015a_descasc')

% set drag condition
rw015a.cond = rw015a.T(:,1) < rw015a.p1(2); % high drag is before

%% calculate descent speed = distance / time

% distance is depth at end of descent minus depth at beginning of descent
% (in M)
dist = rw015a.p(rw015a.T(:,1)*fs+end_desc')-rw015a.p(rw015a.T(:,1)*fs);
% duration is time at end of descent minus time at beginning of descent
% (in SEC)
time = (rw015a.T(:,1)*fs-rw015a.T(:,1)*fs+end_desc')./fs; 
desc_speed_015a = dist./time; 

%% calculate ascent speed = distance / time

% distance is depth at end of ascent minus depth at beginning of ascent
% (in M)
dist = rw015a.p(rw015a.T(:,2)*fs)-rw015a.p(rw015a.T(:,1)*fs+start_asc');
% duration is time at end of descent minus time at beginning of descent
% (in SEC)
time = (rw015a.T(:,2)*fs-(rw015a.T(:,1)*fs+start_asc'))./fs; 
asc_speed_015a = abs(dist./time); 

%% use Mark's function
v = vertical(rw015a.p,fs);
for i = 1:length(rw015a.T)
    desc_vspeed_015a(i) = mean(v(rw015a.T(i,1)*fs:rw015a.T(i,1)*fs+end_desc(1)));
    asc_vspeed_015a(i) = mean(v(rw015a.T(i,1)*fs+start_asc(i):rw015a.T(i,2)*fs));
end

%% plot
figure(100); clf; hold on
gscatter(desc_vspeed_015a,-asc_vspeed_015a,rw015a.cond,'kb')
xlabel('Descent Speed (m/s)'); ylabel('Ascent Speed (m/s)')

%% for Eg 4057

% load tag
load_eg047a

% find flukes and dives
[eg047a.v,eg047a.ph,eg047a.mx,eg047a.fr] = findflukes(eg047a.Aw,eg047a.Mw,fs,0.3,0.01,[0.7 4]);
eg047a.T = finddives(eg047a.p,fs,5,1,0);

% load descents and ascents
load('eg047a_descasc')

% set drag condition
eg047a.cond = eg047a.T(:,1) > 8571; % high drag is later

%% calculate descent speed
% distance / time

% distance is depth at end of descent minus depth at beginning of descent
% (in M)
dist = eg047a.p(eg047a.T(:,1)*fs+end_desc')-eg047a.p(eg047a.T(:,1)*fs);
% duration is time at end of descent minus time at beginning of descent
% (in SEC)
time = (eg047a.T(:,1)*fs-eg047a.T(:,1)*fs+end_desc')./fs; 
desc_speed_047a = dist./time; 


%% calculate ascent speed
% distance / time

% distance is depth at end of ascent minus depth at beginning of ascent
% (in M)
dist = eg047a.p(eg047a.T(:,2)*fs)-eg047a.p(eg047a.T(:,1)*fs+start_asc');
% duration is time at end of descent minus time at beginning of descent
% (in SEC)
time = (eg047a.T(:,2)*fs-(eg047a.T(:,1)*fs+start_asc'))./fs; 
asc_speed_047a = abs(dist./time); 

%% use mark's Vertical Speed calculation
v = vertical(eg047a.p,fs);
for i = 1:length(eg047a.T)
desc_vspeed_047a(i) = mean(v(eg047a.T(i,1)*fs:eg047a.T(i,1)*fs+end_desc(1)));
    asc_vspeed_047a(i) = mean(v(eg047a.T(i,1)*fs+start_asc(i):eg047a.T(i,2)*fs));
end
%% plot
gscatter(desc_vspeed_047a,-asc_vspeed_047a,eg047a.cond,'gr')
xlabel('Descent Speed (m/s)'); ylabel('Ascent Speed (m/s)')
plot([0 1],[0 1],'k')
legend('Eg 3911 Low Drag','Eg 3911 High Drag','Eg 4057 Low Drag',...
    'Eg 4057 High Drag','Location','NW')

%% plot in a different way:
figure(2); clf
subplot(121);hold on
errorbar(0,mean(desc_vspeed_015a(rw015a.cond == 0)),std(desc_vspeed_015a(rw015a.cond == 0)),'o')
errorbar(1,mean(desc_vspeed_015a(rw015a.cond == 1)),std(desc_vspeed_015a(rw015a.cond == 1)),'o')

errorbar(0,mean(desc_vspeed_047a(eg047a.cond == 0)),std(desc_vspeed_047a(eg047a.cond == 0)),'ro')
errorbar(1,mean(desc_vspeed_047a(eg047a.cond == 1)),std(desc_vspeed_047a(eg047a.cond == 1)),'ro')

ylabel('Descent Speed (m/s)')
set(gca,'xtick',[0 1],'xticklabel',{'Low','High'})
xlim([-0.1 1.1])

subplot(122);hold on
errorbar(0,mean(-asc_vspeed_015a(rw015a.cond == 0)),std(-asc_vspeed_015a(rw015a.cond == 0)),'o')
errorbar(1,mean(-asc_vspeed_015a(rw015a.cond == 1)),std(-asc_vspeed_015a(rw015a.cond == 1)),'o')

errorbar(0,mean(-asc_vspeed_047a(eg047a.cond == 0)),std(-asc_vspeed_047a(eg047a.cond == 0)),'ro')
errorbar(1,mean(-asc_vspeed_047a(eg047a.cond == 1)),std(-asc_vspeed_047a(eg047a.cond == 1)),'ro')

ylabel('Ascent Speed (m/s)')
set(gca,'xtick',[0 1],'xticklabel',{'Low','High'})
xlim([-0.1 1.1])
