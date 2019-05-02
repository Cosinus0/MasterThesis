clear all
close all

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

nm = 10^-9;
wavelength = (400:1041);

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%
load I-T319_asprep3.xy

x = I_T319_asprep3(:,1);
y = I_T319_asprep3(:,2);

%%%%%%%%%%%%%%%%%%%%
% Reflective Index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1;

% A = 1.4450;
% B = 3e4;
% C = 4e7;
% n_1 = cauchy(wavelength,A,B,C);
n_1 = 2.4748;

load dispersion_SiOx.dat
disp_2 = dispersion_SiOx(251:1:892,:);
n_2 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

load dispersion_Si(100).dat
disp_3 = dispersion_Si_100_(251:1:892,:);
n_3 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d_1 = 67.6;
d_2 = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reflectance Calculations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r_0123 = fresnel_am_tf_lay_sub(n_0,n_1,n_2,n_3,d_1,d_2,wavelength); 

R_0123 = r_0123.*conj(r_0123); 

figure('units','normalized','outerposition',[0 0 1 1])
plot(wavelength,R_0123,x,y)
title('Measured reflectance vs. Fresnel model')
xlabel('Wavelength nm')
ylabel('Reflectance')
legend('Fresnel','Reflectance')


