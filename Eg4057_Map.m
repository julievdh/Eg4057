% set directory 
cd F:\eg14\boat_gpx
% import GPX file
route = gpxread('20140216_Barber_to_Stellwagen_to_20140217_Barber');
[latlim, lonlim] = geoquadline(route.Latitude, route.Longitude);
[latlim, lonlim] = bufgeoquad(latlim, lonlim, .05, .05);

%% build figure
fig = figure(1);
set(fig,'Position', [300 300 700 525]);
ax = usamap(latlim, lonlim);
setm(ax, 'MLabelParallel', 43.5,'LabelRotation','on','LabelUnits','dms')
geoshow(route.Latitude, route.Longitude,'color','r')

% add distances to whale/locations of sightings
% add where start and where ended
