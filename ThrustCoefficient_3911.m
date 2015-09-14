% calculate thrust coefficient for Eg 3911 based on amplitude, fluke span
% for whaleSt and propulsiveEfficiency_3911
% August/September 2015

% load amplitudes, speeds, St for every dive
cd /Users/julievanderhoop/Documents/MATLAB/Eg4057
load('eg3911_Stvars')

% amplitude of fluke oscillation
A_E_a = mn_amp_am; % amplitude for entangled 3911 on ascent
A_E_d = mn_amp_dm; % amplitude for entangled 3911 on descent
A_NE_a = mean(mn_amp_am(low)); % average amplitude for non-entangled 3911 ascent
A_NE_d = mean(mn_amp_dm(low)); % average amplitude for non-entangled 3911 descent
span = 78.234*exp(0.001*10*100); % from Moore et al. 2005, Figure 1e
% figure(10); x = 2:16; plot(l,span,'o',x,78.234*exp(0.001*x*100))
span = span/100; % convert to m

% entangled thrust coefficient CTE on ascent and descent across all speeds
for i = 1:53 % high drag dives
    % descent
    CT_E_d(i,:) = Dtot_highdrag./(0.5*rho*U.^2.*(A_E_d(i).*span));
    CT_E_d_lower(i,:) = Dtot_high_lower./(0.5*rho*U.^2.*(A_E_d(i)*span));
    CT_E_d_upper(i,:) = Dtot_high_upper./(0.5*rho*U.^2.*(A_E_d(i)*span));
    
    % ascent
    CT_E_a(i,:) = Dtot_highdrag./(0.5*rho*U.^2.*(A_E_a(i).*span));
    CT_E_a_lower(i,:) = Dtot_high_lower./(0.5*rho*U.^2.*(A_E_a(i)*span));
    CT_E_a_upper(i,:) = Dtot_high_upper./(0.5*rho*U.^2.*(A_E_a(i)*span));
end

% disentangled thrust coefficient CTD
for i = 54:154 % low drag dives
    % descent
    CT_DE_d(i,:) = Dtot_lowdrag./(0.5*rho*U.^2.*(A_E_d(i)*span));
    CT_DE_d_lower(i,:) = Dtot_low_lower./(0.5*rho*U.^2.*(A_E_d(i)*span));
    CT_DE_d_upper(i,:) = Dtot_low_upper./(0.5*rho*U.^2.*(A_E_d(i)*span));
    
    % ascent
    CT_DE_a(i,:) = Dtot_lowdrag./(0.5*rho*U.^2.*(A_E_a(i)*span));
    CT_DE_a_lower(i,:) = Dtot_low_lower./(0.5*rho*U.^2.*(A_E_a(i)*span));
    CT_DE_a_upper(i,:) = Dtot_low_upper./(0.5*rho*U.^2.*(A_E_a(i)*span));
end

% non-entangled thrust coefficient CTN
CT_NE_a = whaleDf./(0.5*rho*U.^2.*(A_NE_a*span));
CT_NE_a_lower = whaleDf_lower./(0.5*rho*U.^2.*((A_NE_a+0.12)*span)); % added amplitude SD
CT_NE_a_upper = whaleDf_upper./(0.5*rho*U.^2.*((A_NE_a-0.12)*span));
CT_NE_d = whaleDf./(0.5*rho*U.^2.*(A_NE_d*span));
CT_NE_d_lower = whaleDf_lower./(0.5*rho*U.^2.*((A_NE_d+0.17)*span)); % added amplitude SD
CT_NE_d_upper = whaleDf_upper./(0.5*rho*U.^2.*((A_NE_d-0.17)*span));

figure(2); clf
subplot(211); hold on
plot(U,CT_E_d,'b-',U,CT_E_d_lower,'b:',U,CT_E_d_upper,'b:')
plot(U,CT_DE_d,'k-',U,CT_DE_d_lower,'k:',U,CT_DE_d_upper,'k:')
h = plot(U,CT_NE_d,U,CT_NE_d_lower,':',U,CT_NE_d_upper,':');
set(h,'color',[0.5 0.5 0.5])
title('Descent'); ylim([0 2.5]); ylabel('Coefficient of Thrust, C_T')

subplot(212); hold on
plot(U,CT_E_a,'b-',U,CT_E_a_lower,'b:',U,CT_E_a_upper,'b:')
plot(U,CT_DE_a,'k-',U,CT_DE_a_lower,'k:',U,CT_DE_a_upper,'k:')
h = plot(U,CT_NE_a,U,CT_NE_a_lower,':',U,CT_NE_a_upper,':');
set(h,'color',[0.5 0.5 0.5])
title('Ascent'); ylim([0 2.5])

xlabel('Speed (m/s)'); ylabel('Coefficient of Thrust, C_T')
adjustfigurefont
print('Eg3911_CT.eps','-depsc','-r300')