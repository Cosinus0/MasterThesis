function [r_jkl] = thinfilmlayer3(n_j,n_k,n_l,d_k,lamda)

r_jkl = (thinfilmlayer2(n_j,n_k)+thinfilmlayer2(n_k,n_l).*exp(-2i.*filmphasethickness(lamda,n_k,d_k)))./(1+thinfilmlayer2(n_j,n_k).*thinfilmlayer2(n_k,n_l).*exp(-2i.*filmphasethickness(lamda,n_k,d_k)));

end
