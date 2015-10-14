% Estimate Propulsive Efficiency
% 12 Aug 2015

clear all; close all

%% 1. Drag estimates

% length, m
l = 10;

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
d = 2.196;

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

hn = 10.38; % median submergence depth not entangled (Eg 3911 tag)
xn = hn./d; % h/d values based on the mean submergence depth while not entangled
yn = 1;

he = 3.68; % median submergence depth while entangled Eg 3911 
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

Dtot_highdrag = whaleDf_E + 92.91 + 7.5; % high drag
Dtot_lowdrag = whaleDf + 19.01 + 7.5; % after disentanglement
Dtot_high_lower = whaleDf_E*0.9 + 91.59 + 7.5*0.9; % uncertainty due to gear drag estimates and oscillation parameter 
Dtot_high_upper = whaleDf_E*1.1 + 94.24 + 7.5*1.1;
Dtot_low_lower = whaleDf*0.9 + 17.68 + 7.5*0.9;
Dtot_low_upper = whaleDf*1.1 + 20.34 + 7.5*1.1;
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
legend([h1 h2 h3],'Not Entangled','Entangled','Disentangled','Location','NW')
adjustfigurefont
print('Eg3911_Drag.eps','-depsc','-r300')

% drag stats
% two sample t to compare nonentangled and entangled drag, and entangled
% drag vs disentangled drag
[min(whaleDf) max(whaleDf)]
[min(Dtot_highdrag) max(Dtot_highdrag)]
[min(Dtot_lowdrag) max(Dtot_lowdrag)]

[h,p,ci,stats] = ttest(whaleDf,Dtot_highdrag);
[h,p,ci,stats] = ttest(Dtot_lowdrag,Dtot_highdrag);

pinc = mean((Dtot_highdrag-whaleDf)./whaleDf);
pdec = mean((Dtot_lowdrag-Dtot_highdrag)./Dtot_highdrag);

%% 2. Coefficient of Thrust based on Drag estimates
ThrustCoefficient_3911

%% Get CT for each speed of descent and ascent (so points rather than curves for each CT)

% find nearest speed
ind_a = nearest(U', asc_maxspeed');
ind_d = nearest(U', desc_maxspeed');

% calculate CT at those speeds
for i = 1:53 % high drag
    CT_E_a_atspeed(i) = CT_E_a(i,ind_a(i));
    CT_E_d_atspeed(i) = CT_E_d(i,ind_d(i));
end

for i = 54:154 % low drag
    CT_DE_a_atspeed(i) = CT_DE_a(i,ind_a(i));
    CT_DE_d_atspeed(i) = CT_DE_d(i,ind_d(i));
end

%% 2. Calculate ideal efficiency and lower and upper bounds

% when entangled
ni_E_a = 2./(1+sqrt(1+CT_E_a));
ni_E_a_lower = 2./(1+sqrt(1+CT_E_a_lower));
ni_E_a_upper = 2./(1+sqrt(1+CT_E_a_upper));

ni_E_d = 2./(1+sqrt(1+CT_E_d));
ni_E_d_lower = 2./(1+sqrt(1+CT_E_d_lower));
ni_E_d_upper = 2./(1+sqrt(1+CT_E_d_upper));

% when disentangled
ni_DE_a = 2./(1+sqrt(1+CT_DE_a));
ni_DE_a_lower = 2./(1+sqrt(1+CT_DE_a_lower));
ni_DE_a_upper = 2./(1+sqrt(1+CT_DE_a_upper));

ni_DE_d = 2./(1+sqrt(1+CT_DE_d));
ni_DE_d_lower = 2./(1+sqrt(1+CT_DE_d_lower));
ni_DE_d_upper = 2./(1+sqrt(1+CT_DE_d_upper));

% when not entangled
ni_NE_a = 2./(1+sqrt(1+CT_NE_a));
ni_NE_a_lower = 2./(1+sqrt(1+CT_NE_a_lower));
ni_NE_a_upper = 2./(1+sqrt(1+CT_NE_a_upper));
ni_NE_d = 2./(1+sqrt(1+CT_NE_d));
ni_NE_d_lower = 2./(1+sqrt(1+CT_NE_d_lower));
ni_NE_d_upper = 2./(1+sqrt(1+CT_NE_d_upper));

