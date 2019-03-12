clear all
close all

load daystudyreflectance 
%refldata=transpose(PSreflectance(:,(51:501)));


%wave = [450:900];
wave = [400:1041];
nm = 10^-9;
%lamda = (450:900);
lamda = (400:1041);

time = [10.47 11.19 11.49 12.19 12.49 13.19 13.49 14.19 14.49 15.19 15.49 16.19 16.49 17.19];

        
        
%set(gca,'nextplot','replacechildren');
%v = VideoWriter('daystudy1.avi');
%v.FrameRate = 0.5;
%open(v);

for i=1:14
    
    plot(wave,daystudyreflectance(i,:))
    axis([400 1050 0 1])
    title(['PS - Time' num2str(time(i))])
    xlabel('Wavelength')
    ylabel('Reflectance')
    
    pause(0.1)
    
       %frame = getframe(gcf);
       %writeVideo(v,frame);

end

%close(v)