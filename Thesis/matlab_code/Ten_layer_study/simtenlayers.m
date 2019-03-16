clear all
close all

%%%%%%%%%%%%%
% Load data %
%%%%%%%%%%%%%

load tenlayers.xy
x = tenlayers(:,1);
y = tenlayers(:,2);

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength=(400:1041);

%%%%%%%%%%%%%%%%%%%%
% Refractive index %
%%%%%%%%%%%%%%%%%%%%

n_0 = 1;

n_1 = 1.3;
n_2 = 1.4;
n_3 = 1.5;
n_4 = 1.6;
n_5 = 1.7;
n_6 = 1.8;
n_7 = 1.9;
n_8 = 2.0;
n_9 = 2.1;

load dispersion_SiOx.dat
disp_2 = dispersion_SiOx(251:1:892,:);
n_10 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

load dispersion_Si(100).dat
disp_3 = dispersion_Si_100_(251:1:892,:);
n_11 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));

%%%%%%%%%%%%%
% Thickenss %
%%%%%%%%%%%%%

d_1 = 50;
d_2 = 50;
d_3 = 50;
d_4 = 50;
d_5 = 50;
d_6 = 50;
d_7 = 50;
d_8 = 50;
d_9 = 50;

d_10 = 2;


%%%%%%%%%%%%
% Plotting %
%%%%%%%%%%%%

refl = thinfilmlayer12(n_0,n_1,n_2,n_3,n_4,n_5,n_6,n_7,n_8,n_9,n_10,n_11,d_1,d_2,d_3,d_4,d_5,d_6,d_7,d_8,d_9,d_10,wavelength);
Refl = refl.*conj(refl);

figure('units','normalized','outerposition',[0 0 1 1])
plot(x,y,'g',wavelength,Refl,'k:')