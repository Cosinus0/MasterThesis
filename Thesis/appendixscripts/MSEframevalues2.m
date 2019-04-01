clear all
close all

tic

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = (450:900);

air = [1:0.1:1.3]; %Defining Refractive index limits.
thinfilm = [1.4:0.1:2]; %Defining Refractive index limits.
thickness = [250:1:550]; %Defining Thickness limits.

framevalues = []; %Define empty array where all data will be saved.

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load PIreflectance %Load reflectance measurements for PS -471x642- 471 SVA Measurements.

x = wavelength;

% For loop for fitting each SVA measurement.
for z = 1:length(PIreflectance(:,1))

y = PIreflectance(z,(51:501));

MSE = []; %Define empty array to save data for one full SVA Measurement.

%%%%%%%%%%%%%%%%%%%%
% Reflective Index %
%%%%%%%%%%%%%%%%%%%%


% For loop for fitting refractive index of Air.
for k = 1:length(air)

list = [];
    
n_0 = air(k);

        % For loop for fitting refractive index of the thin film.
        for l = 1:length(thinfilm)
        
            
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
            
            
            list = [air(k),thinfilm(l),thickness(m),sumsq];
            MSE = vertcat(MSE,list);

            end
    end
end

[row,column] = find(MSE==min(min(MSE(:,4))));
tempvalue = MSE(row,:,:,:);

framevalues = vertcat(framevalues,tempvalue);



end

Time = toc;

save('frame_val2.mat','framevalues','Time') %Saving to file