figure(4); clf
subplot(211); hold on
plot(U,ni_E_d,'b-',U,ni_E_d_lower,'b:',U,ni_E_d_upper,'b:')
plot(U,ni_DE_d(low,:),'k-',U,ni_DE_d_lower(low,:),'k:',U,ni_DE_d_upper(low,:),'k:')
h = plot(U,ni_NE_d,U,ni_NE_d_lower,':',U,ni_NE_d_upper,':');
set(h,'color',[0.5 0.5 0.5])
title('Descent'); ylabel('Ideal Efficiency, n_i')

subplot(212); hold on
plot(U,ni_E_a,'b-',U,ni_E_a_lower,'b:',U,ni_E_a_upper,'b:')
plot(U,ni_DE_a(low,:),'k-',U,ni_DE_a_lower(low,:),'k:',U,ni_DE_a_upper(low,:),'k:')
h = plot(U,ni_NE_a,U,ni_NE_a_lower,':',U,ni_NE_a_upper,':');
set(h,'color',[0.5 0.5 0.5])
title('Ascent')
xlabel('Speed (m/s)'); ylabel('Ideal Efficiency, n_i')
adjustfigurefont
print('Eg3911_IdealEfficiency.eps','-depsc','-r300')

%% Get ideal efficiency for actual speeds of descent and ascent

% calculate CT at those speeds
for i = 1:53 % high drag
    ni_E_a_atspeed(i) = ni_E_a(i,ind_a(i));
    ni_E_d_atspeed(i) = ni_E_d(i,ind_d(i));
end

for i = 54:154 % low drag
    ni_DE_a_atspeed(i) = ni_DE_a(i,ind_a(i));
    ni_DE_d_atspeed(i) = ni_DE_d(i,ind_d(i));
end

% plot
PlotCTni

%% Calculate differences between

[mean(CT_E_d_atspeed) std(CT_E_d_atspeed)]
[mean(CT_E_a_atspeed) std(CT_E_a_atspeed)]
[h,p,ci,stats] = ttest(CT_E_d_atspeed,CT_E_a_atspeed)
    
[mean(CT_DE_d_atspeed(low)) std(CT_DE_d_atspeed(low))]
[mean(CT_DE_a_atspeed(low)) std(CT_DE_a_atspeed(low))]
foldinc_d = mean(CT_E_d_atspeed)/mean(CT_DE_d_atspeed(low))
foldinc_a = mean(CT_E_a_atspeed)/mean(CT_DE_a_atspeed(low))

condition = [ones(1,53) zeros(1,101) ones(1,53) zeros(1,101)];
portion = [repmat(-1,1,154) repmat(1,1,154)];
allCT = vertcat(CT_E_d_atspeed',CT_DE_d_atspeed(low)',CT_E_a_atspeed',CT_DE_a_atspeed(low)');
% boxplot(allCT,{condition portion})
% two-way ANOVA
% [p,t,stats] = anovan(allCT,{condition portion},'varnames',{'Condition';'Dive Portion'});

% average non-entangled CT across the same range of speeds
disp('mean SD average non-entangled CT descent')
[mean(CT_NE_a(3:13)) std(CT_NE_d(3:13))] % descent
disp('mean SD average non-entangled CT descent')
[mean(CT_NE_a(1:8)) std(CT_NE_a(1:8))] % ascent
foldinc_ne = [mean(CT_DE_d_atspeed(low))/mean(CT_NE_d(3:13))  mean(CT_DE_a_atspeed(low))/mean(CT_NE_a(1:8))]

%%
[mean(ni_E_d_atspeed) std(ni_E_d_atspeed)]
[mean(ni_E_a_atspeed) std(ni_E_a_atspeed)]
[mean(ni_DE_d_atspeed(low)) std(ni_DE_d_atspeed(low))]
[mean(ni_DE_a_atspeed(low)) std(ni_DE_a_atspeed(low))]

