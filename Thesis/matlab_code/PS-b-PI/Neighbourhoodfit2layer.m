clear all
close all

tic

%%%%%%%%%%
%
%%%%%%%%%%


%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = (450:900);

air = [1:0.1:1.3]; %Defining Refractive index limits.
thinfilm = [1.4:0.1:1.8]; %Defining Refractive index limits.
thickness = [50:1:120]; %Defining Thickness limits.

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load PSbPIreflectance %Load reflectance measurements for PS -471x642- 471 SVA Measurements.

x = wavelength;
reflectance = PSbPIreflectance(12:979,(51:501));


load PSbPIframevalstart3.mat
framevalues = [];
framevalues = vertcat(framevalues,PSbPIframevaluesstart3);


for y_it = 2:559
    
    y = reflectance(y_it,:);
    MSE = [];
    
    startvalues = framevalues(y_it-1,:);
    Rstep = 0.1;
    Tstep = 1;
    
    for air_it = 1:2
        
        list = [];
        
        n_0 = startvalues(1) + Rstep.*(air_it-1);
        
        
        
        for R_lay1_it = 1:5
            
            n_1 = startvalues(2) + Rstep.*(R_lay1_it-1);
           
            
            for R_lay2_it = 1:5
                
                n_2 = startvalues(3) + Rstep.*(R_lay2_it-1);
                
                load dispersion_SiOx.dat
                disp_3 = dispersion_SiOx(301:1:751,:);
                n_3 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

                load dispersion_Si(100).dat
                disp_4 = dispersion_Si_100_(301:1:751,:);
                n_4 = transpose(disp_4(:,2)) -1i.*transpose(disp_4(:,3));
                
                for D_lay1_it = 1:5
                    
                    d_1 = startvalues(4) + Tstep.*(D_lay1_it-1);
                    
                    for D_lay2_it = 1:5
                        
                        d_2 = startvalues(5) + Tstep.*(D_lay2_it-1);
                        
                        d_3 = 2;
                        
                        r_01234 = thinfilmlayer5(n_0,n_1,n_2,n_3,n_4,d_1,d_2,d_3,wavelength);
                        R_01234 = r_01234.*conj(r_01234); 
                        
                        deltay = y - R_01234;
                        sqdeltay = deltay.^2;
                        sumsq = sum(sqdeltay);
            
                        list = [n_0,n_1,n_2,d_1,d_2,sumsq];
                        MSE = vertcat(MSE,list);
                        
                    end
                end
            end
        end
    end
    
    [row,column] = find(MSE==min(min(MSE(:,6))));
    tempvalue = MSE(row,:,:,:,:,:);
    
    framevalues = vertcat(framevalues,tempvalue);
    
end

Time = toc;

save('Neighbourhoodfit2layerframevaluesswell','framevalues','Time')
    
    
                
   
    
