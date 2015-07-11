% Fluke stroke symmetry

% load tag
load_rw015a

% find flukes and dives
[rw015a.v,rw015a.ph,rw015a.mx,rw015a.fr] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.3,0.01,[0.7 4]);
rw015a.T = finddives(rw015a.p,fs,5,1,0);

% load descents and ascents
load('rw015a_descasc')

%% calculate inter fluke interval and max/min points
[ifi,maxtab,mintab] = dutycycleplot([rw015a.p1(1) rw015a.p2(2)],rw015a.ph,fs); 


%%

figure(12); clf
ii = find(maxtab(:,1) > rw015a.p1(1)*fs & maxtab(:,1) < rw015a.p2(2)*fs);

ud_diff = nan(length(maxtab(ii)),50);
for i = 1:10:length(maxtab(ii));
    %%
    % % plot full stroke
    %     patchline(maxtab(ii(i),1):maxtab(ii(i+1),1),rw015a.ph(maxtab(ii(i,1)):maxtab(ii(i+1,1))),'edgecolor','k','edgealpha',0.1,'LineWidth',3)
    %     % plot half stroke down
    %     patchline(maxtab(ii(i),1):mintab(ii(i),1),rw015a.ph(maxtab(ii(i),1):mintab(ii(i),1)),'edgecolor','b','edgealpha',0.5)
    %     % plot half stroke up
    %     patchline(mintab(ii(i),1):maxtab(ii(i+1),1),rw015a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    %
    % plot half stroke return to zero
    % how long does x vecto need to be?
    need = maxtab(ii(i+1),1)-mintab(ii(i),1);
    xvec = mintab(ii(i),1):-1:mintab(ii(i),1)-need;
    %  patchline(xvec,rw015a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    
    % plot normalized
    figure(12); set(gcf,'position',[24 132 1244 500])
    subplot(221); title('High Drag')
    patchline([maxtab(ii(i),1):maxtab(ii(i+1),1)]-mintab(ii(i),1),rw015a.ph(maxtab(ii(i,1)):maxtab(ii(i+1,1))),'edgecolor','k','edgealpha',0.1,'LineWidth',3)
    % plot half stroke down
    patchline([maxtab(ii(i),1):mintab(ii(i),1)]-mintab(ii(i),1),rw015a.ph(maxtab(ii(i),1):mintab(ii(i),1)),'edgecolor','b','edgealpha',0.5)
    % plot half stroke up
    patchline([mintab(ii(i),1):maxtab(ii(i+1),1)]-mintab(ii(i),1),rw015a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
      
    down = rw015a.ph(maxtab(ii(i),1):mintab(ii(i),1)); % downstroke
    up = rw015a.ph(mintab(ii(i),1):mintab(ii(i),1)+need+1); % upstroke
    
    
    
    % make down and up the same lengths
    if length(down) > length(up)
        down_short = down(length(down)-length(up)+1:end);
        ud_diff(i,1:length(up)) = (down_short - flip(up))';
        figure(12); subplot(222); hold on; patchline(down_short,flip(up),'edgecolor','k','edgealpha',0.1)
    else if length(up) > length(down)
            up_short = up(1:length(up)-(length(up)-length(down)));
            ud_diff(i,1:length(up_short)) = (down - flip(up_short))';
            figure(12); subplot(222); hold on; patchline(down,flip(up_short),'edgecolor','k','edgealpha',0.1)
        else
            ud_diff(i,1:length(up)) = (down - flip(up))';
            figure(12); subplot(222); hold on; patchline(down,flip(up),'edgecolor','k','edgealpha',0.1)
        end
    end
    xlabel('Downstroke Deviation'); ylabel('Upstroke Deviation')
    xlim([-0.5 0.5]); ylim([-0.5 0.5]); axis equal
    plot([-1 1],[-1 1],'k')
end
 
clear ii
ii = find(maxtab(:,1) > rw015a.p3(1)*fs & maxtab(:,1) < rw015a.p3(2)*fs);

ud_diff = nan(length(maxtab(ii)),50);
for i = 1:10:length(maxtab(ii));
    % % plot full stroke
    %     patchline(maxtab(ii(i),1):maxtab(ii(i+1),1),rw015a.ph(maxtab(ii(i,1)):maxtab(ii(i+1,1))),'edgecolor','k','edgealpha',0.1,'LineWidth',3)
    %     % plot half stroke down
    %     patchline(maxtab(ii(i),1):mintab(ii(i),1),rw015a.ph(maxtab(ii(i),1):mintab(ii(i),1)),'edgecolor','b','edgealpha',0.5)
    %     % plot half stroke up
    %     patchline(mintab(ii(i),1):maxtab(ii(i+1),1),rw015a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    %
    % plot half stroke return to zero
    % how long does x vecto need to be?
    need = maxtab(ii(i+1),1)-mintab(ii(i),1);
    xvec = mintab(ii(i),1):-1:mintab(ii(i),1)-need;
    %  patchline(xvec,rw015a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    
    % plot normalized
    figure(12); set(gcf,'position',[24 132 1244 500])
    subplot(223);
    patchline([maxtab(ii(i),1):maxtab(ii(i+1),1)]-mintab(ii(i),1),rw015a.ph(maxtab(ii(i,1)):maxtab(ii(i+1,1))),'edgecolor','k','edgealpha',0.1,'LineWidth',3)
    % plot half stroke down
    patchline([maxtab(ii(i),1):mintab(ii(i),1)]-mintab(ii(i),1),rw015a.ph(maxtab(ii(i),1):mintab(ii(i),1)),'edgecolor','b','edgealpha',0.5)
    % plot half stroke up
    patchline([mintab(ii(i),1):maxtab(ii(i+1),1)]-mintab(ii(i),1),rw015a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
      
    down = rw015a.ph(maxtab(ii(i),1):mintab(ii(i),1)); % downstroke
    up = rw015a.ph(mintab(ii(i),1):mintab(ii(i),1)+need+1); % upstroke
    % make down and up the same lengths
    if length(down) > length(up)
        down_short = down(length(down)-length(up)+1:end);
        ud_diff(i,1:length(up)) = (down_short - flip(up))';
        figure(12); subplot(224); hold on; patchline(down_short,flip(up),'edgecolor','b','edgealpha',0.1)
    else if length(up) > length(down)
            up_short = up(1:length(up)-(length(up)-length(down)));
            ud_diff(i,1:length(up_short)) = (down - flip(up_short))';
            figure(12); subplot(224); hold on; patchline(down,flip(up_short),'edgecolor','b','edgealpha',0.1)
        else
            ud_diff(i,1:length(up)) = (down - flip(up))';
            figure(12); subplot(224); hold on; patchline(down,flip(up),'edgecolor','b','edgealpha',0.1)
        end
    end
    xlabel('Downstroke Deviation'); ylabel('Upstroke Deviation')
    xlim([-0.5 0.5]); ylim([-0.5 0.5]); axis equal
    plot([-1 1],[-1 1],'k')
    
    %     figure(4); hold on
    %     plot(ud_diff(i,:))
    
    
    
end

%% For Eg 4057

[ifi,maxtab,mintab] = dutycycleplot([eg047a.p1 eg047a.p2 eg047a.p3],eg047a.ph,fs); % find inter-fluke interval
% close all;

%%
figure(11); clf
ii = find(maxtab(:,1) > eg047a.p2(1)*fs & maxtab(:,1) < eg047a.p2(2)*fs);

ud_diff = nan(length(maxtab(ii)),50);
for i = 1:10:length(maxtab(ii));
    % % plot full stroke
    %     patchline(maxtab(ii(i),1):maxtab(ii(i+1),1),eg047a.ph(maxtab(ii(i,1)):maxtab(ii(i+1,1))),'edgecolor','k','edgealpha',0.1,'LineWidth',3)
    %     % plot half stroke down
    %     patchline(maxtab(ii(i),1):mintab(ii(i),1),eg047a.ph(maxtab(ii(i),1):mintab(ii(i),1)),'edgecolor','b','edgealpha',0.5)
    %     % plot half stroke up
    %     patchline(mintab(ii(i),1):maxtab(ii(i+1),1),eg047a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    %
    % plot half stroke return to zero
    % how long does x vecto need to be?
    need = maxtab(ii(i+1),1)-mintab(ii(i),1);
    xvec = mintab(ii(i),1):-1:mintab(ii(i),1)-need;
    %  patchline(xvec,eg047a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    
    % plot normalized
    figure(11); set(gcf,'position',[24 132 1244 500])
    subplot(221);
    patchline([maxtab(ii(i),1):maxtab(ii(i+1),1)]-mintab(ii(i),1),eg047a.ph(maxtab(ii(i,1)):maxtab(ii(i+1,1))),'edgecolor','k','edgealpha',0.1,'LineWidth',3)
    % plot half stroke down
    patchline([maxtab(ii(i),1):mintab(ii(i),1)]-mintab(ii(i),1),eg047a.ph(maxtab(ii(i),1):mintab(ii(i),1)),'edgecolor','b','edgealpha',0.5)
    % plot half stroke up
    patchline([mintab(ii(i),1):maxtab(ii(i+1),1)]-mintab(ii(i),1),eg047a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    
    down = eg047a.ph(maxtab(ii(i),1):mintab(ii(i),1)); % downstroke
    up = eg047a.ph(mintab(ii(i),1):mintab(ii(i),1)+need+1); % upstroke
    % make down and up the same lengths
    if length(down) > length(up)
        down_short = down(length(down)-length(up)+1:end);
        ud_diff(i,1:length(up)) = (down_short - flip(up))';
        figure(11); subplot(222); hold on; patchline(down_short,flip(up),'edgecolor','k','edgealpha',0.1)
    else if length(up) > length(down)
            up_short = up(1:length(up)-(length(up)-length(down)));
            ud_diff(i,1:length(up_short)) = (down - flip(up_short))';
            figure(11); subplot(222); hold on; patchline(down,flip(up_short),'edgecolor','k','edgealpha',0.1)
        else
            ud_diff(i,1:length(up)) = (down - flip(up))';
            figure(11); subplot(222); hold on; patchline(down,flip(up),'edgecolor','k','edgealpha',0.1)
        end
    end
    xlabel('Downstroke Deviation'); ylabel('Upstroke Deviation')
    xlim([-0.5 0.5]); ylim([-0.5 0.5]); axis equal
    plot([-1 1],[-1 1],'k')
    
end


%%
ii = find(maxtab(:,1) > eg047a.p3(1)*fs & maxtab(:,1) < eg047a.p3(2)*fs);

ud_diff = nan(length(maxtab(ii)),50);
for i = 1:10:length(maxtab(ii));
    %% % plot full stroke
    %     patchline(maxtab(ii(i),1):maxtab(ii(i+1),1),eg047a.ph(maxtab(ii(i,1)):maxtab(ii(i+1,1))),'edgecolor','k','edgealpha',0.1,'LineWidth',3)
    %     % plot half stroke down
    %     patchline(maxtab(ii(i),1):mintab(ii(i),1),eg047a.ph(maxtab(ii(i),1):mintab(ii(i),1)),'edgecolor','b','edgealpha',0.5)
    %     % plot half stroke up
    %     patchline(mintab(ii(i),1):maxtab(ii(i+1),1),eg047a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    %
    % plot half stroke return to zero
    % how long does x vecto need to be?
    need = maxtab(ii(i+1),1)-mintab(ii(i),1);
    xvec = mintab(ii(i),1):-1:mintab(ii(i),1)-need;
    %  patchline(xvec,eg047a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    
    % plot full stroke
    figure(11); set(gcf,'position',[24 132 1244 500])
    subplot(223);
    patchline([maxtab(ii(i),1):maxtab(ii(i+1),1)]-mintab(ii(i),1),eg047a.ph(maxtab(ii(i,1)):maxtab(ii(i+1,1))),'edgecolor','k','edgealpha',0.1,'LineWidth',3)
    % plot half stroke down
    patchline([maxtab(ii(i),1):mintab(ii(i),1)]-mintab(ii(i),1),eg047a.ph(maxtab(ii(i),1):mintab(ii(i),1)),'edgecolor','b','edgealpha',0.5)
    % plot half stroke up
    patchline([mintab(ii(i),1):maxtab(ii(i+1),1)]-mintab(ii(i),1),eg047a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.5)
    
    %     xvec1 = (maxtab(ii(i),1):mintab(ii(i),1))-maxtab(ii(i),1);
    %     patchline(xvec1/max(xvec1),eg047a.ph(maxtab(ii(i),1):mintab(ii(i),1)),'edgecolor','b','edgealpha',0.1)
    %     newx = xvec-xvec(1)+xvec1(end);
    %     patchline(newx/max(xvec1),eg047a.ph(mintab(ii(i),1):maxtab(ii(i+1),1)),'edgecolor','r','edgealpha',0.1)
    %     title(num2str(i))
    %     xlabel('Normalized Half Stroke Duration'); ylabel('Pitch Deviation from Mean')
    %
    down = eg047a.ph(maxtab(ii(i),1):mintab(ii(i),1)); % downstroke
    up = rw015a.ph(mintab(ii(i),1):mintab(ii(i),1)+need+1); % upstroke
    % make down and up the same lengths
    if length(down) > length(up)
        down_short = down(length(down)-length(up)+1:end);
        ud_diff(i,1:length(up)) = (down_short - flip(up))';
        figure(11); subplot(224); hold on; patchline(down_short,flip(up),'edgecolor','r','edgealpha',0.1)
    else if length(up) > length(down)
            up_short = up(1:length(up)-(length(up)-length(down)));
            ud_diff(i,1:length(up_short)) = (down - flip(up_short))';
            figure(11); subplot(224); hold on; patchline(down,flip(up_short),'edgecolor','r','edgealpha',0.1)
        else
            ud_diff(i,1:length(up)) = (down - flip(up))';
            figure(11); subplot(224); hold on; patchline(down,flip(up),'edgecolor','r','edgealpha',0.1)
        end
    end
    xlabel('Downstroke Deviation'); ylabel('Upstroke Deviation')
    xlim([-0.5 0.5]); ylim([-0.5 0.5]); axis equal
    plot([-1 1],[-1 1],'k')
    
end