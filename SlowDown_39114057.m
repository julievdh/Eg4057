
% fit curves to low and high power data
[low3911(1), low3911(2)] = curve_fit(U,power_lowdrag);
[high3911(1), high3911(2)] = curve_fit(U,power_highdrag);

u_HR = 0.1:0.01:1.5; % high resolution speed vector

figure(90); clf; hold on
xlim([0 1.5]); ylim([0 4000])
% plot(U,power_highdrag)
% plot(U,power_lowdrag)
plot(u_HR,low3911(1).*u_HR.^low3911(2))
plot(u_HR,high3911(1).*u_HR.^high3911(2))

% make high res curves
low_HR = low3911(1).*u_HR.^low3911(2);
high_HR = high3911(1).*u_HR.^high3911(2);
ind_aHR = nearest(u_HR', asc_vspeed'); % find indices for ascent
ind_dHR = nearest(u_HR', desc_vspeed'); % find indices for descent

% plot at ascent speeds
plot(u_HR(ind_aHR),high_HR(ind_aHR),'ko')
plot(u_HR(ind_aHR),low_HR(ind_aHR),'ko')
plot(u_HR(ind_dHR),high_HR(ind_dHR),'ko')
plot(u_HR(ind_dHR),low_HR(ind_dHR),'ko')

kx_a = nearest(high_HR',low_HR(ind_aHR)'); % find nearest value of high drag power for low drag
kx_d = nearest(high_HR',low_HR(ind_dHR)'); % find nearest value of high drag power for low drag

for i = 1:length(kx_a)
    % ascents
    %plot(u_HR(ind_aHR(i)),low_HR(ind_aHR(i)),'c*')
    %plot(u_HR(kx_a(i)),high_HR(kx_a(i)),'b*')
    %plot([u_HR(ind_aHR(i)) u_HR(kx_a(i))],[low_HR(ind_aHR(i)) low_HR(ind_aHR(i))])
    % descent
    plot(u_HR(ind_dHR(i)),low_HR(ind_dHR(i)),'c*')
    plot(u_HR(kx_d(i)),high_HR(kx_d(i)),'b*')
    plot([u_HR(ind_dHR(i)) u_HR(kx_d(i))],[low_HR(ind_dHR(i)) low_HR(ind_dHR(i))]) 
end

obs_speed = [u_HR(ind_dHR)' u_HR(ind_aHR)'];
slow_speed = [u_HR(kx_d)' u_HR(kx_a)'];

high = 1:53; low = 54:154;
[mean(obs_speed(low,:)) std(obs_speed(low,:))] % mean descent and ascent /SD for observed (to check)
[mean(slow_speed(low,:)) std(slow_speed(low,:))] % mean descent and ascent /SD reduced speeds

% e_preduc(:,1) = abs(obs_speed(high,1)-slow_speed(high,1))./obs_speed(high,1); % expected percent reduction on descent
% e_preduc(:,2) = abs(obs_speed(high,2)-slow_speed(high,2))./obs_speed(high,2); % expected percent reduction on ascent
% 
% o_preduc(:,1) = (mean(desc_vspeed(low))-mean(desc_vspeed(high)))./mean(desc_vspeed(low));
% o_preduc(:,2) = (mean(asc_vspeed(low))-mean(asc_vspeed(high)))./mean(asc_vspeed(low));


%% 
keep eta_low eta_high

% 4057
%% 1. Drag estimates

% length, m
whaleAge = 3;
l = 1011.033+320.501*log10(whaleAge); % MOORE ET AL 2004 in cm;
l = l/100; % convert to m

% speed, ms-1
U = 0.3:0.1:2.5;

% kinematic viscosity of seawater, m2s-1
v = 10^-6;

% calculate reynolds number
Re = (l*U)./v;

% coefficient of friction [Eqn. 4]
Cf = 0.072*Re.^(-1/5);

% seawater density
rho = 1025;

% estimated whale mass
M = 7000;

% estimated wetted surface area
Sw = 0.08*M.^0.65;

% max diameter of body, m
d = (0.21*(l*100)+38.63)/100; % Fortune et al 2012

% Fineness Ratio
FR = l./d;

% drag augmentation factor for oscillation, = 3 as per Frank Fish, pers comm
k = 1.5;
% appendages
g = 1.3;
% submergence
% keep submergence effect in for this because we know that this is THIS
% animal, this deployment, its behaviour. 
load('gamma.mat')
p = polyfit(gamma(:,1),gamma(:,2),8);
f = polyval(p,gamma(:,1));

