clear all
close all

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%
nm = 10^-9;
lamda = [400:1000].*nm;

%%%%%%%%%%%%%%%%
% Loading data %
%%%%%%%%%%%%%%%%

load Air_Si(100)_n1_5(450nm)_Air.xy

x = Air_Si_100__n1_5_450nm__Air(:,1);
y = Air_Si_100__n1_5_450nm__Air(:,2);

%%%%%%%%%%%%%%%%%%%%
% Refractive index %
%%%%%%%%%%%%%%%%%%%%
n_0 = 1;
n_1 = 1.5;

load dispersion_Si(100).dat
disp = dispersion_Si_100_(251:1:851,:);
n_2 = transpose(disp(:,2));

n_3 = 1;

%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d1 = 450.*nm;
d2 = 500000.*nm;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reflectance Calculations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r_0123 = fresnel_am_tf_lay_s(n_0,n_1,n_2,n_3,d1,d2,lamda);

R_0123 = r_0123.*conj(r_0123);

plot(lamda.*10^9,R_0123,x,y)