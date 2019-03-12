clear all
close all

%%%%%%%%%%%%%%%
% Dispersions %
%%%%%%%%%%%%%%%

load dispersion_Si(100).dat
wl = dispersion_Si_100_(:,1);
x = dispersion_Si_100_(:,2);
y = dispersion_Si_100_(:,3);

load dispersion_SiOx.dat
wl2 = dispersion_SiOx(:,1);
x2 = dispersion_SiOx(:,2);
y2 = dispersion_SiOx(:,3);

%%%%%%%%%%%%
% Plotting %
%%%%%%%%%%%%

figure
yyaxis left
plot(wl,x)
title('Dispersion for Si(100)')
xlabel('Wavelength (nm)')
ylabel('Refractive index')
xlim([100 1100])

yyaxis right
plot(wl,y)
ylabel('Absorbtion index')


figure
yyaxis left
plot(wl2,x2)
title('Dispersion for SiOx')
xlabel('Wavelength (nm)')
ylabel('Refractive index')
xlim([100 1100])

yyaxis right
plot(wl2,y2)
ylabel('Absorbtion index')