allni = vertcat(ni_E_d_atspeed',ni_DE_d_atspeed(low)',ni_E_a_atspeed',ni_DE_a_atspeed(low)');
% boxplot(allni,{condition portion})
% two-way ANOVA
% [p,t,stats] = anovan(allni,{condition portion},'varnames',{'Condition';'Dive Portion'});

[mean(ni_NE_d(3:14)) std(ni_NE_d(3:14))] % average non-entangled ni across same range of speeds
[mean(ni_NE_a(1:8)) std(ni_NE_a(1:8))]

%% 3. Calculate angle of attack based on St and CT

% Calculate CT/St^2 for every dive descent and ascent
CTSt2_E_a = CT_E_a_atspeed./(st_amax(high).^2);
CTSt2_E_d = CT_E_d_atspeed./(st_dmax(high).^2);
CTSt2_DE_a = CT_DE_a_atspeed(low)./(st_amax(low).^2);
CTSt2_DE_d = CT_DE_d_atspeed(low)./(st_dmax(low).^2);

% plot
figure(6); clf
set(gcf,'position',[427 5 532 668])
subplot(211); hold on; box on
scatter(st_amax(high),CTSt2_E_a,'b^')
scatter(st_dmax(high),CTSt2_E_d,'bv','filled')
scatter(st_amax(low),CTSt2_DE_a,'k^')
scatter(st_dmax(low),CTSt2_DE_d,'kv','filled')
% plot Hover contours
load('Hover2004_Fig5')
h = plot(a10_harmonic(:,1),a10_harmonic(:,2),a15_harmonic(:,1),a15_harmonic(:,2),...
    a20_harmonic(:,1),a20_harmonic(:,2),a25_harmonic(:,1),a25_harmonic(:,2),...
    a30_harmonic(:,1),a30_harmonic(:,2),a35_harmonic(:,1),a35_harmonic(:,2));
set(h,'color',[0.75 0.75 0.75])
text(0.85,6.3738,'\alpha = 35^0')
text(0.85,5.4473,'\alpha = 30^0')
text(0.85,3.8179,'\alpha = 25^0')
text(0.85,1.8371,'\alpha = 20^0')
text(0.03,4.3610,'\alpha = 15^0')
text(0.03,2.6038,'\alpha = 10^0')

xlabel('Strouhal Number, St'); ylabel('C_T/St^2')
xlim([0 1.25]); ylim([0 10])

% with sawtooth curves
subplot(212); hold on; box on
scatter(st_amax(high),CTSt2_E_a,'b^')
scatter(st_dmax(high),CTSt2_E_d,'bv','filled')
scatter(st_amax(low),CTSt2_DE_a,'k^')
scatter(st_dmax(low),CTSt2_DE_d,'kv','filled')
% plot Hover contours
load('Hover2004_Fig5')
h = plot(a10_sawtooth(:,1),a10_sawtooth(:,2),a15_sawtooth(:,1),a15_sawtooth(:,2),...
    a20_sawtooth(:,1),a20_sawtooth(:,2),a25_sawtooth(:,1),a25_sawtooth(:,2),...
    a30_sawtooth(:,1),a30_sawtooth(:,2),a35_sawtooth(:,1),a35_sawtooth(:,2));
set(h,'color',[0.75 0.75 0.75])
text(0.85,9.4728,'\alpha = 35^0')
text(0.85,8.1629,'\alpha = 30^0')
text(0.85,6.5016,'\alpha = 25^0')
text(0.85,4.7444,'\alpha = 20^0')
text(0.85,2.6677,'\alpha = 15^0')
text(0.85,0.7827,'\alpha = 10^0')

xlabel('Strouhal Number, St'); ylabel('C_T/St^2')
xlim([0 1.25]); ylim([0 10])
adjustfigurefont
text(0.0379,24.8465,'Harmonic','Fontsize',14,'FontWeight','Bold')
text(0.0379,10.8465,'Sawtooth','Fontsize',14,'FontWeight','Bold')

print('Eg3911_a_estimation.eps','-depsc','-r300')

%% estimate alpha
estimateAlpha

%%
% load and plot data from Hover et al 2004 efficiency
plotHoverFig6

