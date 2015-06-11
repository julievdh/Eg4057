% click descent and ascent
% find dives
rw015a.T = finddives(rw015a.p,fs,5,1,0);

for i = 1:length(rw015a.T)
    clf
    plot(-rw015a.p(rw015a.T(i,1)*fs:rw015a.T(i,2)*fs)) % plot dive 
    ginput(2) % select end of descent and beginning of ascent
    end_desc(:,i) = floor(ans(1)); % round to get indices
    start_asc(:,i) = ceil(ans(2));
    
    % plot to check
    hold on
    plot(end_desc(i),-rw015a.p(rw015a.T(i,1)*fs+end_desc(i)),'k*')
    plot(start_asc(i),-rw015a.p(rw015a.T(i,1)*fs+start_asc(i)),'k*')
end

save('rw015a_descasc','end_desc','start_asc')

%% 
eg047a.T = finddives(eg047a.p,fs,5,1,0);

for i = 1:length(eg047a.T)
    clf
    plot(-eg047a.p(eg047a.T(i,1)*fs:eg047a.T(i,2)*fs)) % plot dive 
    ginput(2) % select end of descent and beginning of ascent
    end_desc(:,i) = floor(ans(1)); % round to get indices
    start_asc(:,i) = ceil(ans(2));
    
    % plot to check
    hold on
    plot(end_desc(i),-eg047a.p(eg047a.T(i,1)*fs+end_desc(i)),'k*')
    plot(start_asc(i),-eg047a.p(eg047a.T(i,1)*fs+start_asc(i)),'k*')
end

save('eg047a_descasc','end_desc','start_asc')
