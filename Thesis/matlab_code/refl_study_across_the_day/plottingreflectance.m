clear all
close all

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load daystudyreflectance
y = transpose(daystudyreflectance);
arraylength = length(daystudyreflectance(:,1)) ; 

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = [400:1041];

%%%%%%%%%%%%
% Plotting %
%%%%%%%%%%%%

hold on

for q = 1: arraylength
    
    
    plot(wavelength,y(:,q))
    title('Light Source fluctuation study at different times of the day')
    xlabel('Wavelength (nm)')
    ylabel('Reflectance')
    legend('10:47','11:19','11:49','12:19','12:49','13:19','13:49','14:19','14:49','15:19','15:49','16:19','16:49','17:19')
    axis([400 1041 0 1])

end

hold off