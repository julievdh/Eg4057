% computePower
% compute and compare and plot Power estimates (thrust power and overall
% power)

% replace eta < 0.05 = NaN
eta_high(eta_high < 0.03) = NaN;
eta_low(eta_low < 0.03) = NaN;

% ascent high
P_ah = (Dtot_highdrag(ind_a(high)).*U(ind_a(high)))'./eta_high(:,2);
P_ah_lower = (Dtot_high_lower(ind_a(high)).*U(ind_a(high)))'./eta_high(:,2);
P_ah_upper = (Dtot_high_upper(ind_a(high)).*U(ind_a(high)))'./eta_high(:,2);

% descent high
P_dh = (Dtot_highdrag(ind_a(high)).*U(ind_a(high)))'./eta_high(:,1);
P_dh_lower = (Dtot_high_lower(ind_a(high)).*U(ind_a(high)))'./eta_high(:,1);
P_dh_upper = (Dtot_high_upper(ind_a(high)).*U(ind_a(high)))'./eta_high(:,1);

% ascent low
P_al = (Dtot_lowdrag(ind_a(low)).*U(ind_a(low)))'./eta_low(:,2);
P_al_lower = (Dtot_low_lower(ind_a(low)).*U(ind_a(low)))'./eta_low(:,2);
P_al_upper = (Dtot_low_upper(ind_a(low)).*U(ind_a(low)))'./eta_low(:,2);

% descent low
P_dl = (Dtot_lowdrag(ind_a(low)).*U(ind_a(low)))'./eta_low(:,1);
P_dl_lower = (Dtot_low_lower(ind_a(low)).*U(ind_a(low)))'./eta_low(:,1);
P_dl_upper = (Dtot_low_upper(ind_a(low)).*U(ind_a(low)))'./eta_low(:,1);

figure(7); clf
subplot(121); hold on
setjit1 = rand(length(low),1)/4; setjit2 = rand(length(low),1)/4;
setjit3 = rand(length(high),1)/4; setjit4 = rand(length(high),1)/4;
% error bars
for i = 1:length(low)
plot([0+setjit1(i) 0+setjit1(i)],[P_al_lower(i) P_al_upper(i)],'k')
plot([0-setjit2(i) 0-setjit2(i)],[P_dl_lower(i) P_dl_upper(i)],'k')
end
for i = 1:length(high)
plot([1+setjit3(i) 1+setjit3(i)],[P_ah_lower(i) P_ah_upper(i)],'b')
plot([1-setjit4(i) 1-setjit4(i)],[P_dh_lower(i) P_dh_upper(i)],'b')
end
% plot triangles
scatter(zeros(length(low),1)+setjit1,P_al,[],'k^','MarkerFaceColor','w')
scatter(zeros(length(low),1)-setjit2,P_dl,[],'kv','Filled')
scatter(ones(length(high),1)+setjit3,P_ah,[],'b^','MarkerFaceColor','w')
scatter(ones(length(high),1)-setjit4,P_dh,[],'bv','Filled')

% plot overall mean/SDs
plot([-0.4 -0.4],[nanmean(P_dl)-nanstd(P_dl) nanmean(P_dl)+nanstd(P_dl)],'k')
plot(-0.4,nanmean(P_dl),'kv','markerfacecolor','k') % disentangled descent
plot([0.4 0.4],[nanmean(P_al)-nanstd(P_al) nanmean(P_al)+nanstd(P_al)],'k')
plot(0.4,nanmean(P_al),'k^','markerfacecolor','w') % disentangled ascent
plot([0.6 0.6],[nanmean(P_dh)-nanstd(P_dh) nanmean(P_dh)+nanstd(P_dh)],'b')
plot(0.6,nanmean(P_dh),'bv','markerfacecolor','b') % entangled descent
plot([1.4 1.4],[nanmean(P_ah)-nanstd(P_ah) nanmean(P_ah)+nanstd(P_ah)],'b')
plot(1.4,nanmean(P_ah),'b^','markerfacecolor','w') % entangled ascent

% values for Table 2 in paper
% [nanmean(P_dl) nanstd(P_dl)]
% [nanmean(P_al) nanstd(P_al)]
% [nanmean(P_dh) nanstd(P_dh)]
% [nanmean(P_ah) nanstd(P_ah)]

xlim([-0.5 1.5]); ylim([0 4200])
set(gca,'xtick',[0 1],'xticklabels',{'Low Drag','High Drag'})
ylabel('Thrust Power (W), P = (D*U)/\eta_p')
box on
text(-.4,4000,'A','FontSize',14,'FontWeight','Bold')


%% stats
all_pt = vertcat(P_dh,P_dl,P_ah,P_al);
% boxplot(all_pt,{condition portion})
% [p,t,stats] = anovan(all_pt,{condition portion},'varnames',{'Condition';'Dive Portion'});
% [p,t,stats] = anovan(all_pt/0.25,{condition portion},'varnames',{'Condition';'Dive Portion'});
finc_d = nanmean(P_dh)/nanmean(P_dl); % and same number if P_dh/0.25 and P_dl/0.25
finc_a = nanmean(P_ah)/nanmean(P_al);

