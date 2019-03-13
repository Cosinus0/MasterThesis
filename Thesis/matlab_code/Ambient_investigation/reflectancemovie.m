clear all
close all

load ambientinvestreflectance

wavelength = (450:900);

figure('units','normalized','outerposition',[0 0 1 1])
set(gca,'nextplot','replacechildren');
v = VideoWriter('ambientinvestigationwithmodel.avi');
v.FrameRate = 10;
open(v);

load frame_val.mat

load dispersion_SiOx.dat
disp_2 = dispersion_SiOx(301:1:751,:);
n_1 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

load dispersion_Si(100).dat
disp_3 = dispersion_Si_100_(301:1:751,:);
n_2 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

d_1=2;

for q = 12:length(ambientinvestreflectance(:,1))
    
r_01 = fresnel_am_tf_s(framevalues(q,1),n_1,n_2,d_1,wavelength); 
R_01 = r_01.*conj(r_01); 
    
    subplot(2,1,1)
    plot(wavelength,ambientinvestreflectance(q,:),wavelength,R_01)
    axis([450 900 0 1])
    title({['Ambient Investigation'];['seconds' num2str(q.*10)]})
    xlabel('Wavelength')
    ylabel('Reflectance')
    
    subplot(2,1,2)
    plot((12:length(ambientinvestreflectance(:,1))).*10,framevalues(12:length(ambientinvestreflectance(:,1)),1),(12:q).*10,framevalues(12:q,1))
    axis([0 11000 1 1.4])
    xlabel('Seconds')
    ylabel('Refractive Index(R-I)')
    yticks([1 1.1 1.2 1.3 ])
    legend('Air R-I','Running air R-I')
    hold on
    line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
    hold off
    
    pause(0.05)
    
frame = getframe(gcf);
writeVideo(v,frame);
    
end

close(v)