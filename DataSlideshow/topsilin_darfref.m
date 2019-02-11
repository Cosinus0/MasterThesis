clear all
close all

load Topsilin2.drf
dark = Topsilin2;
xdark = dark(:,1);
ydark = dark(:,2);

load Topsilin2.ref
ref = Topsilin2;
xref = ref(:,1);
yref = ref(:,2);

figure
plot(xdark,ydark,xref,yref)
legend('dark','ref')
title({'Dark and Reference';'of topsil in test chamber'})
xlabel('wavelength')
ylabel('counts')

figure
plot(xdark,ydark,xref,yref+ydark)
legend('dark','ref')
title({'Dark and Reference(+plus dark)';'of topsil in test chamber'})
xlabel('wavelength')
ylabel('counts')