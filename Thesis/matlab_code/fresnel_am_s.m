function [r_jkp,r_jks,t_jkp,t_jks] = fresnel_am_s(n_j,n_k,theta_j,theta_k)

r_jkp = (n_k.*cosd(theta_j)-n_j.*cosd(theta_k))./(n_k.*cosd(theta_j)+n_j.*cosd(theta_k));
r_jks = (n_j.*cosd(theta_j)-n_k.*cosd(theta_k))./(n_j.*cosd(theta_j)+n_k.*cosd(theta_k));

t_jkp = (2.*n_j.*cosd(theta_j))./(n_k.*cosd(theta_j)+n_j.*cosd(theta_k));
t_jks = (2.*n_j.*cosd(theta_j))./(n_j.*cosd(theta_j)+n_k.*cosd(theta_k));

end
