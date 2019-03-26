clear all
close all

%%%%%%%%%%%%%
% Load Data %
%%%%%%%%%%%%%

load PIreflectance %Load reflectance measurements.
refldata=PIreflectance(:,(51:501));

%Load best MSE values for each frame.
%Limits for frame_val2.mat
%Air=[1:0.1:1.3];
%Thinfilm=[1.4:0.1:2];
%Thickness=[250:1:550];
load frame_val2.mat 

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = [450:900];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Thickness related to the solvent concentration %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phi2 = 1-((framevalues(1,3))./(framevalues(:,3)));


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

numframes = length(PIreflectance(:,1));
%%

figure('units','normalized','outerposition',[0 0 1 1])
plot((1:numframes).*10,phi2)
title('Solvent concentration in polyisoprene during SVA')
xlabel('Time (seconds)')
ylabel('Solvent concentration')
axis([0 10000 -0.1 0.5])
hold on
hline([0 0.1 0.2 0.3 0.4],{'k:','k:','k:','k:','k:'},{'','','','',''})
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off

%%
figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,1,1)
plot((1:numframes).*10,framevalues(:,1))
title('Polyisoprene')
xlabel('Seconds')
ylabel('Air Refractive index')
yticks([1.1 1.2 1.3 1.4 1.5])
legend('Air R-I','Running air R-I')
hold on
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off

subplot(3,1,2)
plot((1:numframes).*10,framevalues(:,2))
xlabel('Seconds')
ylabel('Thin film Refractive index')
axis([0 10000 1.4 1.9])
yticks([1.4 1.5 1.6 1.7 1.8 1.9])
legend('Thinfilm R-I','Running Thinfilm R-I')
hold on
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off
 
subplot(3,1,3)
plot((1:numframes).*10,framevalues(:,3))
xlabel('Seconds')
ylabel('Thickness')
axis([0 10000 250 600])
yticks([250 300 350 400 450 500 550 600])
legend('Thickness','Running Thickness')
hold on
hline([300 350 400 450 500 550],{'k:','k:','k:','k:','k:'},{'','','','',''})
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off

%%

figure('units','normalized','outerposition',[0 0 1 1])
    plot((1:numframes).*10,framevalues(:,4),'b.')
    axis([0 10000 0 1.2])
    title('Mean square error of polyisoprene under solvent vapour annealing')
    xlabel('Seconds')
    ylabel('Mean square error')
hold on
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off


%%
figure('units','normalized','outerposition',[0 0 1 1])

%set(gca,'nextplot','replacechildren');
%v = VideoWriter('PIsvaframevalue2.avi');
%v.FrameRate = 10;
%open(v);


for i=1:numframes

    r_0123 = fresnel_am_tf_lay_sub(framevalues(i,1),framevalues(i,2),n_2,n_3,framevalues(i,3),d_2,wavelength);
    R_0123 = r_0123.*conj(r_0123);

subplot(4,1,1)    
plot(wavelength,refldata(i,:),wavelength,R_0123);
axis([450 900 0 1])
title({['PI swelling'];['Seconds =',num2str(i*10)];['MSE =',num2str(framevalues(i,4))]})
legend('Reflectance','Fresnel')

subplot(4,1,2)
plot((1:numframes).*10,framevalues(:,1),(1:i).*10,framevalues(1:i,1))
yticks([1.1 1.2 1.3 1.4 1.5])
legend('Air R-I','Running air R-I')

subplot(4,1,3)
plot((1:numframes).*10,framevalues(:,2),(1:i).*10,framevalues(1:i,2))
yticks([1.4 1.5 1.6 1.7 1.8])
legend('Thinfilm R-I','Running Thinfilm R-I')
 
subplot(4,1,4)
plot((1:numframes).*10,framevalues(:,3),(1:i).*10,framevalues(1:i,3))
yticks([200 300 400 500 600])
legend('Thickness','Running Thickness')


%frame = getframe(gcf);
%writeVideo(v,frame);


pause(0.001);



end

%close(v);