% efficiencyPlot
% plot Eg 3911 Strouhal and Efficiency

warning off

% replace zeros with NaNs
eta_high(eta_high == 0) = NaN; eta_low(eta_low == 0) = NaN;
% remove St outliers 
St_d(St_d > 1.6) = NaN; St_a(St_a > 1.6) = NaN;

% plot
figure(5); clf;
subplot(121); hold on
% mean/SD
plot([-0.4 -0.4],[mean(St_d(low))-std(St_d(low)) mean(St_d(low))+std(St_d(low))],'k')
plot(-0.4,mean(St_d(low)),'kv','markerfacecolor','k') 
scatter(zeros(length(low),1)-rand(length(low),1)/4,St_d(low),[],'kv','filled') % all data low descent

plot([0.6 0.6],[mean(St_d(high))-std(St_d(high)) mean(St_d(high))+std(St_d(high))],'b') % mean/SD high descent
plot(0.6,mean(St_d(high)),'bv','markerfacecolor','b') 
scatter(ones(length(high),1)-rand(length(high),1)/4,St_d(high),[],'bv','filled')

plot([0.4 0.4],[nanmean(St_a(low))-nanstd(St_a(low)) nanmean(St_a(low))+nanstd(St_a(low))],'k')
plot(0.4,nanmean(St_a(low)),'k^','markerfacecolor','w') 
scatter(zeros(length(low),1)+rand(length(low),1)/4,St_a(low),[],'k^') % low ascent

plot([1.4 1.4],[nanmean(St_a(high))-nanstd(St_a(high)) nanmean(St_a(high))+nanstd(St_a(high))],'b')
plot(1.4,nanmean(St_a(high)),'b^','markerfacecolor','w') 
scatter(ones(length(high),1)+rand(length(high),1)/4,St_a(high),[],'b^') % high ascent
set(gca,'xtick',[0 1],'xticklabels',{'Low Drag','High Drag'})
ylabel('Strouhal Number, \itSt')
text(-0.4240,1.62,'A','FontSize',14,'FontWeight','Bold')
box on; ylim([0 1.7]); xlim([-0.5 1.5])
%% 
% plot efficiencies 
subplot(122); hold on
% low drag descent
setjit4 = rand(length(low),1)/4;
scatter(zeros(length(low),1)-setjit4,eta_low(:,1),[],'kv','filled')
plot([-0.4 -0.4],[nanmean(eta_low(:,1))-nanstd(eta_low(:,1)) nanmean(eta_low(:,1))+nanstd(eta_low(:,1))],'k')
plot(-0.4,nanmean(eta_low(:,1)),'kv','markerfacecolor','k') 

%ii = find(alpha_low(:,1) == 109 | alpha_low(:,1) == 159); % find harmonic
%scatter(zeros(length(ii),1)-setjit4(ii),eta_low(ii,1),[],'rv')
% high drag descent
setjit4 = rand(length(high),1)/4;
scatter(ones(length(high),1)-setjit4,eta_high(:,1),[],'bv','filled')
plot([0.6 0.6],[nanmean(eta_high(:,1))-nanstd(eta_high(:,1)) nanmean(eta_high(:,1))+nanstd(eta_high(:,1))],'b')
plot(0.6,nanmean(eta_high(:,1)),'bv','markerfacecolor','b') 

%ii = find(alpha_high(:,1) == 109 | alpha_high(:,1) == 159); % find harmonic
%scatter(ones(length(ii),1)-setjit4(ii),eta_high(ii,1),[],'rv')
% low drag ascent
setjit4 = rand(length(low),1)/4;
scatter(zeros(length(low),1)+setjit4,eta_low(:,2),[],'k^')
plot([0.4 0.4],[nanmean(eta_low(:,2))-nanstd(eta_low(:,2)) nanmean(eta_low(:,2))+nanstd(eta_low(:,2))],'k')
plot(0.4,nanmean(eta_low(:,2)),'k^','markerfacecolor','w') 
ii = find(alpha_low(:,2) == 109 | alpha_low(:,2) == 159);
%scatter(zeros(length(ii),1)+setjit4(ii),eta_low(ii,2),[],'r^')
% high drag ascent
plot([1.4 1.4],[nanmean(eta_high(:,2))-nanstd(eta_high(:,2)) nanmean(eta_high(:,2))+nanstd(eta_high(:,2))],'b')
plot(1.4,nanmean(eta_high(:,2)),'b^','markerfacecolor','w') 
scatter(ones(length(high),1)+rand(length(high),1)/4,eta_high(:,2),[],'b^') % no harmonic ones here
set(gca,'xtick',[0 1],'xticklabels',{'Low Drag','High Drag'})
ylabel('Propulsive Efficiency,\it\eta_p')
box on; xlim([-0.5 1.5]); ylim([0 0.6])
adjustfigurefont
text(-0.4240,0.575,'B','FontSize',14','FontWeight','Bold')

print('3911_EfficiencyChange','-dtiff','-r300')

return
%% Efficiency vs speed
figure; hold on
plot(asc_maxspeed(1:53),eta_high(:,2),'b^')
plot(asc_maxspeed(54:end),eta_low(:,2),'k^')
scatter(desc_maxspeed(54:end),eta_low(:,1),'kv','filled')
scatter(desc_maxspeed(1:53),eta_high(:,1),'bv','filled')
xlabel('Max Vertical Speed m/s'); ylabel('Propulsive efficiency')
