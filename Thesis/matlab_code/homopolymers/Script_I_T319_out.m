clear all
close all

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

nm = 10^-9;
wavelength = (400:1041);
lamda = (400:1041).*nm;

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load I-T319_asprep_out.xy

x = I_T319_asprep_out(:,1);
y = I_T319_asprep_out(:,2);

%%%%%%%%%%%%%%%%%%%%
% Reflective Index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1;

% A = 1.4450;
% B = 3e4;
% C = 4e7;
% n_1 = cauchy(wavelength,A,B,C);
n_1 = 1.5201;

load dispersion_SiOx.dat
disp_2 = dispersion_SiOx(251:1:892,:);
n_2 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

load dispersion_Si(100).dat
disp_3 = dispersion_Si_100_(251:1:892,:);
n_3 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d_1 = 109.1.*nm;
d_2 = 2.*nm;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reflectance Calculations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r_0123 = fresnel_am_tf_lay_sub(n_0,n_1,n_2,n_3,d_1,d_2,lamda); 

R_0123 = r_0123.*conj(r_0123); 

plot(lamda.*10^9,R_0123,x,y)
title({'I-T319 out','Measured reflectance vs. Fresnel model'})
xlabel('Wavelength nm')
ylabel('Reflectance')
legend('Reflectance','Fresnel')

deltay = R_0123(2:642) - transpose(y);
sqdeltay = deltay.^2;
sumsq = sum(sqdeltay);
