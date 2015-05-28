% g-spheres
% see Grundy et al 2009


% load in data
load_eg047a
load_rw015a

%% plot 3D body orientation 
figure(10); clf; hold on
plot3(rw015a.Aw(rw015a.p1(1)*fs:rw015a.p1(2)*fs,2),rw015a.Aw(rw015a.p1(1)*fs:rw015a.p1(2)*fs,1),rw015a.Aw(rw015a.p1(1)*fs:rw015a.p1(2)*fs,3),'r.')
plot3(rw015a.Aw(rw015a.p2(1)*fs:rw015a.p2(2)*fs,2),rw015a.Aw(rw015a.p2(1)*fs:rw015a.p2(2)*fs,1),rw015a.Aw(rw015a.p2(1)*fs:rw015a.p2(2)*fs,3),'b.')
plot3(rw015a.Aw(rw015a.p3(1)*fs:rw015a.p3(2)*fs,2),rw015a.Aw(rw015a.p3(1)*fs:rw015a.p3(2)*fs,1),rw015a.Aw(rw015a.p3(1)*fs:rw015a.p3(2)*fs,3),'k.')
axis square
view(43,12); xlabel('x'); ylabel('y'); zlabel('z')

figure(11); clf; hold on
plot3(eg047a.Aw(eg047a.p1(1)*fs:eg047a.p1(2)*fs,2),eg047a.Aw(eg047a.p1(1)*fs:eg047a.p1(2)*fs,1),eg047a.Aw(eg047a.p1(1)*fs:eg047a.p1(2)*fs,3),'k.')
plot3(eg047a.Aw(eg047a.p2(1)*fs:eg047a.p2(2)*fs,2),eg047a.Aw(eg047a.p2(1)*fs:eg047a.p2(2)*fs,1),eg047a.Aw(eg047a.p2(1)*fs:eg047a.p2(2)*fs,3),'b.')
plot3(eg047a.Aw(eg047a.p3(1)*fs:eg047a.p3(2)*fs,2),eg047a.Aw(eg047a.p3(1)*fs:eg047a.p3(2)*fs,1),eg047a.Aw(eg047a.p3(1)*fs:eg047a.p3(2)*fs,3),'r.')
axis square
view(43,12); xlabel('x'); ylabel('y'); zlabel('z')

%% cartesian to polar coordinates and use depth information
% convert cartesian to polar
[theta,rho,z] = cart2pol(rw015a.Aw(rw015a.p1(1)*fs:rw015a.p1(2)*fs,2),rw015a.Aw(rw015a.p1(1)*fs:rw015a.p1(2)*fs,1),rw015a.Aw(rw015a.p1(1)*fs:rw015a.p1(2)*fs,3));
z = rw015a.p(rw015a.p1(1)*fs:rw015a.p1(2)*fs)/max(rw015a.p); % depth normalized over entire deployment
% transform back
[x,y,z] = pol2cart(theta,rho,z);
figure(1); clf; hold on
plot3(x,y,z)

[theta2,rho2,z2] = cart2pol(rw015a.Aw(rw015a.p2(1)*fs:rw015a.p2(2)*fs,2),rw015a.Aw(rw015a.p2(1)*fs:rw015a.p2(2)*fs,1),rw015a.Aw(rw015a.p2(1)*fs:rw015a.p2(2)*fs,3));
z2 = rw015a.p(rw015a.p2(1)*fs:rw015a.p2(2)*fs)/max(rw015a.p); % depth normalized over entire deployment
% transform back
[x2,y2,z2] = pol2cart(theta2,rho2,z2);
plot3(x2,y2,z2,'r')

[theta3,rho3,z3] = cart2pol(rw015a.Aw(rw015a.p3(1)*fs:rw015a.p3(2)*fs,2),rw015a.Aw(rw015a.p3(1)*fs:rw015a.p3(2)*fs,1),rw015a.Aw(rw015a.p3(1)*fs:rw015a.p3(2)*fs,3));
z3 = rw015a.p(rw015a.p3(1)*fs:rw015a.p3(2)*fs)/max(rw015a.p); % depth normalized over entire deployment
% transform back
[x3,y3,z3] = pol2cart(theta3,rho3,z3);
plot3(x3,y3,z3,'k')

view(75,7)
ylabel('Normalized Depth')

%%

% % depth vs. acceleration
% figure; set(gcf,'position',[3 378 1597 420])
% subplot(131); hold on
% plot(eg047a.p(eg047a.p1(1):eg047a.p1(2),1),eg047a.pitch(eg047a.p1(1):eg047a.p1(2)))
% plot(eg047a.p(eg047a.p2(1):eg047a.p2(2),1),eg047a.pitch(eg047a.p2(1):eg047a.p2(2)),'r')
% plot(eg047a.p(eg047a.p3(1):eg047a.p3(2),1),eg047a.pitch(eg047a.p3(1):eg047a.p3(2)),'k')
% xlabel('Depth (m)'); ylabel('Pitch')
% 
% subplot(132); hold on
% plot(eg047a.p(eg047a.p1(1):eg047a.p1(2),1),eg047a.roll(eg047a.p1(1):eg047a.p1(2)))
% plot(eg047a.p(eg047a.p2(1):eg047a.p2(2),1),eg047a.roll(eg047a.p2(1):eg047a.p2(2)),'r')
% plot(eg047a.p(eg047a.p3(1):eg047a.p3(2),1),eg047a.roll(eg047a.p3(1):eg047a.p3(2)),'k')
% xlabel('Depth (m)'); ylabel('Roll')
% 
% subplot(133); hold on
% plot(eg047a.p(eg047a.p1(1):eg047a.p1(2),1),eg047a.head(eg047a.p1(1):eg047a.p1(2)))
% plot(eg047a.p(eg047a.p2(1):eg047a.p2(2),1),eg047a.head(eg047a.p2(1):eg047a.p2(2)),'r')
% plot(eg047a.p(eg047a.p3(1):eg047a.p3(2),1),eg047a.head(eg047a.p3(1):eg047a.p3(2)),'k')
% xlabel('Depth (m)'); ylabel('Heading')