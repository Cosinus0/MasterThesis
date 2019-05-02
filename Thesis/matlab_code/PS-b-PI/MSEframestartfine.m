clear all
close all

tic


%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = (450:900);

air = 1; %Defining Refractive index limits.
thinfilm = [1.5:0.01:1.8]; %Defining Refractive index limits.
thickness = [50:1:60]; %Defining Thickness limits.

PSbPIframevaluesstartfine = []; %Define empty array where all data will be saved.

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load PSbPIreflectance %Load reflectance measurements for PS -471x642- 471 SVA Measurements.

x = wavelength;
y = PSbPIreflectance(12,(51:501));


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
        
            for r = 1:length(thinfilm)
        
            n_2 = thinfilm(r);
        

            load dispersion_SiOx.dat
            disp_3 = dispersion_SiOx(301:1:751,:);
            n_3 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

            load dispersion_Si(100).dat
            disp_4 = dispersion_Si_100_(301:1:751,:);
            n_4 = transpose(disp_4(:,2)) -1i.*transpose(disp_4(:,3));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%
                % For loop for fitting the tickness of the thinfilm.
                for m = 1:length(thickness)

                d_1 = thickness(m);
            
                    for q = 1:length(thickness)
                        
                    d_2 = thickness(q);
            
                    d_3 = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reflectance Calculations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                    r_01234 = thinfilmlayer5(n_0,n_1,n_2,n_3,n_4,d_1,d_2,d_3,wavelength);

                    R_01234 = r_01234.*conj(r_01234); 

%%%%%%%
% MSE %
%%%%%%%

                    deltay = y - R_01234;
                    sqdeltay = deltay.^2;
                    sumsq = sum(sqdeltay);
            
                    list = [air(k),thinfilm(l),thinfilm(r),thickness(m),thickness(q),sumsq];
                    MSE = vertcat(MSE,list);

                    end
                end
            end
        end
    end

[row,column] = find(MSE==min(min(MSE(:,6))));
tempvalue = MSE(row,:,:,:,:,:);

PSbPIframevaluesstartfine = vertcat(PSbPIframevaluesstartfine,tempvalue);

Time = toc;

save('PSbPIframevalstartfine.mat','PSbPIframevaluesstartfine','Time') %Saving to file


