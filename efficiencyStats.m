% efficiencyStats
% How do efficiency and St change with entanglement?

allst = vertcat(St_d',St_a');
figure
boxplot(allst,{condition portion})
% two-way ANOVA
[p,t,stats] = anovan(allni,{condition portion},'model','interaction','varnames',{'Condition';'Dive Portion'});
% [mean(St_d(low)) std(St_d(low))]
% [nanmean(St_d(high)) nanstd(St_d(high))]
% [mean(St_a(low)) std(St_a(low))]
% [nanmean(St_a(high)) nanstd(St_a(high))]

alleta = vertcat(eta_high(:,1),eta_low(:,1),eta_high(:,2),eta_low(:,2));
boxplot(alleta,{condition portion})
% two-way ANOVA
[p,t,stats] = anovan(alleta,{condition portion},'model','interaction','varnames',{'Condition';'Dive Portion'});
% [nanmean(eta_low(:,1)) nanstd(eta_low(:,1))]
% [nanmean(eta_high(:,1)) nanstd(eta_high(:,1))]
% [mean(eta_low(:,2)) std(eta_low(:,2))] % low drag ascent
% [nanmean(eta_high(:,2)) nanstd(eta_high(:,2))] % high drag ascent
finc_d = nanmean(eta_low(:,1))/nanmean(eta_high(:,1));
finc_a = nanmean(eta_low(:,2))/nanmean(eta_high(:,2));
