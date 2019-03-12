clear all
close all


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Air_n1_5_SI(100)_Air.xy %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load Air_n1_5_SI(100)_Air.xy

x = Air_n1_5_SI_100__Air(:,1);
y = Air_n1_5_SI_100__Air(:,2);


%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = [400:1041];

%%%%%%%%%%%%%%%%%%%%
% Refractive index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1;
n_1 = 1.5;

load dispersion_Si(100).dat
disp = dispersion_Si_100_(251:1:892,:);
n_2 = transpose(disp(:,2))-1i.*transpose(disp(:,3));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d = 1000;


%%%%%%%%%%%%%%%%
% Calculations %
%%%%%%%%%%%%%%%%

r_012 = fresnel_am_tf_s(n_0,n_1,n_2,d,wavelength)

R_012 = r_012.*conj(r_012);

plot(x,y,'g',wavelength,R_012,'--k')
title([{'Fresnel reflectance equation plotted on NanoCalc simulated reflectance curve'}]')
xlabel('Wavelength (nm)')
ylabel('Reflectance (%)')
legend('Simulation','Fresnel')
