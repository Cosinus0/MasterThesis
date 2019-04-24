clear all
close all

load PSbPIreflectance %Load reflectance measurements.
refldata=PSbPIreflectance(12:length(PSbPIreflectance(:,1)),(51:501));

load Neighbourhoodfit2layerframevaluestotal.mat

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = (450:900);

%%%%%%%%%%%%%%%%%%%%
% Refractive Index %
%%%%%%%%%%%%%%%%%%%%

load dispersion_SiOx.dat
disp_2 = dispersion_SiOx(301:1:751,:);
n_3 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

load dispersion_Si(100).dat
disp_3 = dispersion_Si_100_(301:1:751,:);
n_4 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));
        
%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d_3 = 2;

%%%%%%%%%%%%        
% Plotting %
%%%%%%%%%%%%

numframes = 968;



figure('units','normalized','outerposition',[0 0 1 1])
for i=1:numframes

    r_01234 = thinfilmlayer5(framevaluestotal(i,1),framevaluestotal(i,2),framevaluestotal(i,3),n_3,n_4,framevaluestotal(i,4),framevaluestotal(i,5),d_3,wavelength);
    R_01234 = r_01234.*conj(r_01234); 
    
    plot(wavelength,refldata(i,:),wavelength,R_01234);
    axis([450 900 0 1])
    title({['PSbPI swelling 2 Layer fitting'];['Seconds =',num2str(i*10)];['MSE =',num2str(framevaluestotal(i,6))]})
    legend('Reflectance','Fresnel')
    
    pause(0.001);
    
end