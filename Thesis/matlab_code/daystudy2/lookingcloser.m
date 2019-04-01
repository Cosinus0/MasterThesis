clear all
close all

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load daystudy2reflectance
y = daystudy2reflectance;

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = (400:1041);

%%%%%%%%%%%%
% Plotting %
%%%%%%%%%%%%

diff1 = y(1,:) - y(4,:);
diff2 = y(1,:) - y(7,:);
diff3 = y(1,:) - y(10,:);
diff4 = y(1,:) - y(13,:);



figure('units','normalized','outerposition',[0 0 1 1])

subplot(2,1,1)
plot(wavelength,y(1,:),wavelength,y(4,:))
axis([400 1041 0 1])
title('Light source fluctuation study using polystyrene')
xlabel('Wavelength (nm)')
ylabel('Reflectance')
legend('13:04','14:36')

subplot(2,1,2)
plot(wavelength,y(1,:),wavelength,y(7,:))
axis([400 1041 0 1])
xlabel('Wavelength (nm)')
ylabel('Reflectance')
legend('13:04','16:06')

figure('units','normalized','outerposition',[0 0 1 1])

subplot(2,1,1)
plot(wavelength,y(1,:),wavelength,y(10,:))
axis([400 1041 0 1])
title('Light source fluctuation study using polystyrene')
xlabel('Wavelength (nm)')
ylabel('Reflectance')
legend('13:04','17:36')

subplot(2,1,2)
plot(wavelength,y(1,:),wavelength,y(13,:))
axis([400 1041 0 1])
xlabel('Wavelength (nm)')
ylabel('Reflectance')
legend('13:04','19:06')

figure('units','normalized','outerposition',[0 0 1 1])
plot(wavelength,diff1,'k',wavelength,diff2,'r',wavelength,diff3,'b',wavelength,diff4,'g')
axis([400 1100 -0.1 0.2])
title('Reflectance difference at different times')
xlabel('Wavelength (nm)')
ylabel('Difference in Reflectance')
legend('13:04-14:36','13:04-16:06','13:04-17:36','13:04-19:06')
