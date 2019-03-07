clear all
close all

load ambRI
load PIRI

plot(ambx,amby,PIx,PIy)
title('Ambient study vs. PI swelling Refractive Index from Modelling')
xlabel('Swelling in seconds')
ylabel('Refractive Index RI')
legend('RI ambient','RI PIswelling')