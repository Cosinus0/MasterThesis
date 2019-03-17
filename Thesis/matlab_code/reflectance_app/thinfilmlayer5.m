function [r_jklmn] = thinfilmlayer5(n_j,n_k,n_l,n_m,n_n,d_k,d_l,d_m,lamda)

r_jklmn = (thinfilmlayer2(n_j,n_k) + thinfilmlayer4(n_k,n_l,n_m,n_n,d_l,d_m,lamda).*exp(-2i.*filmphasethickness(lamda,n_k,d_k)))./ (1 + thinfilmlayer2(n_j,n_k).*thinfilmlayer4(n_k,n_l,n_m,n_n,d_l,d_m,lamda).*exp(-2i.*filmphasethickness(lamda,n_k,d_k))); 

end
