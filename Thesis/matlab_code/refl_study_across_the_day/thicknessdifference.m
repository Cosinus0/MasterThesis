clear all
close all

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load daystudyreflectance
dayreflectance = [];
dayreflectance = vertcat(dayreflectance,daystudyreflectance(1,(51:501)));
dayreflectance = vertcat(dayreflectance,daystudyreflectance(14,(51:501)));

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

nm = 10^-9;
wavelength = (450:900);
lamda = (450:900);
x = wavelength;

framevalues = [];
list = [];

thinfilm = (1.5:0.01:1.58);
thickness = (100:1:400);

for k = 1:2
    
    y = dayreflectance(k,:);
    
    MSE = [];
    
    for l = 1:length(thinfilm)

n_0 = 1;

n_1 = thinfilm(l);

load dispersion_SiOx.dat
disp_2 = dispersion_SiOx(301:1:751,:);
n_2 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

load dispersion_Si(100).dat
disp_3 = dispersion_Si_100_(301:1:751,:);
n_3 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

        for m = 1:length(thickness)
    
    d_1 = thickness(m);
    d_2 = 2.*nm;
    
    
    r_0123 = fresnel_am_tf_lay_sub(n_0,n_1,n_2,n_3,d_1,d_2,lamda); 

    R_0123 = r_0123.*conj(r_0123); 
    
    
%%%%%%%
% MSE %
%%%%%%%

deltay = y - R_0123;
sqdeltay = deltay.^2;
sumsq = sum(sqdeltay)./length(x);


list = [thinfilm(l),thickness(m),sumsq];
MSE = vertcat(MSE,list);


        end
    end

[row,column] = find(MSE==min(min(MSE(:,3))));
tempvalue = MSE(row,:,:,:);

framevalues = vertcat(framevalues,tempvalue);



end

r1 = fresnel_am_tf_lay_sub(n_0,framevalues(1,1),n_2,n_3,framevalues(1,2),d_2,lamda); 
R1 = r1.*conj(r1);

r2 = fresnel_am_tf_lay_sub(n_0,framevalues(2,1),n_2,n_3,framevalues(2,2),d_2,lamda); 
R2 = r2.*conj(r2);

figure
plot(wavelength,dayreflectance(1,:))
hold on
plot(wavelength,R1)
plot(wavelength,dayreflectance(2,:))
plot(wavelength,R2)
hold off
title({'10:47am vs 17:19pm'})
xlabel('Wavelength')
ylabel('Reflectance')
legend('10:47am','n=1.58 d=284','17:19pm','n=1.58 d=286')
axis([450 900 0 1])




