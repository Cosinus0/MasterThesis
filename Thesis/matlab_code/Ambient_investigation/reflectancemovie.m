clear all
close all

load ambientinvestreflectance

wavelength = (450:900);

set(gca,'nextplot','replacechildren');
v = VideoWriter('ambientinvestigationwithmodel.avi');
v.FrameRate = 20;
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
    
    plot(wavelength,ambientinvestreflectance(q,:),wavelength,R_01)
    axis([450 900 0 1])
    title({'Ambient Investigation','seconds' num2str(q.*10),'R-I' num2str(framevalues(q,1))})
    xlabel('Wavelength')
    ylabel('Reflectance')
    pause(0.05)
    
    frame = getframe(gcf);
    writeVideo(v,frame);
    
end

close(v)