clear all
close all

tic


%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = (450:900);

air = 1; %Defining Refractive index limits.
thinfilm = [1.5:0.1:3]; %Defining Refractive index limits.
thickness = [100:1:200]; %Defining Thickness limits.

framevaluesn01R3 = []; %Define empty array where all data will be saved.

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load PSbPIreflectance %Load reflectance measurements for PS -471x642- 471 SVA Measurements.

x = wavelength;

% For loop for fitting each SVA measurement.
for z = 12:length(PSbPIreflectance(:,1))

y = PSbPIreflectance(z,(51:501));

MSE = []; %Define empty array to save data for one full SVA Measurement.

%%%%%%%%%%%%%%%%%%%%
% Reflective Index %
%%%%%%%%%%%%%%%%%%%%

n_0 = air;

        % For loop for fitting refractive index of the thin film.
        for l = 1:length(thinfilm)
        
        list = [];
            
        n_1 = thinfilm(l);

        load dispersion_SiOx.dat
        disp_2 = dispersion_SiOx(301:1:751,:);
        n_2 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

        load dispersion_Si(100).dat
        disp_3 = dispersion_Si_100_(301:1:751,:);
        n_3 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%
            % For loop for fitting the tickness of the thinfilm.
            for m = 1:length(thickness)

            d_1 = thickness(m);
            d_2 = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reflectance Calculations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            r_0123 = fresnel_am_tf_lay_sub(n_0,n_1,n_2,n_3,d_1,d_2,wavelength); 

            R_0123 = r_0123.*conj(r_0123); 


%%%%%%%
% MSE %
%%%%%%%

            deltay = y - R_0123;
            sqdeltay = deltay.^2;
            sumsq = sum(sqdeltay);
            
            
            list = [air,thinfilm(l),thickness(m),sumsq];
            MSE = vertcat(MSE,list);

            end
        end

[row,column] = find(MSE==min(min(MSE(:,4))));
tempvalue = MSE(row,:,:,:);

framevaluesn01R3 = vertcat(framevaluesn01R3,tempvalue);



end

Time = toc
save('frame_valn01R3.mat','framevaluesn01R3','Time') %Saving to file


