% plotHoverFig6: plot data from Hover fog 6 for harmonic and sawtooth

load('Hover2004_Fig6')

figure(6); 
subplot(122); hold on; box on
h = plot(a10_harmonic(:,1),a10_harmonic(:,2),a15_harmonic(:,1),a15_harmonic(:,2));
set(h,'color','k');
h = plot(a10_sawtooth(:,1),a10_sawtooth(:,2),a15_sawtooth(:,1),a15_sawtooth(:,2),...
    a20_sawtooth(:,1),a20_sawtooth(:,2),a25_sawtooth(:,1),a25_sawtooth(:,2),...
    a35_sawtooth(:,1),a35_sawtooth(:,2));
set(h,'color',[0.75 0.75 0.75])
xlim([0 1.2])
text(0.42,0.5435,'\alpha = 15^0')
text(0.38,0.58,'\alpha = 10^0')
text(0.8386,0.1447,'\alpha = 10^0')
text(0.8386,0.313,'\alpha = 35^0')
text(0.8386,0.373,'\alpha = 25^0')
text(0.8386,0.35,'\alpha = 20^0')
text(0.8386,0.29,'\alpha = 15^0')

text(0.0386,0.587,'B','FontSize',14,'FontWeight','Bold')
xlabel('Strouhal Number, St'); ylabel('Propulsive Efficiency, \eta')
adjustfigurefont

%% interpolate points
a10_harmonic_i = interpHover(a10_harmonic);
a15_harmonic_i = interpHover(a15_harmonic);

a10_sawtooth_i = interpHover(a10_sawtooth);
a15_sawtooth_i = interpHover(a15_sawtooth);
a20_sawtooth_i = interpHover(a20_sawtooth);
a25_sawtooth_i = interpHover(a25_sawtooth);
a30_sawtooth_i = interpHover(a30_sawtooth);
a35_sawtooth_i = interpHover(a35_sawtooth);