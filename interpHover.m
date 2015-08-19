function [out] = interpHover(input)
% interpolate Hover 2004 efficiency data from Figure 6 

% set range of x values based on range from figure
xq = min(input(:,1)):0.001:max(input(:,1));
% interpolate 
vq1 = interp1(input(:,1),input(:,2),xq);
% test
% plot(xq,vq1)

% combine original data with interpolated
out = vertcat(input,[xq' vq1']);
out = sortrows(out);
% plot
% plot(out(:,1),out(:,2))