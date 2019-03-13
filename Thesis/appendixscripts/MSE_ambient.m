clear all
close all

tic

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = (450:900);

air = [1:0.1:2]; %Defining Refractive index limits.

framevalues = []; %Define empty array where all data will be saved.

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load ambientinvestreflectance


%%%%%%%%
% Loop %
%%%%%%%%

it = length(ambientinvestreflectance(:,1));

% For loop for fitting each SVA measurement.
for z = 1:it

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

    d_1 = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reflectance Calculations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    r_01 = fresnel_am_tf_s(n_0,n_1,n_2,d_1,wavelength); 

    R_01 = r_01.*conj(r_01); 

            
%%%%%%%
% MSE %
%%%%%%%

    deltay = y - R_01;
    sqdeltay = deltay.^2;
    sumsq = sum(sqdeltay)./length(wavelength);
            
            
    list = [air(k),sumsq];
    MSE = vertcat(MSE,list);

    end

[row,column] = find(MSE==min(min(MSE(:,2))));
tempvalue = MSE(row,:);

framevalues = vertcat(framevalues,tempvalue);

end

%save('frame_val.mat','framevalues') %Saving to file

toc