clear all
close all

%%%%%%%%%%%%%
% Load Data %
%%%%%%%%%%%%%

load PIreflectance %Load reflectance measurements.
refldata=PIreflectance(:,(51:501));

load frame_val2.mat

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

r_0123 = fresnel_am_tf_lay_sub(framevalues(i,1),framevalues(i,2),n_2,n_3,framevalues(i,3),d_2,wavelength);
R_0123 = r_0123.*conj(r_0123);

plot(wavelength,refldata(550,:),wavelength,R_0123)
title('Reflectance measurement of polyisoprene at 5500 seconds')
xlabel('Wavelength')
ylabel('Reflectance')
legend('Reflectance measurement','Fresenel equation')