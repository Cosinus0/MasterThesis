clear all
close all

%%%%%%%%%%%%%
% Load Data %
%%%%%%%%%%%%%

load PSreflectance160319 %Load reflectance measurements.
refldata=PSreflectance160319(:,(51:501));

load PSframe_val160319.mat

wavelength = [450:900];

%%%%%%%%%%%%%%%%%%%%
% Refractive index %
%%%%%%%%%%%%%%%%%%%%

load dispersion_SiOx.dat
disp_2 = dispersion_SiOx(301:1:751,:);
n_2 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

load dispersion_Si(100).dat
disp_3 = dispersion_Si_100_(301:1:751,:);
n_3 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

d_2 = 2;

i=550;

r_0123 = fresnel_am_tf_lay_sub(PSframevalues160319(i,1),PSframevalues160319(i,2),n_2,n_3,PSframevalues160319(i,3),d_2,wavelength);
R_0123 = r_0123.*conj(r_0123);

plot(wavelength,refldata(550,:),wavelength,R_0123)
title('Reflectance measurement of polystyrene at 5500 seconds')
xlabel('Wavelength')
ylabel('Reflectance')
legend('Reflectance measurement','Fresenel equation')