clear all
close all


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Air_Cauchy_SiOx_SI(100).xy %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load Air_Cauchy_SiOx(2nm)_SI.xy

x = Air_Cauchy_SiOx_2nm__SI(:,1);
y = Air_Cauchy_SiOx_2nm__SI(:,2);


%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = [400:1041]; 

%%%%%%%%%%%%%%%%%%%%
% Refractive index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1;

A = 1.4450;
B = 3e4;
C = 4e7;
n_1 = cauchy(wavelength,A,B,C);

load dispersion_SiOx.dat
disp1 = dispersion_SiOx(251:1:892,:);
n_2 = transpose(disp1(:,2))-1i.*transpose(disp1(:,3));

load dispersion_Si(100).dat
disp2 = dispersion_Si_100_(251:1:892,:);
n_3 = transpose(disp2(:,2))-1i.*transpose(disp2(:,3));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d1 = 1000;
d2 = 2;

%%%%%%%%%%%%%%%%
% Calculations %
%%%%%%%%%%%%%%%%

r_0123 = fresnel_am_tf_lay_sub(n_0,n_1,n_2,n_3,d1,d2,wavelength);

R_0123 = r_0123.*conj(r_0123);

plot(x,y,'g',wavelength,R_0123,'--k')
title([{'Fresnel reflectance equation plotted on NanoCalc simulated reflectance curve'}])
xlabel('Wavelength(nm)')
ylabel('Reflectance(%)')
legend('Simulation','Fresnel')
