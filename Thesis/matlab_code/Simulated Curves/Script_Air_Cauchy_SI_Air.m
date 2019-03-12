clear all
close all


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Air_Cauchy_SI(100)_Air.xy %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load Air_Cauchy_SI(100)_Air.xy

x = Air_Cauchy_SI_100__Air(:,1);
y = Air_Cauchy_SI_100__Air(:,2);


%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

nm = 10^-9;
wavelength = [400:1041]; 
lamda = [400:1041].*nm;

%%%%%%%%%%%%%%%%%%%%
% Refractive index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1;
%A = 1.4450;
%B = 3e4;
%C = 4e7;
%n_1 = cauchy(wavelength,A,B,C); %Dont not use lamda in nanometers.
n_1 = 1.5;

load dispersion_Si(100).dat
disp = dispersion_Si_100_(251:1:892,:);
%n_2 = transpose(disp(:,2));
n_2 = transpose(disp(:,2))-1i.*transpose(disp(:,3));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d = 1000;


%%%%%%%%%%%%%%%%
% Calculations %
%%%%%%%%%%%%%%%%

r_012 = fresnel_am_tf_s(n_0,n_1,n_2,d,wavelength);

R_012 = r_012.*conj(r_012);

plot(lamda,R_012,'g',x.*nm,y,'--k')
legend('Fresnel','Simulation')

%%%%%%%%%%%%%%%%%%
% Sum of Squares %
%%%%%%%%%%%%%%%%%%

deltay = R_012 - transpose(y);
sqdeltay = deltay.^2;
sumsq = sum(sqdeltay);
