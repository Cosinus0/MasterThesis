function [beta] = filmphasethickness(lamda,n_k,d_k)

beta = (2.*pi.*d_k.*n_k)./(lamda);

end