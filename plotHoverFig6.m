% plotHoverFig6: plot data from Hover fog 6 for harmonic and sawtooth

load('Hover2004_Fig6')

figure(7); clf; hold on
h = plot(a10_harmonic(:,1),a10_harmonic(:,2),a15_harmonic(:,1),a15_harmonic(:,2));
set(h,'color','k');
h = plot(a10_sawtooth(:,1),a10_sawtooth(:,2),a15_sawtooth(:,1),a15_sawtooth(:,2),...
    a20_sawtooth(:,1),a20_sawtooth(:,2),a25_sawtooth(:,1),a25_sawtooth(:,2),...
    a30_sawtooth(:,1),a30_sawtooth(:,2),a35_sawtooth(:,1),a35_sawtooth(:,2));
set(h,'color',[0.75 0.75 0.75])

xlabel('Strouhal Number, St'); ylabel('\eta')

%% interpolate points
a10_harmonic_i = interpHover(a10_harmonic);
a15_harmonic_i = interpHover(a15_harmonic);

a10_sawtooth_i = interpHover(a10_sawtooth);
a15_sawtooth_i = interpHover(a15_sawtooth);
a20_sawtooth_i = interpHover(a20_sawtooth);
a25_sawtooth_i = interpHover(a25_sawtooth);
a30_sawtooth_i = interpHover(a30_sawtooth);
a35_sawtooth_i = interpHover(a35_sawtooth);