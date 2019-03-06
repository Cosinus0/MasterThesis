clear all
close all

tic

% =5=22  % Safe guard so i dont run it again and delete my frame values

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

nm = 10^-9;
wavelength = (450:900);
lamda = (450:900);%.*nm;

air = [1:0.1:2]; %Defining Refractive index limits.

framevalues = []; %Define empty array where all data will be saved.

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load ambientinvestreflectance %Load reflectance measurements for PS -471x642- 471 SVA Measurements.

x = wavelength;

% For loop for fitting each SVA measurement.
for z = 1:length(ambientinvestreflectance(:,1))

y = ambientinvestreflectance(z,:);

MSE = []; %Define empty array to save data for one full SVA Measurement.

%%%%%%%%%%%%%%%%%%%%
% Reflective Index %
%%%%%%%%%%%%%%%%%%%%


% For loop for fitting refractive index of Air.
    for k = 1:length(air)

list = [];
    
n_0 = air(k);


        

        load dispersion_SiOx.dat
        disp_2 = dispersion_SiOx(301:1:751,:);
        n_1 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

        load dispersion_Si(100).dat
        disp_3 = dispersion_Si_100_(301:1:751,:);
        n_2 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

            d_1 = 2;%.*nm;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reflectance Calculations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            r_01 = fresnel_am_tf_s(n_0,n_1,n_2,d_1,lamda); 

            R_01 = r_01.*conj(r_01); 

            %plot(lamda.*10^9,R_0123,x,y)
            %title({'I-T319 out','Measured reflectance vs. Fresnel model'})
            %xlabel('Wavelength nm')
            %ylabel('Reflectance')
            %legend('Reflectance','Fresnel')

%%%%%%%
% MSE %
%%%%%%%

            deltay = y - R_01;
            sqdeltay = deltay.^2;
            sumsq = sum(sqdeltay)./length(x);
            
            
            list = [air(k),sumsq];
            MSE = vertcat(MSE,list);

    end

[row,column] = find(MSE==min(min(MSE(:,2))));
tempvalue = MSE(row,:);

framevalues = vertcat(framevalues,tempvalue);

end

save('frame_val.mat','framevalues') %Saving to file


toc