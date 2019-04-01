clear all
close all

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load daystudy2reflectance
y = transpose(daystudy2reflectance);
arraylength = length(daystudy2reflectance(:,1)) ; 

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
    legend('13:04','13:36','14:06','14:36','15:06','15:36','16:06','16:36','17:06','17:36','18:06','18:36','19:06')
    axis([400 1041 0 1])

end

hold off
