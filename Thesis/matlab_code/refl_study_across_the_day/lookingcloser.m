clear all
close all

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load daystudyreflectance
y = daystudyreflectance;

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = (400:1041);

%%%%%%%%%%%%
% Plotting %
%%%%%%%%%%%%
% inv1 = y(1,:) - y(2,:);
% inv2 = y(1,:) - y(3,:);
% inv3 = y(1,:) - y(4,:);
% inv4 = y(1,:) - y(5,:);
% inv5 = y(1,:) - y(6,:);
% inv6 = y(1,:) - y(7,:);
% inv7 = y(1,:) - y(8,:);
% inv8 = y(1,:) - y(9,:);
% inv9 = y(1,:) - y(10,:);
% inv10 = y(1,:) - y(11,:);
% inv11 = y(1,:) - y(12,:);
% inv12 = y(1,:) - y(13,:);
% inv13 = y(1,:) - y(14,:);

% figure
% plot(wavelength, inv1,wavelength, inv2,wavelength, inv3,wavelength, inv4,wavelength, inv5,wavelength, inv6,wavelength, inv6,wavelength, inv7,wavelength, inv8,wavelength, inv9,wavelength, inv10,wavelength, inv11,wavelength, inv12,wavelength, inv13)


figure('units','normalized','outerposition',[0 0 1 1])

subplot(2,1,1)
plot(wavelength,y(1,:),wavelength,y(4,:))
axis([400 1041 0 1])
title('Light source fluctuation study using polystyrene')
xlabel('Wavelength (nm)')
ylabel('Reflectance')
legend('10.47','12.19')

subplot(2,1,2)
plot(wavelength,y(1,:),wavelength,y(7,:))
axis([400 1041 0 1])
xlabel('Wavelength (nm)')
ylabel('Reflectance')
legend('10.47','13.49')

figure('units','normalized','outerposition',[0 0 1 1])

subplot(2,1,1)
plot(wavelength,y(1,:),wavelength,y(10,:))
axis([400 1041 0 1])
title('Light source fluctuation study using polystyrene')
xlabel('Wavelength (nm)')
ylabel('Reflectance')
legend('10.47','15.19')

subplot(2,1,2)
plot(wavelength,y(1,:),wavelength,y(14,:))
axis([400 1041 0 1])
xlabel('Wavelength (nm)')
ylabel('Reflectance')
legend('10.47','17.19')