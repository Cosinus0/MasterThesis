clear all
close all 

%%%%%%%%%%%%%
% Load Data %
%%%%%%%%%%%%%

load ambientinvestreflectance
load frame_val.mat

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = (450:900);

%%%%%%%%%%%%
% Plotting %
%%%%%%%%%%%%

figure('units','normalized','outerposition',[0 0 1 1])
    plot((12:length(ambientinvestreflectance(:,1))).*10,framevalues(12:length(ambientinvestreflectance(:,1)),1))
    axis([0 11000 1 1.4])
    title('Solvent vapour annealing ambient study')
    xlabel('Seconds')
    ylabel('Refractive Index')
    yticks([1 1.1 1.2 1.3 ])
    legend('Refractive index of Ambient')
hold on
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off


figure('units','normalized','outerposition',[0 0 1 1])
    plot((12:length(ambientinvestreflectance(:,1))).*10,framevalues(12:length(ambientinvestreflectance(:,1)),2).*length(wavelength),'k.')
    axis([0 11000 0 0.3])
    title('Solvent vapour annealing ambient study - MSE')
    xlabel('Seconds')
    ylabel('MSE')
hold on
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off
