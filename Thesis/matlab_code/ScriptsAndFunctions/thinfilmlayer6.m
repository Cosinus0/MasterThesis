function [r_jklmno] = thinfilmlayer6(n_j,n_k,n_l,n_m,n_n,n_o,d_k,d_l,d_m,d_n,lamda)

r_jklmno = (thinfilmlayer2(n_j,n_k) + thinfilmlayer5(n_k,n_l,n_m,n_n,n_o,d_l,d_m,d_n,lamda).*exp(-2i.*filmphasethickness(lamda,n_k,d_k)))./ (1 + thinfilmlayer2(n_j,n_k).*thinfilmlayer5(n_k,n_l,n_m,n_n,n_o,d_l,d_m,d_n,lamda).*exp(-2i.*filmphasethickness(lamda,n_k,d_k))); 

end
