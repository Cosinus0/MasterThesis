clear all
close all


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Air_Cauchy_SiOx_SI(100).xy %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load Air_Cauchy_SiOx(4nm)_SI.xy

x = Air_Cauchy_SiOx_4nm__SI(:,1);
y = Air_Cauchy_SiOx_4nm__SI(:,2);


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
B = 3e4;
C = 4e7;
n_1 = cauchy(wavelength,A,B,C); %Dont not use lamda in nanometers.


load dispersion_SiOx.dat
disp1 = dispersion_SiOx(251:1:892,:);
n_2 = transpose(disp1(:,2));

load dispersion_Si(100).dat
disp2 = dispersion_Si_100_(251:1:892,:);
n_3 = transpose(disp2(:,2));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d1 = 1000.*nm;
d2 = 4.*nm;

%%%%%%%%%%%%%%%%
% Calculations %
%%%%%%%%%%%%%%%%

r_0123 = fresnel_am_tf_lay_sub(n_0,n_1,n_2,n_3,d1,d2,lamda);

R_0123 = r_0123.*conj(r_0123);

plot(lamda,R_0123,x.*nm,y)
legend('Fresnel','Simulation')
