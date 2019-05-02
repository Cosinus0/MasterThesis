clear all
close all

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = [452:901];

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load PSreflectance

x = wavelength;
y = PSreflectance(8,53:502);

%%%%%%%%%%%%%%%%%%%%
% Reflective Index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1.0003;
n_1 = 1.5702;

load dispersion_SiOx.dat
disp_2 = dispersion_SiOx(303:1:752,:);
n_2 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

load dispersion_Si(100).dat
disp_3 = dispersion_Si_100_(303:1:752,:);
n_3 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d_1 = 115.9;
d_2 = 2;	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reflectance Calculations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r_0123 = fresnel_am_tf_lay_sub(n_0,n_1,n_2,n_3,d_1,d_2,wavelength);

R_0123 = r_0123.*conj(r_0123); 

plot(wavelength,R_0123,x,y)
title({'PS-338','Measured reflectance vs. Fresnel model'})
xlabel('Wavelength nm')
ylabel('Reflectance')
legend('Fresnel','Reflectance')


%%%%%%%%%%%%%%%%%%
% Sum of Squares %
%%%%%%%%%%%%%%%%%%

n = 450;
deltay = y(:,53:502) - R_0123;
sqdeltay = deltay.^2;
sumsq = sum(sqdeltay);
