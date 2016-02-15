% EstimateAlpha: estimate angle of attack from harmonic and sawtooth
% profiles from Hover 2004 Figure 5


%% plot through and estimate alpha for each dive ascent and descent
figure(6); clf
subplot(121)
% with sawtooth curves
hold on; box on
xlabel('Strouhal Number, \itSt '); ylabel('C_T/St^2')
% plot Hover contours
load('Hover2004_Fig5')
h = plot(a10_sawtooth(:,1),a10_sawtooth(:,2),a15_sawtooth(:,1),a15_sawtooth(:,2),...
    a20_sawtooth(:,1),a20_sawtooth(:,2),a25_sawtooth(:,1),a25_sawtooth(:,2),...
    a30_sawtooth(:,1),a30_sawtooth(:,2),a35_sawtooth(:,1),a35_sawtooth(:,2));
set(h,'color',[0.75 0.75 0.75])
h = plot(a10_harmonic(:,1),a10_harmonic(:,2),a15_harmonic(:,1),a15_harmonic(:,2)); % harmonic contours for low angles and low St
set(h,'color','k')

text(0.85,9.4728,'\alpha = 35^0')
text(0.85,8.1629,'\alpha = 30^0')
text(0.85,6.5016,'\alpha = 25^0')
text(0.85,4.7444,'\alpha = 20^0')
text(0.85,2.6677,'\alpha = 15^0')
text(0.85,0.7827,'\alpha = 10^0')

text(0.0386,9.78,'A','FontSize',14,'FontWeight','Bold')

% load saved alpha values
load('alpha')

% %% plot through for high drag
% for i = 1:length(high)
%     scatter(St_a(high(i)),CTSt2_E_a(i),'b^')
%     scatter(St_d(high(i)),CTSt2_E_d(i),'bv','filled')
%     prompt = 'enter alpha estimate descent ';
%     alpha(i,1) = input(prompt);
%     prompt = 'enter alpha estimate ascent ';
%     alpha(i,2) = input(prompt);
%     scatter(St_a(high(i)),CTSt2_E_a(i),'w^')
%     scatter(St_d(high(i)),CTSt2_E_d(i),'wv','filled')
% end
% 
% %% for low drag
% for i = 1:length(low)
%     scatter(St_a(low(i)),CTSt2_DE_a(i),'k^')
%     scatter(St_d(low(i)),CTSt2_DE_d(i),'kv','filled')
%     prompt = 'enter alpha estimate descent ';
%     alpha_low(i,1) = input(prompt);
%     prompt = 'enter alpha estimate ascent ';
%     alpha_low(i,2) = input(prompt);
%     scatter(St_a(low(i)),CTSt2_DE_a(i),'w^')
%     scatter(St_d(low(i)),CTSt2_DE_d(i),'wv','filled')
% end

%% plot and with colours to distinguish harmonic vs. sawtooth

% plot all values
scatter(St_a(high),CTSt2_E_a,'b^')
scatter(St_d(high),CTSt2_E_d,'bv','filled')
scatter(St_a(low),CTSt2_DE_a,'k^')
scatter(St_d(low),CTSt2_DE_d,'kv','filled')
% plot all HIGH harmonic
ii_desc = find(alpha_high(:,1) == 109 | alpha_high(:,1) == 159);
ii_asc = find(alpha_high(:,2) == 109 | alpha_high(:,2) == 159);
scatter(St_a(high(ii_asc)),CTSt2_E_a(ii_asc),'r^')
scatter(St_d(high(ii_desc)),CTSt2_E_d(ii_desc),'rv','filled')
% % find where St > 0.4
% ii = find(St_d(high(ii_desc)) > 0.4);
% plot(St_d(high(ii_desc(ii))),CTSt2_E_d(ii_desc(ii)),'g*')
% % replace
% alpha_high(ii_desc(ii),1) = 10;
% ii = find(St_a(high(ii_asc)) > 0.4);
% plot(St_a(high(ii_asc(ii))),CTSt2_E_a(ii_asc(ii)),'g*')
% % replace
% alpha_high(ii_asc(ii),2) = 10;
%
% plot all LOW harmonic
ii_desc = find(alpha_low(:,1) == 109 | alpha_low(:,1) == 159);
ii_asc = find(alpha_low(:,2) == 109 | alpha_low(:,2) == 159);
scatter(St_a(low(ii_asc)),CTSt2_DE_a(ii_asc),'r^')
scatter(St_d(low(ii_desc)),CTSt2_DE_d(ii_desc),'rv','filled')
% % find where St > 0.4
% ii = find(St_a(low(ii_asc)) > 0.4);
% plot(St_a(low(ii_asc(ii))),CTSt2_DE_a(ii_asc(ii)),'g*')
% % replace
% alpha_low(ii_asc(ii),2) = 10;
%
% ii = find(St_d(low(ii_desc)) > 0.4);
% plot(St_d(low(ii_desc(ii))),CTSt2_DE_d(ii_desc(ii)),'g*')
% % replace
% alpha_low(ii_desc(ii),1) = 10;

% find any Ct/St > 10
% ii = find(CTSt2_E_a > 10);
% plot(St_a(high(ii)),CTSt2_E_a(ii),'k*')
% St_a(high(ii)) = NaN; CTSt2_E_a(ii) = NaN;
% ii = find(CTSt2_E_d > 10);
% plot(St_d(high(ii)),CTSt2_E_d(ii),'g*')
% St_d(high(ii)) = NaN; CTSt2_E_d(ii) = NaN;

% % find other random ones that need replacing:
% ii = find(CTSt2_E_d > 3.3 & CTSt2_E_d < 3.4);
% plot(St_d(high(ii)),CTSt2_E_d(ii),'m*')
% % Replace: make sure (ii,2) for ascent
% alpha_high(ii,1) = 159; % or 109 depending on where point falls.

% save('alpha','alpha_high','alpha_low')

%% zoom and save plot
xlim([0 1.2]); ylim([0 10])
print('Eg3911_a_estimation2.eps','-depsc','-r300')