function [D,range] = EstDrag(lnth,float)

% Calculates mean drag (N) based on length of gear (m) and whether or not
% floats attached (binomial; 1 0)
% Mean across speeds and depths

D = 8.67+0.47*lnth + 39.26*float + 0.01*lnth*float;
% lower and upper estimates based on Normalized RMSE = RMSE/ymax-ymin = 14%
range(1) = D*1.07;
range(2) = D*0.93;

end
