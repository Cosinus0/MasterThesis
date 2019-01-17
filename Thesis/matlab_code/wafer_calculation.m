clear all
close all

nm = 10^-9;

n_0 = 1;
n_1 = 1.5;
n_2 = 5.5;
d = 450.*nm;
lamda = [400:700].*nm;

r_012 = fresnel_am_tf_s(n_0,n_1,n_2,d,lamda);

R_012 = r_012.*conj(r_012);

plot(lamda,R_012)