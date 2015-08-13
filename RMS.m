% RMS: calculate and compare root mean square amplitude 
% rms_x = sqrt(mean(x.^2));

rms_3911_high = sqrt(mean(rw015a.ph(rw015a.p1(1)*fs:rw015a.p1(2)*fs).^2));
rms_3911_low = sqrt(mean(rw015a.ph(rw015a.p2(1)*fs:rw015a.p3(2)*fs).^2));

rms_4057_low1 = sqrt(mean(eg047a.ph(eg047a.p1(1)*fs:eg047a.p1(2)*fs).^2));
rms_4057_low2 = sqrt(mean(eg047a.ph(eg047a.p2(1)*fs:eg047a.p2(2)*fs).^2));
rms_4057_low = mean([rms_4057_low1 rms_4057_low2]);
rms_4057_high = sqrt(mean(eg047a.ph(eg047a.p3(1)*fs:eg047a.p3(2)*fs).^2));

%% find rms in dives

eg047a.T = finddives(eg047a.p,fs,1,1,0);
[eg047a.v,eg047a.ph,eg047a.mx,eg047a.fr] = findflukes(eg047a.Aw,eg047a.Mw,fs,0.3,0.01,[0.7 4]);
rw015a.T = finddives(rw015a.p,fs,1,1,0);
[rw015a.v,rw015a.ph,rw015a.mx,rw015a.fr] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 4]);

% for a dive
for dive = 1:length(eg047a.T)
rms_4057(dive) = sqrt(mean(eg047a.ph(eg047a.T(dive,1)*fs:eg047a.T(dive,2)*fs)).^2);
end

for dive = 1:length(rw015a.T)
    rms_3911(dive) =  sqrt(mean(rw015a.ph(rw015a.T(dive,1)*fs:rw015a.T(dive,2)*fs)).^2);
end
%%

low1_4057 = find(eg047a.T(:,1) > eg047a.p1(1) & eg047a.T(:,1) < eg047a.p1(2));
low2_4057 = find(eg047a.T(:,1) > eg047a.p1(1) & eg047a.T(:,1) < eg047a.p1(2));
low_4057 = vertcat(low1_4057,low2_4057);
high_4057 = find(eg047a.T(:,1) > eg047a.p3(1) & eg047a.T(:,1) < eg047a.p3(2));

low_3911 = find(rw015a.T(:,1) > rw015a.p2(1) & rw015a.T(:,1) < rw015a.p3(2));
high_3911 = find(rw015a.T(:,1) > rw015a.p1(1) & rw015a.T(:,1) < rw015a.p1(2));
%%
figure(1); clf; hold on
[h1,b] = hist(rms_3911(low_3911),0:0.01:0.2);
[h2,b] = hist(rms_3911(high_3911),0:0.01:0.2);
h1 = h1/sum(h1);
h2 = h2/sum(h2);
h = bar(b,[h1;h2]','grouped');

figure(2); clf; hold on
[h1,b] = hist(rms_4057(low_4057),0:0.01:0.2);
[h2,b] = hist(rms_4057(high_4057),0:0.01:0.2);
h1 = h1/sum(h1);
h2 = h2/sum(h2);
h = bar(b,[h1;h2]','grouped');
