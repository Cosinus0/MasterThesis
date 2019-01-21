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

nm = 10^-9;
lamda = [400:1041].*nm;

%%%%%%%%%%%%%%%%%%%%
% Refractive index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1;

load dispersion_Si(100).dat
disp = dispersion_Si_100_(251:1:892,:);
n_1 = transpose(disp(:,2));


%%%%%%%%%%%%%%%%
% Calculations %
%%%%%%%%%%%%%%%%

r_01 = fresnel_am_s(n_0,n_1)

R_01 = r_01.*conj(r_01);

plot(lamda,R_01,x.*nm,y)
