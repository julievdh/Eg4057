% efficiencyStats
% How do efficiency and St change with entanglement?

allst = vertcat(st_dmax',st_amax');
boxplot(allst,{condition portion})
% two-way ANOVA
% [p,t,stats] = anovan(allni,{condition portion},'varnames',{'Condition';'Dive Portion'});
% [mean(st_dmax(low)) std(st_dmax(low))]
% [mean(st_dmax(high)) std(st_dmax(high))]
% [mean(st_amax(low)) std(st_amax(low))]
% [nanmean(st_amax(high)) nanstd(st_amax(high))]

alleta = vertcat(eta_high(:,1),eta_low(:,1),eta_high(:,2),eta_low(:,2));
% two-way ANOVA
% [p,t,stats] = anovan(alleta,{condition portion},'varnames',{'Condition';'Dive Portion'});
% [mean(eta_low(:,1)) std(eta_low(:,1))]
% [nanmean(eta_high(:,1)) nanstd(eta_high(:,1))]
% [mean(eta_low(:,2)) std(eta_low(:,2))] % low drag ascent
% [mean(eta_high(:,2)) std(eta_high(:,2))] % high drag ascent
% finc_d = nanmean(eta_low(:,1))/nanmean(eta_high(:,1));
% finc_a = nanmean(eta_low(:,2))/nanmean(eta_high(:,2));
