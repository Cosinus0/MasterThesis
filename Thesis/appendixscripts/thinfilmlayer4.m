function [r_jklm] = thinfilmlayer4(n_j,n_k,n_l,n_m,d_k,d_l,lamda)

r_jklm = (thinfilmlayer2(n_j,n_k) + thinfilmlayer3(n_k,n_l,n_m,d_l,lamda)
.*exp(-2i.*filmphasethickness(lamda,n_k,d_k)))./ (1 + thinfilmlayer2(n_j,n_k).*thinfilmlayer3(n_k,n_l,n_m,d_l,lamda)
.*exp(-2i.*filmphasethickness(lamda,n_k,d_k))); 

end
