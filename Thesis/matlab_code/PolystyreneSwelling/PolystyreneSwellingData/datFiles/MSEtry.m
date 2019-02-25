clear all
close all

tic

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

nm = 10^-9;
wavelength = (400:1041);
lamda = (450:900).*nm;

air = [1:0.1:1.5];
thinfilm = [1.1:0.1:1.9];
thickness = [200:1:500];

MSE = [];

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load PSreflectance

x = wavelength(51:501);
y = PSreflectance(1,(51:501));

%%%%%%%%%%%%%%%%%%%%
% Reflective Index %
%%%%%%%%%%%%%%%%%%%%



for k = 1:length(air)

list = [];
    
n_0 = air(k);

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


toc
