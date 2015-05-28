% Dive Variance Analysis

% find dives
T.rw015a = finddives(rw015a.p,fs,5);
T.eg047a = finddives(eg047a.p,fs,5);

% calculate variance below mean depth
for i = 1:length(T.rw015a)
[diveVar.rw015a(i), fullVar.rw015a(i)] = DiveVar(T.rw015a,rw015a.p,fs,i);
end
for i = 1:length(T.eg047a)
[diveVar.eg047a(i), fullVar.eg047a(i)] = DiveVar(T.eg047a,eg047a.p,fs,i);
end

%% set up times
ent.eg047a = find(T.eg047a(:,1) < 10610);
ent.rw015a = find(T.rw015a(:,1) < rw015a.p1(2));
buoy = find(T.eg047a(:,1) > 10610);
disent = find(T.rw015a(:,1) > rw015a.p2(1));

%% plot
figure(11); clf; hold on
bins = 0:2:18;
[n1,b] = hist(diveVar.eg047a(ent.eg047a),bins);
[n2,b] = hist(diveVar.rw015a(ent.rw015a),bins);
[n3,b] = hist(diveVar.eg047a(buoy),bins);
[n4,b] = hist(diveVar.rw015a(disent),bins);
subplot(211)
h = bar(b,[n2; n4]','grouped');
set(h(1),'FaceColor','k'); set(h(2),'FaceColor','b')
subplot(212)
h = bar(b,[n1; n3]','grouped');
set(h(1),'FaceColor','k'); set(h(2),'FaceColor','r')
xlabel('Variance > Mean Depth')
adjustfigurefont

% figure(12); clf; hold on
% bins = 1000:100000:900000;
% [n1,b] = hist(fullVar.eg047a(ent.eg047a),bins);
% [n2,b] = hist(fullVar.rw015a(ent.rw015a),bins);
% [n3,b] = hist(fullVar.eg047a(buoy),bins);
% [n4,b] = hist(fullVar.rw015a(disent),bins);
% subplot(211)
% h = bar(b,[n2; n4]','grouped');
% set(h(1),'FaceColor','k'); set(h(2),'FaceColor','b')
% subplot(212)
% h = bar(b,[n1; n3]','grouped');
% set(h(1),'FaceColor','k'); set(h(2),'FaceColor','r')
% xlabel('Total Depth Variance')
% adjustfigurefont