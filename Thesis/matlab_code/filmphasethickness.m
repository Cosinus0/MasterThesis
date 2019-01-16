function [beta] = filmphasethickness(lamda,n_k,theta_k,d)

beta = (2.*pi.*d.*n_k.*cosd(theta_k))./(lamda);

end