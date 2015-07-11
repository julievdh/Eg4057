% RMS: calculate and compare root mean square amplitude 
% rms_x = sqrt(mean(x.^2));

rms_3911_high = sqrt(mean(rw015a.ph(rw015a.p1(1)*fs:rw015a.p1(2)*fs).^2));
rms_3911_low = sqrt(mean(rw015a.ph(rw015a.p2(1)*fs:rw015a.p3(2)*fs).^2));

rms_4057_low1 = sqrt(mean(eg047a.ph(eg047a.p1(1)*fs:eg047a.p1(2)*fs).^2));
rms_4057_low2 = sqrt(mean(eg047a.ph(eg047a.p2(1)*fs:eg047a.p2(2)*fs).^2));
rms_4057_low = mean([rms_4057_low1 rms_4057_low2]);
rms_4057_high = sqrt(mean(eg047a.ph(eg047a.p3(1)*fs:eg047a.p3(2)*fs).^2));