%% 
%subplot(122); hold on
% setjit1 = rand(length(low),1)/4; setjit2 = rand(length(low),1)/4;
% setjit3 = rand(length(high),1)/4; setjit4 = rand(length(high),1)/4;
% % error bars?
% for i = 1:length(low)
% plot([0+setjit1(i) 0+setjit1(i)],[P_al_lower(i)/0.25 P_al_upper(i)/0.25],'k') % aerobic efficiency
% plot([0-setjit2(i) 0-setjit2(i)],[P_dl_lower(i)/0.25 P_dl_upper(i)/0.25],'k')
% end
% for i = 1:length(high)
% plot([1+setjit3(i) 1+setjit3(i)],[P_ah_lower(i)/0.25 P_ah_upper(i)/0.25],'b')
% plot([1-setjit4(i) 1-setjit4(i)],[P_dh_lower(i)/0.25 P_dh_upper(i)/0.25],'b')
% end
% % plot triangles
% scatter(zeros(length(low),1)+setjit1,P_al/0.25,[],'k^','MarkerFaceColor','w')
% scatter(zeros(length(low),1)-setjit2,P_dl/0.25,[],'kv','Filled')
% scatter(ones(length(high),1)+setjit3,P_ah/0.25,[],'b^','MarkerFaceColor','w')
% scatter(ones(length(high),1)-setjit4,P_dh/0.25,[],'bv','Filled')
% 
% xlim([-0.5 1.5])
% set(gca,'xtick',[0 1],'xticklabels',{'Low Drag','High Drag'})
% ylabel('Estimated Power (W), P = (D*U)/(\eta_p*\eta_m)') % includes chemical efficiency
% box on
% adjustfigurefont
% text(-.4,4350,'B','FontSize',14,'FontWeight','Bold')
% print('Eg3911_PTPO.eps','-depsc','-r300')

% values for Table 2 in paper
% [nanmean(P_dl/0.25) nanstd(P_dl/0.25)]
% [nanmean(P_al/0.25) nanstd(P_al/0.25)]
% [nanmean(P_dh/0.25) nanstd(P_dh/0.25)]
% [nanmean(P_ah/0.25) nanstd(P_ah/0.25)]

% All Descents vs. All Ascents
nanmean([P_dl; P_dh]);
nanmean([P_al; P_ah]);
nanmean([P_al; P_ah])/nanmean([P_dl; P_dh]);

%% Plot power vs. speed
% calculate expected from theoretical
power_lowdrag = (Dtot_lowdrag.*U)./nanmean(eta_low(:));
power_lowdrag_low = (Dtot_low_lower.*U)./nanmean(eta_low(:));
power_lowdrag_up = (Dtot_low_upper.*U)./nanmean(eta_low(:));

power_highdrag = (Dtot_highdrag.*U)./nanmean(eta_high(:));
power_highdrag_low = (Dtot_high_lower.*U)./nanmean(eta_high(:));
power_highdrag_up = (Dtot_high_upper.*U)./nanmean(eta_high(:));


subplot(122); hold on
plot(U,power_lowdrag,'k'); plot(U,power_lowdrag_low,'k:'); plot(U,power_lowdrag_up,'k:')
plot(U,power_highdrag,'b'); plot(U,power_highdrag_low,'b:'); plot(U,power_highdrag_up,'b:')
% error bars
for i = 1:length(low)
plot([asc_maxspeed(low(i)) asc_maxspeed(low(i))],[P_al_lower(i) P_al_upper(i)],'k')
plot([desc_maxspeed(low(i)) desc_maxspeed(low(i))],[P_dl_lower(i) P_dl_upper(i)],'k')
end
for i = 1:length(high)
plot([asc_maxspeed(high(i)) asc_maxspeed(high(i))],[P_ah_lower(i) P_ah_upper(i)],'b')
plot([desc_maxspeed(high(i)) desc_maxspeed(high(i))],[P_dh_lower(i) P_dh_upper(i)],'b')
end
plot(asc_maxspeed(low),P_al,'k^','markerfacecolor','w')
plot(asc_maxspeed(high),P_ah,'b^','markerfacecolor','w')
scatter(desc_maxspeed(high),P_dh,'bv','filled')
scatter(desc_maxspeed(low),P_dl,'kv','filled')
xlabel('Speed (m/s)'); ylabel('Thrust Power (W), P = (D*U)/\eta_p')
xlim([0 1.5]); ylim([0 4200]); box on
text(0.09,4000,'B','FontSize',14,'FontWeight','Bold')
adjustfigurefont

cd /Users/julievanderhoop/Documents/MATLAB/Eg4057/AnalysisFigs
print('Eg3911_PTspeed.png','-dpng','-r300')