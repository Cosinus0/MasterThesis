clear all
close all


%%%%%%%%%%%%%%%%%%%%%%
% Air_SI(100)_Air.xy %
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load Air_SI(100)_Air.xy

x = Air_SI_100__Air(:,1);
y = Air_SI_100__Air(:,2);


%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = [400:1041];

%%%%%%%%%%%%%%%%%%%%
% Refractive index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1;

load dispersion_Si(100).dat
disp = dispersion_Si_100_(251:1:892,:);
n_1 = transpose(disp(:,2))-1i.*transpose(disp(:,3));



%%%%%%%%%%%%%%%%
% Calculations %
%%%%%%%%%%%%%%%%

r_01 = fresnel_am_s(n_0,n_1)

R_01 = r_01.*conj(r_01);

plot(x,y,'g',wavelength,R_01,'--k')
title([{'Fresnel reflectance equation plotted on NanoCalc simulated reflectance curve'}])
xlabel('Wavelength(nm)')
ylabel('Reflectance(%)')
legend('Simulation','Fresnel')
