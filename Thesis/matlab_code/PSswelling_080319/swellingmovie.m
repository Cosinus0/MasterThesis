clear all
close all

%%%%%%%%%%%%%
% Load Data %
%%%%%%%%%%%%%

load PSreflectance2 %Load reflectance measurements.
refldata=PSreflectance2(:,(51:501));

%Load best MSE values for each frame.
%Limits
%Air=[1:0.1:1.5];
%Thinfilm=[1.1:0.1:2];
%Thickness=[250:1:550];
load PSframe_val2.mat 

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = [450:900];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Thickness related to the solvent concentration %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phi = 1-((PSframevalues2(1,3))./(PSframevalues2(:,3)));

%%%%%%%%%%%%%%%%%%%%
% Refractive index %
%%%%%%%%%%%%%%%%%%%%

load dispersion_SiOx.dat
disp_2 = dispersion_SiOx(301:1:751,:);
n_2 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

load dispersion_Si(100).dat
disp_3 = dispersion_Si_100_(301:1:751,:);
n_3 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d_2 = 2;

%%%%%%%%%%%%
% Plotting %
%%%%%%%%%%%%
numframes = length(PSreflectance2(:,1));

%%

figure('units','normalized','outerposition',[0 0 1 1])

plot((1:numframes).*10,phi)
title('Solvent concentration in the PS during SVA')
xlabel('Time (seconds)')
ylabel('Solvent concentration')
hold on
line1 = vline([1000 2000 3000 4000 6000 7000 8000 9000 10000],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off

%%
figure('units','normalized','outerposition',[0 0 1 1])

subplot(3,1,1)
plot((1:numframes).*10,PSframevalues2(:,1))
axis([0 11007 1 1.5])
title('Polystyrene with ambient refractive index upper bound 1.5')
yticks([1 1.1 1.2 1.3 1.4 1.5])
xlabel('Seconds')
ylabel('Ambient refractive index')
legend('Air R-I')

subplot(3,1,2)
plot((1:numframes).*10,PSframevalues2(:,2))
xlabel('Seconds')
ylabel('Thin film refractive index')
axis([0 11007 1.4 1.9])
yticks([1.4 1.5 1.6 1.7 1.8 1.9])
legend('Thinfilm R-I')
 
subplot(3,1,3)
plot((1:numframes).*10,PSframevalues2(:,3))
axis([0 11007 200 600])
xlabel('Seconds')
ylabel('Thickness')
yticks([200 300 400 500 600])
legend('Thickness')

%%
figure('units','normalized','outerposition',[0 0 1 1])

% set(gca,'nextplot','replacechildren');
% v = VideoWriter('PIsva.avi');
% v.FrameRate = 10;
% open(v);


for i=1:numframes

    r_0123 = fresnel_am_tf_lay_sub(PSframevalues2(i,1),PSframevalues2(i,2),n_2,n_3,PSframevalues2(i,3),d_2,wavelength);
    R_0123 = r_0123.*conj(r_0123);

subplot(4,1,1)    
plot(wavelength,refldata(i,:),wavelength,R_0123);
axis([450 900 0 1])
title({['PS swelling'];['Seconds =',num2str(i*10)];['MSE =',num2str(PSframevalues2(i,4))]})
legend('Reflectance','Fresnel')

subplot(4,1,2)
plot((1:numframes).*10,PSframevalues2(:,1),(1:i).*10,PSframevalues2(1:i,1))
yticks([1 1.1 1.2 1.3 1.4 1.5])
legend('Air R-I','Running air R-I')

subplot(4,1,3)
plot((1:numframes).*10,PSframevalues2(:,2),(1:i).*10,PSframevalues2(1:i,2))
yticks([1.4 1.5 1.6 1.7 1.8 1.9])
legend('Thinfilm R-I','Running Thinfilm R-I')
 
subplot(4,1,4)
plot((1:numframes).*10,PSframevalues2(:,3),(1:i).*10,PSframevalues2(1:i,3))
yticks([200 300 400 500 600])
legend('Thickness','Running Thickness')


% frame = getframe(gcf);
% writeVideo(v,frame);


pause(0.001);



end

%close(v);