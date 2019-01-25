clear all
close all


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Air_Cauchy_SI(100)_Air2.xy %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load Air_Cauchy_SI(100)_Air_2.xy

x = Air_Cauchy_SI_100__Air_2(:,1);
y = Air_Cauchy_SI_100__Air_2(:,2);


%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

nm = 10^-9;
wavelength = [400:1041]; 
lamda = [400:1041].*nm;

%%%%%%%%%%%%%%%%%%%%
% Refractive index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1;
A = 1.4450;
%B = 0;
B = 3e4;
%C = 0;
C = 4e7;
n_1 = cauchy(wavelength,A,B,C); %Dont not use lamda in nanometers.

load dispersion_Si(100).dat
disp = dispersion_Si_100_(251:1:892,:);
n_2 = transpose(disp(:,2));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d = 1000.*nm;


%%%%%%%%%%%%%%%%
% Calculations %
%%%%%%%%%%%%%%%%

r_012 = fresnel_am_tf_s(n_0,n_1,n_2,d,lamda);

R_012 = r_012.*conj(r_012);

plot(lamda,R_012,x.*nm,y)
legend('Fresnel','Simulation')
