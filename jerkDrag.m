% Jerk
load_rw015a
loadprh(tag)
%%
% calculate jerk and MSA
j = njerk(rw015a.A,fs);
m = msa(rw015a.A);
t = (1:length(rw015a.A))/fs;

% get pitch deviation
[~,rw015a.ph,~,~] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 8]);

%% plot 
figure(1); clf
subplot(121);hold on
plot(t(rw015a.p1(1)*fs:rw015a.p1(2)*fs),j(rw015a.p1(1)*fs:rw015a.p1(2)*fs))
plot(t(rw015a.p1(1)*fs:rw015a.p1(2)*fs),-rw015a.p(rw015a.p1(1)*fs:rw015a.p1(2)*fs),'k')
plot(t(rw015a.p1(1)*fs:rw015a.p1(2)*fs),rw015a.ph(rw015a.p1(1)*fs:rw015a.p1(2)*fs),'r')
plot(t(rw015a.p1(1)*fs:rw015a.p1(2)*fs),m(rw015a.p1(1)*fs:rw015a.p1(2)*fs),'g')
ylim([-30 50]); xlim([0 6670])

subplot(122);hold on
plot(t(rw015a.p2(1)*fs:rw015a.p3(2)*fs),j(rw015a.p2(1)*fs:rw015a.p3(2)*fs))
plot(t(rw015a.p2(1)*fs:rw015a.p3(2)*fs),-rw015a.p(rw015a.p2(1)*fs:rw015a.p3(2)*fs),'k')
plot(t(rw015a.p2(1)*fs:rw015a.p3(2)*fs),rw015a.ph(rw015a.p2(1)*fs:rw015a.p3(2)*fs),'r')
plot(t(rw015a.p2(1)*fs:rw015a.p3(2)*fs),m(rw015a.p2(1)*fs:rw015a.p3(2)*fs),'g')
ylim([-30 50]); xlim([6600 22300])

% overlay?
figure(2); clf; hold on
plot(j(1362*fs:1480*fs))
plot(j(7750*fs:7880*fs),'k')

plot(-rw015a.p(1362*fs:1480*fs))
plot(-rw015a.p(7750*fs:7880*fs),'k')

%% find dives
rw015a.T = finddives(rw015a.p,fs,5,1);              % find dives
figure(3); 
for i = 1:53
clf; hold on; ylim([-30 50])
plot(-rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'b')
plot(j(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'b')
pause
end
for i = 54:154
    clf; hold on; ylim([-30 50])
plot(-rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'k')
plot(j(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs),'k')
pause
end
