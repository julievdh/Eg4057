% DARcompare

% load tags
load_rw015a
load_eg047a

% find dives deeper than 1.75 m
clear T
T.rw015a = finddives(rw015a.p,fs,1.75,1);
T.eg047a = finddives(eg047a.p,fs,1.75,0.5);

%% plot these
figure(1); clf
subplot(211); hold on
plot(rw015a.t,-rw015a.p)
plot(T.rw015a(:,1),zeros(length(T.rw015a),1),'r.')
subplot(212); hold on
plot(eg047a.t,-eg047a.p)
plot(T.eg047a(:,1),zeros(length(T.eg047a),1),'r.')

% plot those less than 5 m
T.rw015a = T.rw015a(T.rw015a(:,3) < 7,:);
T.eg047a = T.eg047a(T.eg047a(:,3) < 10,:);
subplot(211)
plot(T.rw015a(:,1),zeros(length(T.rw015a),1),'g.')
subplot(212)
plot(T.eg047a(:,1),zeros(length(T.eg047a),1),'g.')

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
bar(b,[n1; n2; n3; n4]','grouped')
% h = findobj(gca,'Type','patch');
% set(h(2),'FaceColor','r','EdgeColor','w','facealpha',0.5)
% set(h(3),'FaceColor','g','EdgeColor','w','facealpha',0.5)
% set(h(4),'FaceColor','y','EdgeColor','w','facealpha',0.5)
legend('Entangled','Entangled','Buoy','Disentangled','Location','NW')
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

