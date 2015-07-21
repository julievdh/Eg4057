% Eg 4057 Heading
% trailing gear was always on the left side of the animal
% are there consistent offsets in the heading of the animal to account for
% this?

load_eg047a

% calculate heading over low and high drag periods
% heading from tag is heading in radians (computed in m2h)
head_low1 = eg047a.head(eg047a.p1(1)*fs:eg047a.p1(2)*fs);
head_low2 = eg047a.head(eg047a.p2(1)*fs:eg047a.p2(2)*fs);
head_low = vertcat(head_low1, head_low2);
head_high = eg047a.head(eg047a.p3(1)*fs:eg047a.p3(2)*fs);

%% plot
figure(1); clf; 
subplot(121)
% angles for rose must be in radians. head is in radians.
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


%% Descriptive Circular Statistics
figure(2)
subplot(2,2,1)
circ_plot(head_low,'pretty','bo',true,'linewidth',2,'color','r');

subplot(2,2,3)
circ_plot(head_low,'hist',[],[],true,true,'linewidth',2,'color','r');

subplot(2,2,2)
circ_plot(head_high,'pretty','bo',true,'linewidth',2,'color','r');

subplot(2,2,4)
circ_plot(head_high,'hist',[],20,true,true,'linewidth',2,'color','r');

%% Descriptive Stats
fprintf('\t\t\t\t\t\tLOW\tHIGH\n')

low_bar = circ_mean(head_low);
high_bar = circ_mean(head_high);

fprintf('Mean resultant vector:\t%.2f \t%.2f\n', circ_rad2ang([low_bar high_bar]))

% low_hat = circ_median(head_low);
% high_hat = circ_median(head_high);
% 
% fprintf('Median:\t\t\t\t\t%.2f \t%.2f\n', circ_rad2ang([low_hat high_hat]))

R_low = circ_r(head_low);
R_high = circ_r(head_high);

fprintf('R Length:\t\t\t\t\t%.2f \t%.2f\n',[R_low R_high])

S_low = circ_var(head_low);
S_high = circ_var(head_high);

fprintf('Variance:\t\t\t\t%.2f \t%.2f\n',[S_low S_high])

[s_low s0_low] = circ_std(head_low);
[s_high s0_high] = circ_std(head_high);

fprintf('Standard deviation:\t\t%.2f \t%.2f\n',[s_low s_high])
fprintf('Standard deviation 0:\t%.2f \t%.2f\n',[s0_low s0_high])

b_low = circ_skewness(head_low);
b_high = circ_skewness(head_high);

fprintf('Skewness:\t\t\t\t%.2f \t%.2f\n',[b_low b_high])

k_low = circ_kurtosis(head_low);
k_high = circ_kurtosis(head_high);

fprintf('Kurtosis:\t\t\t\t%.2f \t%.2f\n',[k_low k_high])

fprintf('\n\n')

%% Test Distributions
% Watson-Williams Test
p = circ_wwtest(head_low,head_high)

% Kuiper Test
[pval, k, K] = circ_kuipertest(head_low, head_high)
