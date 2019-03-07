clear all
close all

load PIreflectance %Load reflectance measurements.
refldata=PIreflectance(:,(51:501));

%Load best MSE values for each frame.
%Limits
%Air=[1:0.1:1.5];
%Thinfilm=[1.1:0.1:2];
%Thickness=[250:1:550];
load frame_val.mat 

wave = [450:900];
nm = 10^-9;
lamda = (450:900);


        load dispersion_SiOx.dat
        disp_2 = dispersion_SiOx(301:1:751,:);
        n_2 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

        load dispersion_Si(100).dat
        disp_3 = dispersion_Si_100_(301:1:751,:);
        n_3 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));
        
        d_2 = 2;
        
numframes = length(PIreflectance(:,1));
        

figure('units','normalized','outerposition',[0 0 1 1])

% set(gca,'nextplot','replacechildren');
% v = VideoWriter('PIsva.avi');
% v.FrameRate = 10;
% open(v);


for i=1:numframes

    r_0123 = fresnel_am_tf_lay_sub(framevalues(i,1),framevalues(i,2),n_2,n_3,framevalues(i,3),d_2,lamda);
    R_0123 = r_0123.*conj(r_0123);

subplot(4,1,1)    
plot(wave,refldata(i,:),wave,R_0123);
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


% frame = getframe(gcf);
% writeVideo(v,frame);


pause(0.001);



end

%close(v);