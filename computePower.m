% computePower
% compute and compare and plot Power estimates (thrust power and overall
% power)

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


% figure(6); clf
% subplot(221); hold on
% histogram(P_ah)
% histogram(P_ah_lower)
% histogram(P_ah_upper)
% title('Ascent High')
% 
% subplot(222); hold on
% histogram(P_dh)
% histogram(P_dh_lower)
% histogram(P_dh_upper)
% title('Descent High')
% 
% subplot(223); hold on
% histogram(P_al)
% histogram(P_al_lower)
% histogram(P_al_upper)
% title('Ascent High')
% 
% subplot(224); hold on
% histogram(P_dl)
% histogram(P_dl_lower)
% histogram(P_dl_upper)
% title('Descent High')

figure(7); clf
subplot(121); hold on
setjit1 = rand(length(low),1)/4; setjit2 = rand(length(low),1)/4;
setjit3 = rand(length(high),1)/4; setjit4 = rand(length(high),1)/4;
% error bars?
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

xlim([-0.5 1.5])
set(gca,'xtick',[0 1],'xticklabels',{'Low Drag','High Drag'})
ylabel('Estimated Thrust Power (W), P = (D*U)/\eta')
box on
text(-.4,1160,'A','FontSize',14,'FontWeight','Bold')


%% stats
all_pt = vertcat(P_dh,P_dl,P_ah,P_al);
% boxplot(all_pt,{condition portion})
[p,t,stats] = anovan(all_pt,{condition portion},'varnames',{'Condition';'Dive Portion'});
[p,t,stats] = anovan(all_pt/0.25,{condition portion},'varnames',{'Condition';'Dive Portion'});
finc_d = nanmean(P_dh)/nanmean(P_dl); % and same number if P_dh/0.25 and P_dl/0.25
finc_a = nanmean(P_ah)/nanmean(P_dl);

%% 
subplot(122); hold on
setjit1 = rand(length(low),1)/4; setjit2 = rand(length(low),1)/4;
setjit3 = rand(length(high),1)/4; setjit4 = rand(length(high),1)/4;
% error bars?
for i = 1:length(low)
plot([0+setjit1(i) 0+setjit1(i)],[P_al_lower(i)/0.25 P_al_upper(i)/0.25],'k') % aerobic efficiency
plot([0-setjit2(i) 0-setjit2(i)],[P_dl_lower(i)/0.25 P_dl_upper(i)/0.25],'k')
end
for i = 1:length(high)
plot([1+setjit3(i) 1+setjit3(i)],[P_ah_lower(i)/0.25 P_ah_upper(i)/0.25],'b')
plot([1-setjit4(i) 1-setjit4(i)],[P_dh_lower(i)/0.25 P_dh_upper(i)/0.25],'b')
end
% plot triangles
scatter(zeros(length(low),1)+setjit1,P_al/0.25,[],'k^','MarkerFaceColor','w')
scatter(zeros(length(low),1)-setjit2,P_dl/0.25,[],'kv','Filled')
scatter(ones(length(high),1)+setjit3,P_ah/0.25,[],'b^','MarkerFaceColor','w')
scatter(ones(length(high),1)-setjit4,P_dh/0.25,[],'bv','Filled')

xlim([-0.5 1.5])
set(gca,'xtick',[0 1],'xticklabels',{'Low Drag','High Drag'})
ylabel('Estimated Power (W), P = (D*U)/(\eta*\eta_a)') % includes chemical efficiency
box on
adjustfigurefont
text(-.4,4350,'B','FontSize',14,'FontWeight','Bold')
print('Eg3911_PTPO.eps','-depsc','-r300')