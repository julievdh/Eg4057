propulsiveEfficiency_3911

%% CT Desc vs Asc
figure(10); set(gcf,'position',[8 240 750 375]) 
clf; subplot('position',[0.08 0.1 0.2 0.8]); hold on
plot(CT_E_d_atspeed,CT_E_a_atspeed,'bo')
plot(CT_DE_d_atspeed,CT_DE_a_atspeed,'ko')
ylim([0 1.2]); xlim([0 1.2])
plot([0 1.2],[0 1.2],'k')
xlabel('C_T on Descent'); ylabel('C_T on Ascent')
text(0.065,1.1,'A','FontSize',20,'FontWeight','Bold')

%% CT through time

% load prh and find dives
load('rw11_015aprh.mat')
T = finddives(p,fs,5);

subplot('position',[0.35 0.1 0.6 0.8]); hold on
scatter(T(high,1)/3600,CT_E_d_atspeed,'bv','filled')
scatter(T(low,1)/3600,CT_DE_d_atspeed(low),'kv','filled')
plot(T(high,1)/3600,CT_E_a_atspeed,'b^')
plot(T(low,1)/3600,CT_DE_a_atspeed(low),'k^')

xlabel('Time (hours)')
ylabel('Thrust Coefficient (C_T)')

adjustfigurefont

%% fit lm to CT
% only those dives after sedation induction
fitdesc = fitlm(T(9:53),CT_E_d_atspeed(9:end));
fitasc = fitlm(T(9:53),CT_E_a_atspeed(9:end));

w = linspace(T(9,1),T(high(end)));
line(w/3600,feval(fitdesc,w'),'Color','b')
line(w/3600,feval(fitasc,w'),'Color','b','LineStyle','--')

xlim([0 6.5])

plot([1217/3600 1217/3600],[0.10 0.15],'k','LineWidth',2)
text(795/3600,0.12,'^','FontSize',20,'FontWeight','Bold')
text(0.15,1.1,'B','FontSize',20,'FontWeight','Bold')
print('Eg3911_CT_ascdesc','-dtiff','-r300')