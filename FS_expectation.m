% STROKE EXPECTATION

% what do different strokes look like and what do we expect? 

%% equal upstroke and downstroke
% make data
downx = 0:12; 
downy = [0.101816459079515;0.101545443005913;0.0908208264168652;...
    0.0747919440142817;0.0538283411710264;0.0315051320492651;...
    0.0104699903883109;-0.0117576100318742;-0.0353408616048715;...
    -0.0598103073506884;-0.0826227967240054;-0.0951138511625120;...
    -0.0960095136452938];
upx = 12:-1:0;
upy = flipud(downy);
fs = 5; % maybe remove this?

% plot
figure(2); set(gcf,'position',[71 226 978 394]); clf
% THROUGH TIME
subplot(131); hold on
plot(downx/fs,downy,'b')
plot((downx+12)/fs,upy,'r')
xlabel('Time (sec)'); ylabel('Pitch Deviation (deg)')

% OVERLAYED
subplot(132); hold on
patchline((downx-downx(end))/fs,downy,'edgecolor','b','edgealpha',0.5)
patchline((upx-upx(1))/fs,upy,'edgecolor','r','edgealpha',0.5)
xlabel('Time (sec)'); ylabel('Pitch Deviation (deg)')

% DEVIATION
subplot(133); hold on
plot(downy,flipud(upy),'k')
xlim([-.2 .2]); ylim([-.2 .2])
xlabel('Downstroke Position'); ylabel('Upstroke Position')

% %% same shape
% downx = 0:9; 
% downy = [0.163847440028824;0.161807463535088;0.138941364011919;...
%     0.0967763322761938;0.0475187774730079;0.000526690204396586;...
%     -0.0377117417063299;-0.0665332694647288;-0.0902697506550811;...
%     -0.104351673730929];
% upx = 9:-1:-1;
% upy = [-0.104351673730929;-0.101060310872823;-0.0863962703644158;-0.0658234476682039;-0.0348994915693063;0.00576349924835434;0.0514811182717512;0.0987725691683427;0.139185147053790;0.165397937025817;0.174747121696217];
% 
% % THROUGH TIME
% figure(2); 
% subplot(131); hold on
% plot(downx,downy,'b')
% plot(9:19,upy,'r')
% 
% % OVERLAYED
% subplot(132); hold on
% plot(downx,downy,'b')
% plot(upx,upy,'r')
% 
% % DEVIATION
% subplot(133); hold on
% plot(downy(1:length(downx)),upy(1:length(downx)),'k')
% xlim([-.2 .2]); ylim([-.2 .2])

%% downstroke stronger than upstroke
% want to have same amplitude 
downx = 0:7;
downy = [0.09813774986220460;0.0721532623085626;0.0465551326638748;0.0132201561395104;-0.0190445078281062;-0.0482797431347104;-0.0719155934421165;-0.0919364476636020];
upx = 7:-1:-7;
upy = [-0.09820906432748538;-0.09506286549707602;-0.08762426900584795;...
    -0.073947368421053;-0.0645467836257310;-0.0499269005847953;...
    -0.0345760233918129;-0.0133771929824561;0.0114766081871345;...
    0.0399853801169591;0.0531432748538012;0.06771929824561;...
    0.0787; 0.0834; 0.0904];

% THROUGH TIME
subplot(131)
plot((downx)/fs,downy,'b--')
plot((7:21)/fs,upy,'r--')
ylim([-0.12 0.12])

% OVERLAYED
subplot(132)
plot((downx-downx(end))/fs,downy,'b--')
plot((upx-upx(1))/fs,upy,'r--')
ylim([-0.12 0.12])

% DEVIATION
subplot(133)
plot(downy(1:length(downx)),flipud(upy(1:length(downx))),'k--')
xlim([-.2 .2]); ylim([-.2 .2])



% %% upstroke stronger than downstroke
% downx = 0:16;
% downy = [0.0753420258071424;0.0743025017948203;0.0672110653156623;0.0585088407393991;0.0562665589540546;0.0506894832676073;0.0352596492853526;0.0169542016219108;0.00284566976757769;-0.00477379236355504;-0.0143954812444353;-0.0305287850961264;-0.0461209340248310;-0.0613458925500460;-0.0867357578483866;-0.112181164594956;-0.112638191094222];
% upx = 16:-1:8;
% upy = [-0.112638191094222;-0.0981417976342911;-0.0749437935402308;-0.0170912571991557;0.0861084858527020;0.257358250158189;0.453882798051257;0.540492227078605;0.501850634475790];
% 
% % THROUGH TIME
% subplot(131)
% plot(downx,downy,'b:')
% plot(16:16+8,upy,'r:')
% 
% % OVERLAYED
% subplot(132)
% plot(downx,downy,'b:')
% plot(upx,upy,'r:')
% 
% % DEVIATION
% subplot(133); 
% plot(downy(1:length(upx)),flipud(upy),'k:')
% xlim([-.2 .4]); ylim([-.2 .4])


%% try one more (should be ABOVE the line)
downx = (0:1:13)/(fs/1.25);
downy = [0.0993;0.0982;0.0892;0.0638107290045169;0.0423761850775371;0.0191648688283585;-0.00808359492574893;-0.029284363261507;-0.04309;-0.0587598749185;-0.071;-0.0823110441728800;-0.0952;-0.0994];
upx = (13:13+13)/(fs/0.65)+1.45;
upy = [-0.1012754205098862;-0.09923967013243;-0.0753719184443976;-0.0591259690622049;-0.0373978937522058;-0.0192652893001632;0.00244060828502576;0.0247558668000754;0.0450283622561640;0.0616848601308887;0.0756386420620984;0.0867532400847642;0.0926481638650162;0.0853454615506130];

% THROUGH TIME
subplot(131); hold on
plot(downx,downy,'b:')
plot((13:13+13)/(fs/0.65)+1.45,upy,'r:') 

text(0.42,0.13,'A','FontWeight','bold','FontSize',20)

% OVERLAYED
subplot(132)
plot((downx-downx(end)),downy,'b:')
plot(-upx+upx(1),upy,'r:')

text(-2.79,0.13,'B','FontWeight','bold','FontSize',20)

% DEVIATION
subplot(133); 
plot(downy(1:length(upx)),flipud(upy),'k:')
xlim([-.1 .1]); ylim([-.1 .15])

text(-0.085,0.13,'C','FontWeight','bold','FontSize',20)

adjustfigurefont

cd C:\Users\Julie\Documents\MATLAB\Eg4057\AnalysisFigs
print('FSexpectation','-dtiff')