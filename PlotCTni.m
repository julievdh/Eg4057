% plot CT and Ni for all dives
% relies on propulsiveEfficiency_3911.m

figure(3); clf
subplot(121)
h = semilogy(U(1:13),CT_NE_a(1:13),U(1:13),CT_NE_a_lower(1:13),':',U(1:13),CT_NE_a_upper(1:13),':',...
    U(1:13),CT_NE_d(1:13),U(1:13),CT_NE_d_lower(1:13),':',U(1:13),CT_NE_d_upper(1:13),':'); % Not entangled 
set(h,'color',[0.5 0.5 0.5]); hold on
scatter(asc_maxspeed(high),CT_E_a_atspeed,'b^') % entangled ascent
scatter(desc_maxspeed(high),CT_E_d_atspeed,'bv','filled') % entangled descent
scatter(asc_maxspeed(low),CT_DE_a_atspeed(low),'k^') % disentangled ascent
scatter(desc_maxspeed(low),CT_DE_d_atspeed(low),'kv','filled') % disentangled descent

% plot all mean/SDs
plot([0.1 0.1],[mean(CT_E_d_atspeed(high))-std(CT_E_d_atspeed(high)) mean(CT_E_d_atspeed(high))+std(CT_E_d_atspeed(high))],'b')
plot(0.1,mean(CT_E_d_atspeed(high)),'bv','markerfacecolor','b') % entangled descent
plot([0.15 0.15],[nanmean(CT_E_a_atspeed(high))-nanstd(CT_E_a_atspeed(high)) nanmean(CT_E_a_atspeed(high))+nanstd(CT_E_a_atspeed(high))],'b')
plot(0.15,nanmean(CT_E_a_atspeed(high)),'b^','markerfacecolor','w') % entangled ascent
plot([0.2 0.2],[mean(CT_DE_d_atspeed(low))-std(CT_DE_d_atspeed(low)) mean(CT_DE_d_atspeed(low))+std(CT_DE_d_atspeed(low))],'k')
plot(0.2,mean(CT_DE_d_atspeed(low)),'kv','markerfacecolor','k')
plot([0.25 0.25],[mean(CT_DE_a_atspeed(low))-std(CT_DE_a_atspeed(low)) mean(CT_DE_a_atspeed(low))+std(CT_DE_a_atspeed(low))],'k')
plot(0.25,mean(CT_DE_a_atspeed(low)),'k^','markerfacecolor','w')

ylim([2.5E-2 1])
xlabel('Speed (m/s)'); ylabel('Coefficient of Thrust, C_T ')
text(0.05,0.86,'A','Fontsize',14,'FontWeight','Bold')
box on

%% plot ideal efficiency
subplot(122); hold on
h = plot(U(1:13),ni_NE_a(1:13),U(1:13),ni_NE_a_lower(1:13),':',U(1:13),ni_NE_a_upper(1:13),':',...
    U(1:13),ni_NE_d(1:13),U(1:13),ni_NE_d_lower(1:13),':',U(1:13),ni_NE_d_upper(1:13),':');
set(h,'color',[0.5 0.5 0.5])
scatter(asc_maxspeed(high),ni_E_a_atspeed,'b^')
scatter(desc_maxspeed(high),ni_E_d_atspeed,'bv','filled')
scatter(asc_maxspeed(low),ni_DE_a_atspeed(low),'k^')
scatter(desc_maxspeed(low),ni_DE_d_atspeed(low),'kv','filled')

% plot all mean/SDs
plot([0.1 0.1],[mean(ni_E_d_atspeed(high))-std(ni_E_d_atspeed(high)) mean(ni_E_d_atspeed(high))+std(ni_E_d_atspeed(high))],'b')
plot(0.1,mean(ni_E_d_atspeed(high)),'bv','markerfacecolor','b') % entangled descent
plot([0.15 0.15],[nanmean(ni_E_a_atspeed(high))-nanstd(ni_E_a_atspeed(high)) nanmean(ni_E_a_atspeed(high))+nanstd(ni_E_a_atspeed(high))],'b')
plot(0.15,nanmean(ni_E_a_atspeed(high)),'b^','markerfacecolor','w') % entangled ascent
plot([0.2 0.2],[mean(ni_DE_d_atspeed(low))-std(ni_DE_d_atspeed(low)) mean(ni_DE_d_atspeed(low))+std(ni_DE_d_atspeed(low))],'k')
plot(0.2,mean(ni_DE_d_atspeed(low)),'kv','markerfacecolor','k')
plot([0.25 0.25],[mean(ni_DE_a_atspeed(low))-std(ni_DE_a_atspeed(low)) mean(ni_DE_a_atspeed(low))+std(ni_DE_a_atspeed(low))],'k')
plot(0.25,mean(ni_DE_a_atspeed(low)),'k^','markerfacecolor','w')


xlabel('Speed (m/s)'); ylabel('Ideal Efficiency, \it\eta_i ')
text(0.05,0.993,'B','Fontsize',14,'FontWeight','Bold')
box on
adjustfigurefont
print('Eg3911_ni_alldives','-dpng','-r300')