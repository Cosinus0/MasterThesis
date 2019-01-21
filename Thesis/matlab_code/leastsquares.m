clear all
close all

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!%
% Least squares for thickness,  % 
% for wafer_calculation.m,      %
% before fixed fresnel function %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

nm = 10^-9;
lamda = [400:1041].*nm;

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load Air_Si(100)_n1_5(450nm)_Air.xy

x = Air_Si_100__n1_5_450nm__Air(:,1);
y = Air_Si_100__n1_5_450nm__Air(:,2);

%%%%%%%%%%%%%%%%%%%%
% Reflective Index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1;
n_1 = 1.5;

load dispersion_Si(100).dat
disp = dispersion_Si_100_(251:1:892,:);
n_2 = transpose(disp(:,2));

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d = [1:1:2000].*nm;


sumsq = zeros(length(d),1);

for int = 1:length(d)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reflectance Calculations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r_012 = fresnel_am_tf_s(n_0,n_1,n_2,d(int),lamda);

R_012 = r_012.*conj(r_012);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculating least squares %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

deltay = R_012 - transpose(y);
sqdeltay = deltay.^2;
sumsq(int,1) = sum(sqdeltay);

end

%%%% sumsq(1086) and sumsq(1087) 