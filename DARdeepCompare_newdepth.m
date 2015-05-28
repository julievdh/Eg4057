% DARcompare
% Compare Dive Area Ratio between different phases, between different
% animals during dives that are deeper than visually-determined threshold

% load tags
load_rw015a
load_eg047a

% find dives below different threshold for different individuals
T.rw015a = finddives(rw015a.p,fs,7);
T.eg047a = finddives(eg047a.p,fs,20);

% plot these
figure(1); clf
subplot(211); hold on
plot(rw015a.t,-rw015a.p)
plot(T.rw015a(:,1),zeros(length(T.rw015a),1),'r.')
subplot(212); hold on
plot(eg047a.t,-eg047a.p)
plot(T.eg047a(:,1),zeros(length(T.eg047a),1),'r.')

%% calculate TAD and DAR
[DAR.rw015a,TAD.rw015a] = TADindex(T.rw015a,rw015a.p,fs);
[DAR.eg047a,TAD.eg047a] = TADindex(T.eg047a,eg047a.p,fs);

%% find those during entanglement
ent.rw015a = find(T.rw015a(:,1) < rw015a.p1(2));
ent.eg047a = find(T.eg047a(:,1) < 10610);
% find those after disentanglement
disent = find(T.rw015a(:,1) > rw015a.p2(1));
% find those with even more drag
buoy = find(T.eg047a(:,1) > 10610);

figure(11); clf; hold on
bins = 0.5:0.05:0.8;
[n1,b] = hist(DAR.eg047a(ent.eg047a),bins);
[n2,b] = hist(DAR.rw015a(ent.rw015a),bins);
[n3,b] = hist(DAR.eg047a(buoy),bins);
[n4,b] = hist(DAR.rw015a(disent),bins);
subplot(211)
h = bar(b,[n2; n4]','grouped');
set(h(1),'FaceColor','k'); set(h(2),'FaceColor','b')
title('Deep 2')
subplot(212)
h = bar(b,[n1; n3]','grouped');
set(h(1),'FaceColor','k'); set(h(2),'FaceColor','r')
xlabel('Dive Area Ratio')
adjustfigurefont

%% plot all dives together
for i = 1:length(T.rw015a(ent.rw015a))
    ind = ent.rw015a(i);
[dstart,dend,ntime] = NormalizedDive(T.rw015a(ind,:),rw015a.p,fs,1,9);
end
for i = 1:length(T.rw015a(disent))
    ind = disent(i);
[dstart,dend,ntime] = NormalizedDive(T.rw015a(ind,:),rw015a.p,fs,0,9);
end
xlabel('Normalized Dive Time'); ylabel('Depth (m)')
title('Eg 3911','FontSize',14)
adjustfigurefont
%%
for i = 1:length(T.eg047a(ent.eg047a))
    ind = ent.eg047a(i);
[dstart,dend,ntime] = NormalizedDive(T.eg047a(ind,:),eg047a.p,fs,1,10);
end
for i = 1:length(T.eg047a(buoy))
    ind = buoy(i);
[dstart,dend,ntime] = NormalizedDive(T.eg047a(ind,:),eg047a.p,fs,2,10);
end
xlabel('Normalized Dive Time'); ylabel('Depth (m)')
title('Eg 4057','FontSize',14)
adjustfigurefont