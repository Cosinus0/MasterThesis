clear all
close all

load ambientinvestreflectance

wavelength = (450:900);

set(gca,'nextplot','replacechildren');
v = VideoWriter('ambientinvestigation.avi');
v.FrameRate = 20;
open(v);

for q = 12:length(ambientinvestreflectance(:,1))
    
    plot(wavelength,ambientinvestreflectance(q,:))
    axis([450 900 0 1])
    title({'Ambient Investigation', num2str(q.*10) 'seconds'})
    xlabel('Wavelength')
    ylabel('Reflectance')
    pause(0.05)
    
    frame = getframe(gcf);
    writeVideo(v,frame);
    
end

close(v)