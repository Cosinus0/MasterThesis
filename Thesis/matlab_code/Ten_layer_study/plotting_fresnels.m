clear all
close all

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load tenlayers.xy
x = tenlayers(:,1);
y = tenlayers(:,2);

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength=(400:1041);

%%%%%%%%%%%%%%%%%%%%
% Refractive index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1;

n_1 = [1:0.1:2];

load dispersion_SiOx.dat
disp_2 = dispersion_SiOx(251:1:892,:);
n_2 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

load dispersion_Si(100).dat
disp_3 = dispersion_Si_100_(251:1:892,:);
n_3 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d_1=[50:50:500];

d_2=2;

%%

%%%%%%%%%%%%
% Plotting %
%%%%%%%%%%%%

figure('units','normalized','outerposition',[0 0 1 1])

set(gca,'nextplot','replacechildren');
v = VideoWriter('varyRI.avi');
v.FrameRate = 3;
open(v);

for i=1:11
    
    for j = 1:10

refl = thinfilmlayer4(n_0,n_1(i),n_2,n_3,d_1(j),d_2,wavelength);
Refl = refl.*conj(refl);

plot(wavelength,Refl)
axis([450 900 0 1])
title({['Varying Fresnel Equations'];['Thin film refractive index =',num2str(n_1(i))];['Thickness =',num2str(d_1(j))]})
xlabel('Wavelength');
ylabel('Reflectance');

frame = getframe(gcf);
writeVideo(v,frame);


pause(0.001);
    end
end

close(v);