hn = 1.4990; % median submergence depth low drag (Eg 4057 tag)
xn = hn./d; % h/d values based on the mean submergence depth while not entangled
yn = 1;

he = 4.7786; % median submergence depth high drag (Eg 4057 tag)
xe = he./d; % calculated h/d values based on the mean SD submergence depth while entangled
ye = interp1(gamma(:,1),f,xe); % interpolates gamma to find value for calculated h/d

% calculate drag coefficient [Eqn 5] across all speeds
for i = 1:length(U)
    whaleCD0(:,i) = Cf(:,i).*(1+1.5*(d./l).^(3/2) + 7*(d./l).^3);
    % calculate drag force on the whale body (N)
    whaleDf(:,i) = (1/2)*rho*(U(i).^2)*Sw.*whaleCD0(:,i)*g*k;
    whaleDf_E(:,i) = (1/2)*rho*(U(i).^2)*Sw.*whaleCD0(:,i)*g*k;
end
%  add submergence effect
whaleDf = whaleDf*yn;
whaleDf_lower = whaleDf*0.9; whaleDf_upper = whaleDf*1.1; % error for oscillation: use 1.35 to 1.65
whaleDf_E = whaleDf*ye;
%% 
Dtot_lowdrag = whaleDf_E + 81.5200 + 7.5; % low drag
Dtot_highdrag = whaleDf_E + 105.3021 + 7.5; % with telemetry buoy (high drag)
Dtot_low_lower = whaleDf_E*0.9 + 75.8136 + 7.5*0.9; % uncertainty due to gear drag estimates and oscillation parameter (use EstDrag)
Dtot_low_upper = whaleDf_E*1.1 + 87.2264 + 7.5*1.1;
Dtot_high_lower = whaleDf_E*0.9 + 105.3021*0.93 + 7.5*0.9;
Dtot_high_upper = whaleDf_E*1.1 + 105.3021*1.07 + 7.5*1.1;
% Dtot, Dtot_lower and Dtot_upper is the total entangled drag on each
% animal across range of speeds

% plot
figure(1); clf; hold on
h1 = plot(U,Dtot_highdrag,'b'); plot(U,Dtot_high_lower,'b:',U,Dtot_high_upper,'b:');
h2 = plot(U,Dtot_lowdrag,'k'); plot(U,Dtot_low_lower,'k:',U,Dtot_low_upper,'k:');
h3 = plot(U,whaleDf); 
h4 = plot(U,whaleDf_lower,':',U,whaleDf_upper,':');
set([h3; h4],'color',[0.75 0.75 0.75])
xlabel('Speed (m/s)'); ylabel('Drag (N)')
legend([h1 h2 h3],'Entangled','Disentangled','Not Entangled','Location','NW')
adjustfigurefont
print('Eg4057_Drag.eps','-depsc','-r300')

%% drag stats
% two sample t to compare nonentangled and entangled drag, and entangled
% drag vs disentangled drag
[min(whaleDf) max(whaleDf)];
[min(Dtot_highdrag) max(Dtot_highdrag)];
[min(Dtot_lowdrag) max(Dtot_lowdrag)];

% [h,p,ci,stats] = ttest(whaleDf,Dtot_highdrag);
% [h,p,ci,stats] = ttest(Dtot_lowdrag,Dtot_highdrag);

% pinc = mean((Dtot_highdrag-whaleDf)./whaleDf);
% pdec = mean((Dtot_lowdrag-Dtot_highdrag)./Dtot_highdrag);

%% calculate Power
power_lowdrag = (Dtot_lowdrag.*U)./nanmean(eta_low(:));
power_lowdrag_low = (Dtot_low_lower.*U)./nanmean(eta_low(:));
power_lowdrag_up = (Dtot_low_upper.*U)./nanmean(eta_low(:));

power_highdrag = (Dtot_highdrag.*U)./nanmean(eta_high(:));
power_highdrag_low = (Dtot_high_lower.*U)./nanmean(eta_high(:));
power_highdrag_up = (Dtot_high_upper.*U)./nanmean(eta_high(:));

% fit curves to low and high power data
[low4057(1), low4057(2)] = curve_fit(U,power_lowdrag);
[high4057(1), high4057(2)] = curve_fit(U,power_highdrag);

