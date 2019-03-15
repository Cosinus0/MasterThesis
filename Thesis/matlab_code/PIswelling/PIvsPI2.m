clear all
close all



load phi.mat
load phi2.mat
figure
seconds=(1:962).*10;
plot(seconds,phi,seconds,phi2)

load frame_val2.mat
framevalues2 = framevalues;
load frame_val.mat

figure
plot(seconds,framevalues(:,3),seconds,framevalues2(:,3))
