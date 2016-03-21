% plot CT and Ni for all dives
% relies on propulsiveEfficiency_3911.m

figure(3); clf
subplot(121)
h = semilogy(U(1:13),CT_NE_a(1:13),U(1:13),CT_NE_a_lower(1:13),':',U(1:13),CT_NE_a_upper(1:13),':',...
    U(1:13),CT_NE_d(1:13),U(1:13),CT_NE_d_lower(1:13),':',U(1:13),CT_NE_d_upper(1:13),':');
set(h,'color',[0.5 0.5 0.5]); hold on
scatter(asc_maxspeed(high),CT_E_a_atspeed,'b^')
scatter(desc_maxspeed(high),CT_E_d_atspeed,'bv','filled')
scatter(asc_maxspeed(low),CT_DE_a_atspeed(low),'k^')
scatter(desc_maxspeed(low),CT_DE_d_atspeed(low),'kv','filled')

ylim([2.5E-2 1])
xlabel('Speed (m/s)'); ylabel('Coefficient of Thrust, C_T ')
text(0.05,0.86,'A','Fontsize',14,'FontWeight','Bold')
box on

subplot(122); hold on
h = plot(U(1:13),ni_NE_a(1:13),U(1:13),ni_NE_a_lower(1:13),':',U(1:13),ni_NE_a_upper(1:13),':',...
    U(1:13),ni_NE_d(1:13),U(1:13),ni_NE_d_lower(1:13),':',U(1:13),ni_NE_d_upper(1:13),':');
set(h,'color',[0.5 0.5 0.5])
scatter(asc_maxspeed(high),ni_E_a_atspeed,'b^')
scatter(desc_maxspeed(high),ni_E_d_atspeed,'bv','filled')
scatter(asc_maxspeed(low),ni_DE_a_atspeed(low),'k^')
scatter(desc_maxspeed(low),ni_DE_d_atspeed(low),'kv','filled')

xlabel('Speed (m/s)'); ylabel('Ideal Efficiency, \it\eta_i ')
text(0.05,0.993,'B','Fontsize',14,'FontWeight','Bold')
box on
adjustfigurefont
print('Eg3911_ni_alldives','-dpng','-r300')