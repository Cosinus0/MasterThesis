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

nm = 10^-9;
lamda = [400:1041].*nm;

%%%%%%%%%%%%%%%%%%%%
% Refractive index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1;
n_1 = 1.5;

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

r_012 = fresnel_am_tf_s(n_0,n_1,n_2,d,lamda)

R_012 = r_012.*conj(r_012);

plot(lamda,R_012,x.*nm,y)
legend('Fresnel','Simulation')
