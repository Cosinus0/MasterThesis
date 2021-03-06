clear all
close all

tic

% =5=22  % Safe guard so i dont run it again and delete my frame values

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

nm = 10^-9;
wavelength = (450:900);
lamda = (450:900).*nm;

air = [1:0.1:1.9]; %Defining Refractive index limits.
thinfilm = [1.5:0.1:2.1]; %Defining Refractive index limits.
thickness = [288:1:500]; %Defining Thickness limits.

fullMSE = []; %Define empty array where all data will be saved.

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load PSreflectance %Load reflectance measurements for PS -471x642- 471 SVA Measurements.

x = wavelength;


% For loop for fitting each SVA measurement.
for z = 1:length(PSreflectance(:,1))

y = PSreflectance(z,(51:501));

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
        
        % A = 1.4450;
        % B = 3e4;
        % C = 4e7;
        % n_1 = cauchy(wavelength,A,B,C);
            
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

            d_1 = thickness(m).*nm;
            d_2 = 2.*nm;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reflectance Calculations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            r_0123 = fresnel_am_tf_lay_sub(n_0,n_1,n_2,n_3,d_1,d_2,lamda); 

            R_0123 = r_0123.*conj(r_0123); 

            %plot(lamda.*10^9,R_0123,x,y)
            %title({'I-T319 out','Measured reflectance vs. Fresnel model'})
            %xlabel('Wavelength nm')
            %ylabel('Reflectance')
            %legend('Reflectance','Fresnel')

%%%%%%%
% MSE %
%%%%%%%

            deltay = y - R_0123;
            sqdeltay = deltay.^2;
            sumsq = sum(sqdeltay)./length(x);
            
            
            list = [air(k),thinfilm(l),thickness(m),sumsq];
            MSE = vertcat(MSE,list);

            end
    end
end

fullMSE = vertcat(fullMSE,MSE);



end

save('fullMSE.mat','fullMSE') %Saving to file


toc