%% Find nearest St for which eta is estimated from alpha curves
% for high drag
% descent
for i = 1:length(high)
    if alpha_high(i,1) == 109
        % what is nearest index?
        ind = nearest(a10_harmonic_i(:,1),st_dmax(high(i)));
        % store
        eta_high(i,1) = a10_harmonic_i(ind,2);
        % plot
        scatter(st_dmax(high(i)),eta_high(i,1),'rv','filled')
    else if alpha_high(i,1) == 10
            ind = nearest(a10_sawtooth_i(:,1),st_dmax(high(i)));
            eta_high(i,1) = a10_sawtooth_i(ind,2);
            scatter(st_dmax(high(i)),eta_high(i,1),'bv','filled')
        else if alpha_high(i,1) == 20
                ind = nearest(a20_sawtooth_i(:,1),st_dmax(high(i)));
                eta_high(i,1) = a20_sawtooth_i(ind,2);
                scatter(st_dmax(high(i)),eta_high(i,1),'bv','filled')
            else if alpha_high(i,1) == 159
                    ind = nearest(a15_harmonic_i(:,1),st_dmax(high(i)));
                    eta_high(i,1) = a15_harmonic_i(ind,2);
                    scatter(st_dmax(high(i)),eta_high(i,1),'rv','filled')
                end
            end
        end
    end
end
% ascent
for i = 1:length(high)
    if alpha_high(i,2) == 10
        ind = nearest(a10_sawtooth_i(:,1),st_amax(high(i)));
        eta_high(i,2) = a10_sawtooth_i(ind,2);
        scatter(st_amax(high(i)),eta_high(i,2),'b^')
    else if alpha_high(i,2) == 15
            ind = nearest(a15_sawtooth_i(:,1),st_amax(high(i)));
            eta_high(i,2) = a15_sawtooth_i(ind,2);
            scatter(st_amax(high(i)),eta_high(i,2),'b^')
        else if alpha_high(i,2) == 20
                ind = nearest(a20_sawtooth_i(:,1),st_amax(high(i)));
                eta_high(i,2) = a20_sawtooth_i(ind,2);
                scatter(st_amax(high(i)),eta_high(i,2),'b^')
            else if alpha_high(i,2) == 25
                    ind = nearest(a25_sawtooth_i(:,1),st_amax(high(i)));
                    eta_high(i,2) = a25_sawtooth_i(ind,2);
                    scatter(st_amax(high(i)),eta_high(i,2),'b^')
                else if alpha_high(i,2) == 35
                        ind = nearest(a35_sawtooth_i(:,1),st_amax(high(i)));
                        eta_high(i,2) = a35_sawtooth_i(ind,2);
                        scatter(st_amax(high(i)),eta_high(i,2),'b^')
                    end
                end
            end
        end
    end
end

% for low drag
% descent
for i = 1:length(low)
    if alpha_low(i,1) == 109
        % what is nearest index?
        ind = nearest(a10_harmonic_i(:,1),st_dmax(low(i)));
        % store
        eta_low(i,1) = a10_harmonic_i(ind,2);
        % plot
        scatter(st_dmax(low(i)),eta_low(i,1),'rv','filled')
    else if alpha_low(i,1) == 10
            ind = nearest(a10_sawtooth_i(:,1),st_dmax(low(i)));
            eta_low(i,1) = a10_sawtooth_i(ind,2);
            scatter(st_dmax(low(i)),eta_low(i,1),'kv','filled')
        end
    end
end

% ascent
for i = 1:length(low)
    if alpha_low(i,2) == 10
        ind = nearest(a10_sawtooth_i(:,1),st_amax(low(i)));
        eta_low(i,2) = a10_sawtooth_i(ind,2);
        scatter(st_amax(low(i)),eta_low(i,2),'k^')
    else if alpha_low(i,2) == 109
            ind = nearest(a10_harmonic_i(:,1),st_amax(low(i)));
            eta_low(i,2) = a10_harmonic_i(ind,2);
            scatter(st_amax(low(i)),eta_low(i,2),'r^')
        end
    end
end

print('Eg3911_eta_est','-dtiff','-r300')

%% Take efficiency and look at change in efficiency with entanglement
efficiencyPlot
efficiencyStats

%% Compute Power
% power = D*U/efficiency
computePower
