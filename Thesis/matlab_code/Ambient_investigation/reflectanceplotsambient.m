clear all
close all 

%%%%%%%%%%%%%
% Load Data %
%%%%%%%%%%%%%

load ambientinvestreflectance
amb = ambientinvestreflectance;
load frame_val.mat

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = (450:900);

%%%%%%%%%%%%%%%%%%%%%%
% Refractive indices %
%%%%%%%%%%%%%%%%%%%%%%

load dispersion_SiOx.dat
disp_2 = dispersion_SiOx(301:1:751,:);
n_1 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

load dispersion_Si(100).dat
disp_3 = dispersion_Si_100_(301:1:751,:);
n_2 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d_1=2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fresnel reflectance calculations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot1 = fresnel_am_tf_s(framevalues(1,1),n_1,n_2,d_1,wavelength); 
PLOT1 = plot1.*conj(plot1); 

plot2 = fresnel_am_tf_s(framevalues(350,1),n_1,n_2,d_1,wavelength); 
PLOT2 = plot2.*conj(plot2); 

plot3 = fresnel_am_tf_s(framevalues(500,1),n_1,n_2,d_1,wavelength); 
PLOT3 = plot3.*conj(plot3);

plot4 = fresnel_am_tf_s(framevalues(600,1),n_1,n_2,d_1,wavelength); 
PLOT4 = plot4.*conj(plot4);

plot5 = fresnel_am_tf_s(framevalues(800,1),n_1,n_2,d_1,wavelength); 
PLOT5 = plot5.*conj(plot5);

%%%%%%%%%%%%
% Plotting %
%%%%%%%%%%%%

figure('units','normalized','outerposition',[0 0 1 1])
%     subplot(2,1,1)
    plot(wavelength,amb(12,:),wavelength,PLOT1,wavelength,amb(350,:),wavelength,PLOT2,wavelength,amb(500,:),wavelength,PLOT3,'k')
    axis([450 900 0 1])
    title('Solvent vapour annealing ambient study')
    xlabel('Wavelength')
    ylabel('Reflectance')
    legend('Reflectance measurement-120 seconds','Model-120 seconds','Reflectance measurement-3500 seconds','Model-3500 seconds','Reflectance measurement-5000 seconds','Model-5000 seconds')

%     subplot(2,1,2)
%     plot(wavelength,amb(12,:),wavelength,PLOT1,wavelength,amb(600,:),wavelength,PLOT4,wavelength,amb(800,:),wavelength,PLOT5)
%     axis([450 900 0 1])
%     xlabel('Wavelength')
%     ylabel('Reflectance')
%     legend('Reflectance measurement-120 seconds','Model-120 seconds','Reflectance measurement-6000 seconds','Model-6000 seconds','Reflectance measurement-8000 seconds','Model-8000 seconds')
