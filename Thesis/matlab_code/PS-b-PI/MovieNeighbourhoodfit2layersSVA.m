clear all
close all

load PSbPIreflectance %Load reflectance measurements.
refldata=PSbPIreflectance(12:length(PSbPIreflectance(:,1)),(51:501));

load Neighbourhoodfit2layerframevaluesVERSION2_doublelist.mat

%%%%%%%%%%%
% Physics %
%%%%%%%%%%%

wavelength = (450:900);

%%%%%%%%%%%%%%%%%%%%
% Refractive Index %
%%%%%%%%%%%%%%%%%%%%

load dispersion_SiOx.dat
disp_2 = dispersion_SiOx(301:1:751,:);
n_3 = transpose(disp_2(:,2)) -1i.*transpose(disp_2(:,3));

load dispersion_Si(100).dat
disp_3 = dispersion_Si_100_(301:1:751,:);
n_4 = transpose(disp_3(:,2)) -1i.*transpose(disp_3(:,3));
        
%%%%%%%%%%%%%
% Thickness %
%%%%%%%%%%%%%

d_3 = 2;

%%%%%%%%%%%%        
% Plotting %
%%%%%%%%%%%%

numframes = 968;

%%
figure('units','normalized','outerposition',[0 0 1 1])

set(gca,'nextplot','replacechildren');
v = VideoWriter('PSbPI_fit_2layer_model_V2.avi');
v.FrameRate = 10;
open(v);

for i=1:numframes

    r_01234 = thinfilmlayer5(framevaluesVERSION2(i,1),framevaluesVERSION2(i,2),framevaluesVERSION2(i,3),n_3,n_4,framevaluesVERSION2(i,4),framevaluesVERSION2(i,5),d_3,wavelength);
    R_01234 = r_01234.*conj(r_01234); 
    
    subplot(4,1,1)
    plot(wavelength,refldata(i,:),wavelength,R_01234)
    axis([450 900 0 1])
    title({['PSbPI swelling 2 Layer fitting';];['Seconds =',num2str(i*10)];['MSE =',num2str(framevaluesVERSION2(i,6))]})
%     xlabel('Wavelength')
%     ylabel('Reflectance')
%     legend('Reflectance','Fresnel')


    subplot(4,1,2)
    plot((1:numframes).*10,framevaluesVERSION2(:,1),(1:i).*10,framevaluesVERSION2(1:i,1))
    axis([0 10000 1 1.3])
    yticks([1 1.1 1.2])
    legend('Ambient R-I','Ambient R-I')
    hold on
    %hline([1.1],{'k:'},{''})
    line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
    hold off
    
    subplot(4,1,3)
    plot((1:numframes).*10,framevaluesVERSION2(:,4),(1:i).*10,framevaluesVERSION2(1:i,4))
    axis([0 10000 50 125])
    yticks([50 75 100 125])
    legend('Thickness Layer 1','Running Thickness Layer 1')
    hold on
    %hline([75 100],{'k:','k:'},{'',''})
    line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
    hold off
    
    subplot(4,1,4)
    plot((1:numframes).*10,framevaluesVERSION2(:,5),(1:i).*10,framevaluesVERSION2(1:i,5))
    axis([0 10000 50 125])
    yticks([50 75 100 125])
    legend('Thickness Layer 2','Running Thickness Layer 2')
    hold on
    %hline([75 100],{'k:','k:'},{'',''})
    line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
    hold off
    
    frame = getframe(gcf);
    writeVideo(v,frame);
    
    pause(0.001);
    
end
close(v);

%%
figure('units','normalized','outerposition',[0 0 1 1])

subplot(5,1,1)
plot((1:numframes).*10,framevaluesVERSION2(:,1))
title('PS-b-PI 2 layer model')
axis([0 10000 1 1.2])
ylabel('Refractive I')
yticks([1 1.1])
legend('Air R-I')
hold on
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off

subplot(5,1,2)
plot((1:numframes).*10,framevaluesVERSION2(:,2))
axis([0 10000 1.3 1.5])
ylabel('Refractive I')
yticks([1.4])
legend('1 lay Thinfilm R-I')
hold on
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off

subplot(5,1,3)
plot((1:numframes).*10,framevaluesVERSION2(:,3))
axis([0 10000 1.3 1.5])
ylabel('Refractive I')
yticks([1.4])
legend('2nd layer Thinfilm R-I')
hold on
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off
 
subplot(5,1,4)
plot((1:numframes).*10,framevaluesVERSION2(:,4))
axis([0 10000 50 125])
ylabel('Thickness')
yticks([50 75 100 125])
legend('1st layer Thickness')
hold on
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off

subplot(5,1,5)
plot((1:numframes).*10,framevaluesVERSION2(:,5))
axis([0 10000 50 125])
xlabel('Seconds')
ylabel('Thickness')
yticks([50 75 100 125])
legend('2nd layer Thickness')
hold on
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off

%%

figure('units','normalized','outerposition',[0 0 1 1])
    plot((1:numframes).*10,framevaluesVERSION2(:,6),'b.')
    axis([0 10000 0 1])
    title('Mean square error of Polystyrene-b-polyisoprene under solvent vapour annealing')
    xlabel('Seconds')
    ylabel('Mean square error')
hold on
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
hold off

%%
totalthickness = framevaluesVERSION2(:,4) + framevaluesVERSION2(:,5);

figure('units','normalized','outerposition',[0 0 1 1])
    plot((1:numframes).*10,totalthickness,'b.')
    axis([0 10000 90 250])
    yticks([100 125 150 175 200 225])
    title('Total thickness of Polystyrene-b-polyisoprene under solvent vapour annealing')
    xlabel('Seconds')
    ylabel('Total thickness during SVA')
hold on
line1 = vline([1000 2000 3000 4000 5500 6500 7500 8500 9500],{'k:','k:','k:','r:','r:','k:','k:','k:'},{'','','','Max swelling','','','',''});
line2 = hline([100 125 150 175 200 225],{'k:','k:','k:','k:','k:','k:'},{'','','','',''})
hold off