u_HR = 0.1:0.01:1.5; % high resolution speed vector

figure(90); clf; hold on
xlim([0 1.5]); ylim([0 4000])
% plot(U,power_highdrag)
% plot(U,power_lowdrag)
plot(u_HR,low4057(1).*u_HR.^low4057(2))
plot(u_HR,high4057(1).*u_HR.^high4057(2))

%% make high res curves
low_HR = low4057(1).*u_HR.^low4057(2);
high_HR = high4057(1).*u_HR.^high4057(2);

%% get vertical speeds
% calculate mean vertical speed
eg047a = load('eg14_047aprh.mat'); fs = 5;
eg047a.T = finddives(eg047a.p,fs,5,1);              % find dives
load('eg047a_descasc')                              % load ascents and descents
low = [1:12];                                 % dive 7 tag moves
high = [13:20];                               % dives 16, 17 tag moves

for i = 1:length(eg047a.T)
    v = vertical(eg047a.p,fs);
    
    desc_vspeed_4057(i) = mean(v(eg047a.T(i,1)*fs:eg047a.T(i,1)*fs+end_desc(i)));            % checked indices
    desc_maxspeed_4057(i) = max(v(eg047a.T(i,1)*fs:eg047a.T(i,1)*fs+end_desc(i)));
    asc_vspeed_4057(i) = mean(abs(v(eg047a.T(i,1)*fs+start_asc(i):eg047a.T(i,2)*fs)));       % checked indices
    asc_maxspeed_4057(i) = max(abs(v(eg047a.T(i,1)*fs+start_asc(i):eg047a.T(i,2)*fs)));
end

% find nearest speed
ind_a = nearest(U', asc_vspeed_4057');
ind_d = nearest(U', desc_vspeed_4057');

%%

ind_aHR = nearest(u_HR', asc_vspeed_4057'); % find indices for ascent
ind_dHR = nearest(u_HR', desc_vspeed_4057'); % find indices for descent

% plot at ascent speeds
plot(u_HR(ind_aHR),high_HR(ind_aHR),'ko')
plot(u_HR(ind_aHR),low_HR(ind_aHR),'ko')
plot(u_HR(ind_dHR),high_HR(ind_dHR),'ko')
plot(u_HR(ind_dHR),low_HR(ind_dHR),'ko')

kx_a = nearest(high_HR',low_HR(ind_aHR)'); % find nearest value of high drag power for low drag
kx_d = nearest(high_HR',low_HR(ind_dHR)'); % find nearest value of high drag power for low drag

    % ascents
    plot(u_HR(ind_aHR(low)),low_HR(ind_aHR(low)),'c*')
    plot(u_HR(kx_a(low)),high_HR(kx_a(low)),'b*')
    plot([u_HR(ind_aHR(low)) u_HR(kx_a(low))],[low_HR(ind_aHR(low)) low_HR(ind_aHR(low))])
    % descent
    plot(u_HR(ind_dHR(i)),low_HR(ind_dHR(i)),'c*')
    plot(u_HR(kx_d(i)),high_HR(kx_d(i)),'b*')
    plot([u_HR(ind_dHR(i)) u_HR(kx_d(i))],[low_HR(ind_dHR(i)) low_HR(ind_dHR(i))]) 

obs_speed = [u_HR(ind_dHR)' u_HR(ind_aHR)'];
slow_speed = [u_HR(kx_d)' u_HR(kx_a)'];
%%
[mean(obs_speed(low,:)) std(obs_speed(low,:))] % mean descent and ascent /SD for observed (to check)
[mean(slow_speed(low,:)) std(slow_speed(low,:))] % mean descent and ascent /SD reduced speeds

% e_preduc(:,1) = abs(obs_speed(low,1)-slow_speed(low,1))./obs_speed(low,1); % expected percent reduction on descent
% e_preduc(:,2) = abs(obs_speed(low,2)-slow_speed(low,2))./obs_speed(low,2); % expected percent reduction on ascent
% 
% o_preduc(:,1) = (mean(desc_vspeed_4057(low))-mean(desc_vspeed_4057(high)))./mean(desc_vspeed_4057(low));
% o_preduc(:,2) = (mean(asc_vspeed_4057(low))-mean(asc_vspeed_4057(high)))./mean(asc_vspeed_4057(low));