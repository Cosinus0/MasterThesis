clear all
close all

wavelength = (150:1600);
micrometerwl = wavelength./1000;

% PSPI No.1
A1 = 1.6;
B1 = 0.03417;
C1 = -0.00149;

n_1 = cauchy(micrometerwl,A1,B1,C1)
diff1 = n_1(301)-A1;

% PI No.2
A2 = 1.522;
B2 = 0.00203;
C2 = 0.00045518;

n_2 = cauchy(micrometerwl,A2,B2,C2)
diff2 = n_2(301)-A2;

% PS No.3
A3 = 1.596;
B3 = -0.00220;
C3 = 0.00101;

n_3 = cauchy(micrometerwl,A3,B3,C3)
diff3 = n_3(301)-A3;

%Nanocalc cauchy
A4 = 1.4450;
B4 = 3e4;
C4 = 4e7;

n_4 = cauchy(wavelength,A4,B4,C4)

%%%%%%%%%%%%
% Plotting %
%%%%%%%%%%%%

figure('units','normalized','outerposition',[0 0 1 1])
subplot(4,1,1)
plot(wavelength,n_1)
axis([150 1600 0 2])
yticks([0 1 1.6 2])
title('Polystyrene-b-Polyisoprene')
xlabel('Wavelength')
ylabel('Refractive index')

hold on
hline(1.6,'b:','')
hold off



subplot(4,1,2)
plot(wavelength,n_2)
axis([150 1600 1 3])
yticks([1 1.522 2 3])
title('Polyisoprene')
xlabel('Wavelength')
ylabel('Refractive index')

hold on
hline(1.522,'b:','')
hold off



subplot(4,1,3)
plot(wavelength,n_3)
axis([150 1600 1 4])
yticks([1 1.596 2 3 4])
title('Polystyrene')
xlabel('Wavelength')
ylabel('Refractive index')

hold on
hline(1.596,'b:','')
hold off



subplot(4,1,4)
plot(wavelength,n_4)
axis([150 1600 1 3])
yticks([1 1.4450 2 3])
title('Nano-Calc Cauchy')
xlabel('Wavelength')
ylabel('Refractive index')

hold on
hline(1.4450,'b:','')
hold off


figure('units','normalized','outerposition',[0 0 1 1])

subplot(3,1,1)
plot(wavelength,n_3)
title('Polystyrene')
xlabel('Wavelength')
ylabel('Refractive index')
yticks([1.5 1.596 1.7])
axis([380 900 1.5 1.7])
hold on
hline(1.596,'b:','')
vline(450,'r:','0.0138')
hold off

subplot(3,1,2)
plot(wavelength,n_2)
title('Polyisoprene')
xlabel('Wavelength')
ylabel('Refractive index')
yticks([1.5 1.522 1.55 1.6])
axis([380 900 1.5 1.6])
hold on
hline(1.522,'b:','')
vline(450,'r:','0.0211')
hold off

subplot(3,1,3)
plot(wavelength,n_1)
title('Polystyrene-b-Polyisoprene')
xlabel('Wavelength')
ylabel('Refractive index')
yticks([1.5 1.6 1.7 1.8])
axis([380 900 1.5 1.8])
hold on
hline(1.6,'b:','')
vline(450,'r:','0.1324')
hold off


% subplot(4,1,4)
% plot(wavelength,n_4)
% title('Nano-Calc Cauchy')
% xlabel('Wavelength')
% ylabel('Refractive index')
% yticks([1.4 1.4450 1.6 1.8])
% axis([380 900 1.4 1.8])
% hold on
% hline(1.4450,'b:','')
% hold off