close all

for dive = 1:length(rw015a.T)
figure(1); hold on

plot(-rw015a.p(rw015a.T(dive,1)*fs:rw015a.T(dive,2)*fs)) % plot dive
plot(end_desc(dive),-rw015a.p(rw015a.T(dive,1)*fs+end_desc(dive)),'k*')
plot(start_asc(dive),-rw015a.p(rw015a.T(dive,1)*fs+start_asc(dive)),'k*')
plot(rw015a.ph(rw015a.T(dive,1)*fs:rw015a.T(dive,2)*fs)) % plot pitch during dive

% plot descent and ascent only
plot(-rw015a.p(rw015a.T(dive,1)*fs+start_asc(dive):rw015a.T(dive,2)*fs),'r')
plot(-rw015a.p(rw015a.T(dive,1)*fs:rw015a.T(dive,1)*fs+end_desc(dive)),'r')

% find maxtab within descent and ascent
fs_desc = find(maxtab(:,1) > rw015a.T(dive,1)*fs & maxtab(:,1) <rw015a.T(dive,1)*fs+end_desc(dive));
fs_asc = find(maxtab(:,1) > rw015a.T(dive,1)*fs+start_asc(dive) & maxtab(:,1) < rw015a.T(dive,2)*fs);

ii = fs_desc;

