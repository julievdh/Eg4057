% load in Barber GPS data
load('eg047a_BarberGPS')

% plot Barber GPS data
figure(1); clf; hold on
plot(longitude,latitude)
plot(longitude(2),latitude(2),'go',longitude(end),latitude(end),'ro')
xlabel('Longitude'); ylabel('Latitude')

% find TAGON time
% make datenum
Date = datenum([Year Month Day Hour+12 Minute Second]);
% tagon datenum
TAGON = datenum([2014 02 16 15 42 0]);
% find same values
TAGONidx = find(Date == TAGON);
% Note: samples at 0.33 Hz so end up with 20 points per minute

% plot TAGON time
plot(longitude(TAGONidx),latitude(TAGONidx),'co')

% plot focal follow data
load('eg047a_SurfTimes')

% plot lats and lons of ups and downs
plot(Lonup,Latup,'g^',Londown,Latdown,'rv')

% find datenum of surfacing and dive times
for i = 1:length(UP)
    up(:,i) = datenum([str2num(UP{i}) 0]);
    down(:,i) = datenum([str2num(DOWN{i}) 0]);
    % find indices
    upidx_ = find(Date == up(i));
    upidx(i) = upidx_(1);
    downidx_ = find(Date == down(i));
    downidx(i) = downpidx_(1);
end

% calculate distance between points during up period, every second
for j = 1:length(upidx)
for i = upidx(j):20:downidx(j)-1
    clear arclen
arclen(:,i) = distance(latitude(i),longitude(i),latitude(i+1),longitude(i+1));
end
arclen(arclen == 0) = NaN;
arclen = deg2km(arclen)*100; % convert from degrees to m
mnspeed(j) = nanmean(arclen); % average speed per second during up period
end



