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

AIR= [1:0.1:1.3]; %Defining Refractive index limits.
THINFILM = [1.5:0.01:1.8]; %Defining Refractive index limits.
THICKNESS = [50:1:120]; %Defining Thickness limits.

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load PSbPIreflectance %Load reflectance measurements for PS -471x642- 471 SVA Measurements.

x = wavelength;
reflectance = PSbPIreflectance(12:979,(51:501));


load PSbPIframevalstartfine.mat
framevalues = [];
framevalues = vertcat(framevalues,PSbPIframevaluesstartfine);

doublelist = [];


for y_it = 2:968
    
    y = reflectance(y_it,:);
    
    
    startvalues = framevalues(y_it-1,:);
    Rstep = 0.1;
    Tstep = 1;
    MSE = [];
    for air_it = 1:3
        
        list = [];
        
        air_array = [startvalues(1)-Rstep:Rstep:startvalues(1):Rstep:startvalues(1)+Rstep];
        
        if ismember(air_array(air_it),AIR) == true 
            n_0 = air_array(air_it);
        
        else
            continue
        end
        
        for R_lay1_it = 1:5
            
            R_lay1_array = [startvalues(2)-2.*Rstep:Rstep:startvalues(2):Rstep:startvalues(2)+2.*Rstep];
        
            if ismember(R_lay1_array(R_lay1_it),THINFILM) == true 
                n_1 = R_lay1_array(R_lay1_it);
        
            else
                continue
            end
            
            
            for R_lay2_it = 1:5
                
                R_lay2_array = [startvalues(3)-2.*Rstep:Rstep:startvalues(3):Rstep:startvalues(3)+2.*Rstep];
        
                if ismember(R_lay2_array(R_lay2_it),THINFILM) == true 
                    n_2 = R_lay2_array(R_lay2_it);
        
                else
                    continue
                end                
                
                load dispersion_SiOx.dat
                disp_3 = dispersion_SiOx(301:1:751,:);
                n_3 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

                load dispersion_Si(100).dat
                disp_4 = dispersion_Si_100_(301:1:751,:);
                n_4 = transpose(disp_4(:,2)) -1i.*transpose(disp_4(:,3));
                
                for D_lay1_it = 1:5
                    
                    D_lay1_array = [startvalues(4)-2.*Tstep:Tstep:startvalues(4):Tstep:startvalues(4)+2.*Tstep];
        
                    if ismember(D_lay1_array(D_lay1_it),THICKNESS) == true 
                        d_1 = D_lay1_array(D_lay1_it);
                    else
                        continue
                    end  
                    
                    
                    for D_lay2_it = 1:5
                        
                        D_lay2_array = [startvalues(5)-2.*Tstep:Tstep:startvalues(5):Tstep:startvalues(5)+2.*Tstep];
        
                        if ismember(D_lay2_array(D_lay2_it),THICKNESS) == true 
                            d_2 = D_lay2_array(D_lay2_it);
                        else
                            continue
                        end  
                    
                        
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
    truerow = [];
    
    [row,column] = find(MSE==min(min(MSE(:,6))));
    tempvalue = MSE(row,:,:,:,:,:);
    
    Unique_framevalues = unique(tempvalue,'rows');
    
    [row1,column1] = find(Unique_framevalues==max(max(Unique_framevalues(:,4))));
    row2 = find(column1==4);
    tempvalue2 = Unique_framevalues(row2,:,:,:,:,:);
    
    Unique_framevalues2 = unique(tempvalue2,'rows');
    
    
    framevalues = vertcat(framevalues,Unique_framevalues2);
    
    
end

Time = toc;

V2framevaluesfine=framevalues;

save('Neighbourhoodfit2layerV2framevaluesfine','V2framevaluesfine','doublelist','Time')
    
    
                
   
    
