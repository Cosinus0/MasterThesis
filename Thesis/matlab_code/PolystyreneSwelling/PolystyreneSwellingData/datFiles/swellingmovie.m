clear all
close all

load PSreflectance
data=transpose(PSreflectance);

wave = [400:1041];

figure
for i=1:471
plot(wave,data(:,i));
axis([450 900 0 1])
title([num2str(i*10) 'Seconds'])
pause(0.5);
end