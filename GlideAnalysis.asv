% Glide Analysis

% load data
load('eg047a_glides');

% if the saved data don't exist, then detect and check glides
if exist('good') == 0
    
    % calculate pitch deviation
    [~,eg047a.ph,~,~] = findflukes(eg047a.Aw,eg047a.Mw,fs,0.2,0.001,[0.7 8]);
    
    % plot pitch deviation
    figure(1); clf; hold on
    plot(eg047a.ph,'k')
    
    % hilbert transform
    hil = abs(hilbert(eg047a.ph));
    plot(hil,'b')
    plot([1 1E5],[0.04 0.04]) % threshold
    
    % find glides
    T = findglide(hil,fs,0.04);
    T = T(T(:,3) > 5*fs,:); % glides are > 5s long (Nowacek, Woodward)
    
    % plot glides
    plot(T(:,1)*fs,zeros(length(T),1)+0.04,'g*')
    plot(T(:,2)*fs,zeros(length(T),1)+0.04,'r*')
    
    % manually go through and select whether it is a glide
    for i = 1:length(T)
        % plot glide
        figure(2); clf; hold on
        plot(eg047a.ph((T(i,1)-10)*fs:(T(i,2)+10)*fs),'k')
        plot(hil((T(i,1)-10)*fs:(T(i,2)+10)*fs),'b')
        plot(10*fs,0.04,'g*')
        plot(T(i,3)+10*fs,0.04,'r*')
        good(i) = input('glide? ');
    end
    
    % save these data (cause you don't want to go through all the glides again)
    save('eg047a_glides','good','T')
end

% take only good glides
T = T(good == 1,:);

%% plot glides now!
figure(1); clf; hold on
plot(eg047a.ph,'k')
for i = 1:length(T)
    plot(T(i,1)*fs:T(i,2)*fs,eg047a.ph(T(i,1)*fs:T(i,2)*fs),'r')
end

low = find(T(:,1) > eg047a.p1(1) & T(:,1) < eg047a.p2(2));
lowrate_4057 = size(low,1)/(eg047a.p2(2)-eg047a.p1(1));
high = find(T(:,1) > eg047a.p3(1) & T(:,1) < eg047a.p3(2));
highrate_4057 = size(high,1)/(eg047a.p3(2)-eg047a.p3(1));

%% for Eg 3911

clear T good

% load data
load('rw015a_glides');

% if the saved data don't exist, then detect and check glides
if exist('good') == 0
    % calculate pitch deviation
    [~,rw015a.ph,~,~] = findflukes(rw015a.Aw,rw015a.Mw,fs,0.2,0.001,[0.7 8]);
    
    % plot pitch deviation
    figure(1); clf; hold on
    plot(rw015a.ph,'k')
    
    % hilbert transform
    hil = abs(hilbert(rw015a.ph));
    plot(hil,'b')
    plot([1 1E5],[0.04 0.04]) % threshold
    
    % find glides
    T = findglide(hil,fs,0.04);
    T = T(T(:,3) > 5*fs,:); % glides are > 5s long (Nowacek, Woodward)
    
    % plot glides
    plot(T(:,1)*fs,zeros(length(T),1)+0.04,'g*')
    plot(T(:,2)*fs,zeros(length(T),1)+0.04,'r*')
    
    % manually go through and select whether it is a glide
    for i = 1:length(T)
        % plot glide
        figure(2); clf; hold on
        plot(rw015a.ph((T(i,1)-10)*fs:(T(i,2)+10)*fs),'k')
        plot(hil((T(i,1)-10)*fs:(T(i,2)+10)*fs),'b')
        plot(10*fs,0.04,'g*')
        plot(T(i,3)+10*fs,0.04,'r*')
        good(i) = input('glide? ');
    end
    
    % save these data (cause you don't want to go through all the glides again)
    save('rw015a_glides','good','T')
end

% take only good glides
T = T(good == 1,:);

%% plot glides now!
figure(1); clf; hold on
plot(rw015a.ph,'k')
for i = 1:length(T)
    plot(T(i,1)*fs:T(i,2)*fs,rw015a.ph(T(i,1)*fs:T(i,2)*fs),'r')
end

clear low high 

low = find(T(:,1) > rw015a.p2(1) & T(:,1) < rw015a.p3(2));
lowrate_3911 = size(low,1)/(rw015a.p3(2)-rw015a.p2(1));
high = find(T(:,1) > rw015a.p1(1) & T(:,1) < rw015a.p1(2));
highrate_3911 = size(high,1)/(rw015a.p1(2)-rw015a.p1(1));