ud_diff = nan(length(maxtab(ii)),50);
for i = 1:2:length(maxtab(ii)); % every second one
    %%
    % % plot full stroke
    %     patchline(maxtab(ii(i),1):maxtab(ii(i+1),1),rw015a.ph(maxtab(ii(i,1)):maxtab(ii(i+1,1))),'edgecolor','k','edgealpha',0.1,'LineWidth',3)
    %     % plot half stroke down
    %     patchline(maxtab(ii(i),1):mintab(ii(i),1),rw015a.ph(maxtab(ii(i),1):mintab(ii(i),1)),'edgecolor','b','edgealpha',0.5)
    %     % plot half stroke up
    %     patchline(mintab(ii(i),1):maxtab(ii(i+1),1),rw015a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    %
    % plot half stroke return to zero
    % how long does x vector need to be?
    need = maxtab(ii(i)+1,1)-mintab(ii(i),1);
    xvec = mintab(ii(i),1):-1:mintab(ii(i),1)-need;
    %  patchline(xvec,rw015a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    
    % plot normalized
    figure(12); set(gcf,'position',[24 132 1244 500])
    subplot(221); title('Descent')
    patchline([maxtab(ii(i),1):maxtab(ii(i)+1,1)]-mintab(ii(i),1),rw015a.ph(maxtab(ii(i,1)):maxtab(ii(i)+1,1)),'edgecolor','k','edgealpha',0.1,'LineWidth',3)
    % plot half stroke down
    patchline([maxtab(ii(i),1):mintab(ii(i),1)]-mintab(ii(i),1),rw015a.ph(maxtab(ii(i),1):mintab(ii(i),1)),'edgecolor','b','edgealpha',0.5)
    % plot half stroke up
    patchline([mintab(ii(i),1):maxtab(ii(i)+1,1)]-mintab(ii(i),1),rw015a.ph(mintab(ii(i),1):maxtab(ii(i)+1,1)),'edgecolor','r','edgealpha',0.5)
      
    down = rw015a.ph(maxtab(ii(i),1):mintab(ii(i),1)); % downstroke
    up = rw015a.ph(mintab(ii(i),1):mintab(ii(i),1)+need+1); % upstroke
    
    ylim([-1 1])
    
    % set colour based on high/low drag
    if dive <= 17
        col = [0 0 1];
    else col = [0 0 0];
    end
    
    % make down and up the same lengths
    if length(down) > length(up)
        down_short = down(length(down)-length(up)+1:end);
        ud_diff(i,1:length(up)) = (down_short - flip(up))';
        figure(12); subplot(222); hold on; patchline(down_short,flip(up),'edgecolor',col,'edgealpha',0.1)
    else if length(up) > length(down)
            up_short = up(1:length(up)-(length(up)-length(down)));
            ud_diff(i,1:length(up_short)) = (down - flip(up_short))';
            figure(12); subplot(222); hold on; patchline(down,flip(up_short),'edgecolor',col,'edgealpha',0.1)
        else
            ud_diff(i,1:length(up)) = (down - flip(up))';
            figure(12); subplot(222); hold on; patchline(down,flip(up),'edgecolor',col,'edgealpha',0.1)
        end
    end
    xlabel('Downstroke Deviation'); ylabel('Upstroke Deviation')
    xlim([-0.5 0.5]); ylim([-0.5 0.5]); axis equal
    plot([-1 1],[-1 1],'k')
    
end
 

%% 
ii = fs_asc;

ud_diff = nan(length(maxtab(ii)),50);
for i = 1:length(maxtab(ii));
    % % plot full stroke
    %     patchline(maxtab(ii(i),1):maxtab(ii(i+1),1),rw015a.ph(maxtab(ii(i,1)):maxtab(ii(i+1,1))),'edgecolor','k','edgealpha',0.1,'LineWidth',3)
    %     % plot half stroke down
    %     patchline(maxtab(ii(i),1):mintab(ii(i),1),rw015a.ph(maxtab(ii(i),1):mintab(ii(i),1)),'edgecolor','b','edgealpha',0.5)
    %     % plot half stroke up
    %     patchline(mintab(ii(i),1):maxtab(ii(i+1),1),rw015a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    %
    % plot half stroke return to zero
    % how long does x vecto need to be?
    need = maxtab(ii(i)+1,1)-mintab(ii(i),1);
    xvec = mintab(ii(i),1):-1:mintab(ii(i),1)-need;
    %  patchline(xvec,rw015a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    
    % plot normalized
    figure(12); set(gcf,'position',[24 132 1244 500])
    subplot(223); title('Ascent')
    patchline([maxtab(ii(i),1):maxtab(ii(i)+1,1)]-mintab(ii(i),1),rw015a.ph(maxtab(ii(i,1)):maxtab(ii(i)+1,1)),'edgecolor','k','edgealpha',0.1,'LineWidth',3)
    % plot half stroke down
    patchline([maxtab(ii(i),1):mintab(ii(i),1)]-mintab(ii(i),1),rw015a.ph(maxtab(ii(i),1):mintab(ii(i),1)),'edgecolor','b','edgealpha',0.5)
    % plot half stroke up
    patchline([mintab(ii(i),1):maxtab(ii(i)+1,1)]-mintab(ii(i),1),rw015a.ph(mintab(ii(i),1):maxtab(ii(i)+1),1),'edgecolor','r','edgealpha',0.5)
    
    ylim([-1 1])
    
    down = rw015a.ph(maxtab(ii(i),1):mintab(ii(i),1)); % downstroke
    up = rw015a.ph(mintab(ii(i),1):mintab(ii(i),1)+need+1); % upstroke
    % make down and up the same lengths
    if length(down) > length(up)
        down_short = down(length(down)-length(up)+1:end);
        ud_diff(i,1:length(up)) = (down_short - flip(up))';
        figure(12); subplot(224); hold on; patchline(down_short,flip(up),'edgecolor',col,'edgealpha',0.1)
    else if length(up) > length(down)
            up_short = up(1:length(up)-(length(up)-length(down)));
            ud_diff(i,1:length(up_short)) = (down - flip(up_short))';
            figure(12); subplot(224); hold on; patchline(down,flip(up_short),'edgecolor',col,'edgealpha',0.1)
        else
            ud_diff(i,1:length(up)) = (down - flip(up))';
            figure(12); subplot(224); hold on; patchline(down,flip(up),'edgecolor',col,'edgealpha',0.1)
        end
    end
    xlabel('Downstroke Deviation'); ylabel('Upstroke Deviation')
    xlim([-0.5 0.5]); ylim([-0.5 0.5]); axis equal
    plot([-1 1],[-1 1],'k')  
    
end

end
