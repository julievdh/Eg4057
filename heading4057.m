% Eg 4057 Heading
% trailing gear was always on the left side of the animal
% are there consistent offsets in the heading of the animal to account for
% this?

load_eg047a

% calculate heading over low and high drag periods
head_low1 = eg047a.head(eg047a.p1(1)*fs:eg047a.p1(2)*fs);
head_low2 = eg047a.head(eg047a.p2(1)*fs:eg047a.p2(2)*fs);
head_low = vertcat(head_low1, head_low2);
head_high = eg047a.head(eg047a.p3(1)*fs:eg047a.p3(2)*fs);

%% plot
figure(1); clf; 
subplot(121)
h = rose(head_low);
x = get(h,'Xdata');
y = get(h,'Ydata');
g=patch(x,y,'k');
title('Low Drag')

subplot(122)
h = rose(head_high);
x = get(h,'Xdata');
y = get(h,'Ydata');
g=patch(x,y,'b');
title('High Drag')


cd C:\Users\Julie\Documents\MATLAB\Eg4057\AnalysisFigs
print('Heading4057','-dtiff')
