FSRcompare

% load in other data
load('DescAscVspeed')
close all

% set up dive conditions
low = 54:154;
high = 1:53;

%%
% % plot non-dimentsional fluke-beat amplitude (A/L) vs. non-dimensional
% % fluke-beat-frequency (f/(U/L))
% figure(1); clf; hold on
% scatter(hz_d(low)./(desc_maxspeed(low)/10),mn_amp_d(low)/10,'kv','filled')      % descent low
% scatter(hz_d(high)./(desc_maxspeed(high)/10),mn_amp_d(high)/10,'bv','filled')   % descent high
% scatter(hz_a(low)./(asc_maxspeed(low)/10),mn_amp_a(low)/10,'k^')                % ascent low
% scatter(hz_a(high)./(asc_maxspeed(high)/10),mn_amp_a(high)/10,'b^')             % ascent high
% xlabel('Non-dimensional fluke-beat frequency (f/(U/L)')
% ylabel('Non-dimensional fluke-beat amplitude (A/L)')
% 
% %% calculate and plot contours
% 
% x=linspace(0,25,20);        % normalized frequency values
% y=linspace(0,0.4,20);       % normalized amplitude values
% [x,y]=meshgrid(x,y);
% z=x.*y;                     % z = St value for combination of fnorm and Anorm
% v = [0.2,0.3,0.4,1,2];      % force contours to these values
% [c,h] = contour(x,y,z,v);
% clabel(c,h)
% 
% %% calculate what A would be if St == 0.3
% Amp_est_d = 0.3./(hz_d./(desc_maxspeed/10));
% Amp_est_a = 0.3./(hz_a./(asc_maxspeed/10));

%% SOMETHING ELSE: speed vs freq
figure(10); clf; hold on

scatter(asc_vspeed_015a(high),hz_a_3911(high),'b^')
scatter(asc_vspeed_015a(low),hz_a_3911(low),'k^')
scatter(desc_vspeed_015a(low),hz_d_3911(low),'kv','filled')
scatter(desc_vspeed_015a(high),hz_d_3911(high),'bv','filled')
xlabel('Mean vertical speed (m/s)'); ylabel('Frequency (Hz)')

%%
low = [1:6,8:12];                                   % dive 7 tag moves
high = [13:15,18:20];                               % dives 16, 17 tag moves

figure(11); clf; hold on 
scatter(asc_vspeed_047a(high),hz_a_4057(high),'b^')
scatter(asc_vspeed_047a(low),hz_a_4057(low),'k^')
scatter(desc_vspeed_047a(low),hz_d_4057(low),'kv','filled')
scatter(desc_vspeed_047a(high),hz_d_4057(high),'bv','filled')
xlabel('Mean vertical speed (m/s)'); ylabel('Frequency (Hz)')