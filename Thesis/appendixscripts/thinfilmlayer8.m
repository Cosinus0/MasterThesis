function [r_jklmnopq] = thinfilmlayer8(n_j,n_k,n_l,n_m,n_n,n_o,n_p,n_q,d_k,d_l,d_m,d_n,d_o,d_p,lamda)

r_jklmnopq = (thinfilmlayer2(n_j,n_k) + thinfilmlayer7(n_k,n_l,n_m,n_n,n_o,n_p,n_q,d_l,d_m,d_n,d_o,d_p,lamda)
.*exp(-2i.*filmphasethickness(lamda,n_k,d_k)))./ (1 + thinfilmlayer2(n_j,n_k)
.*thinfilmlayer7(n_k,n_l,n_m,n_n,n_o,n_p,n_q,d_l,d_m,d_n,d_o,d_p,lamda)
.*exp(-2i.*filmphasethickness(lamda,n_k,d_k))); 

end
