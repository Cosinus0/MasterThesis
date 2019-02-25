clear all
close all

load PSreflectance
refldata=transpose(PSreflectance(:,(51:501)));

load frame_val.mat


%Nan files - But they are just included in bo's dat file.
%PSmodel=load('/home/nathan/Documents/GitHub/MasterThesis/Thesis/matlab_code/PolystyreneSwelling/PolystyreneSwellingData/nanFiles/PSmodel')
%modeldata = transpose(PSmodel)

wave = [450:900];
nm = 10^-9;
lamda = (450:900);%.*nm;


        load dispersion_SiOx.dat
        disp_2 = dispersion_SiOx(301:1:751,:);
        n_2 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

        load dispersion_Si(100).dat
        disp_3 = dispersion_Si_100_(301:1:751,:);
        n_3 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));
        
        d_2 = 2.*nm;
        
        
set(gca,'nextplot','replacechildren');
v = VideoWriter('PSsva.avi');
open(v);

figure
for i=1:471

    r_0123 = fresnel_am_tf_lay_sub(framevalues(i,1),framevalues(i,2),n_2,n_3,framevalues(i,3),d_2,lamda);
    R_0123 = r_0123.*conj(r_0123);

subplot(2,1,1)    
plot(wave,refldata(:,i),wave,R_0123);
axis([450 900 0 1])
title([num2str(i*10) 'Seconds'])
legend('Reflectance','Fresnel')

subplot(2,1,2)
plot((1:471).*10,framevalues(:,1),(1:i).*10,framevalues(1:i,1))
legend('Air refrI','Running air refrI')

% subplot(2,1,2)
% plot((1:471).*10,framevalues(:,2),1:i,framevalues(1:i,2))
% legend('Thin film refrI','Running Thin film refrI')
% 
% subplot(2,1,2)
% plot((1:471).*10,framevalues(:,3),1:i,framevalues(1:i,3))
% legend('Thickness','Running Thickness')

   frame = getframe(gcf);
   writeVideo(v,frame);


pause(0.1);



end

close(v);