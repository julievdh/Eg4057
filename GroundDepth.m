% depth waypoints for Eg 4057 and Eg 3911

% load ground data
cd C:\Users\Julie\Documents\MATLAB\Eg4057\
load('ground_4057')
load('ground_3911')

% calculate time cues for 4057
tagstart = [2014 2 16 15 42 10];
for i = 1:length(ground_4057)
ground_4057(i,9) = etime(datevec(ground_4057(i,7)),tagstart);
end

% calculate time cues for 3911
tagstart = [2011 1 15 10 4 18];
for i = 1:length(ground_3911)
ground_3911(i,9) = etime(datevec(ground_3911(i,7)),tagstart);
end

clear tagstart