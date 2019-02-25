clear all
close all

load PSreflectance
refldata=transpose(PSreflectance);

%Nan files - But they are just included in bo's dat file.
%PSmodel=load('/home/nathan/Documents/GitHub/MasterThesis/Thesis/matlab_code/PolystyreneSwelling/PolystyreneSwellingData/nanFiles/PSmodel')
%modeldata = transpose(PSmodel)

wave = [400:1041];

figure
for i=1:471
plot(wave,refldata(:,i));
axis([450 900 0 1])
title([num2str(i*10) 'Seconds'])
pause(0.1);
end