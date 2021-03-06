clear all
close all

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

nm = 10^-9;
lamda = [400:1041].*nm;

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load Air_Si(100)_n1_5(450nm)_Air.xy

x = Air_Si_100__n1_5_450nm__Air(:,1);
y = Air_Si_100__n1_5_450nm__Air(:,2);

%%%%%%%%%%%%%%%%%%%%
% Reflective Index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1;
n_1 = 1.5;

load dispersion_Si(100).dat
disp = dispersion_Si_100_(251:1:892,:);
n_2 = transpose(disp(:,2));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d = 450.*nm;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reflectance Calculations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r_012 = fresnel_am_tf_s(n_0,n_1,n_2,d,lamda);

R_012 = r_012.*conj(r_012);

plot(lamda.*10^9,R_012,x,y)
title('Fresnel Reflectance vs. Nanocalc Simulation Reflectance')
xlabel('Wavelength nm')
ylabel('Reflectance')
legend('Fresnel','Simulation')