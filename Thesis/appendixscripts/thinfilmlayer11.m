function [r_jklmnopqrst] = thinfilmlayer11(n_j,n_k,n_l,n_m,n_n,n_o,n_p,n_q,n_r,n_s,n_t,
d_k,d_l,d_m,d_n,d_o,d_p,d_q,d_r,d_s,lamda)

r_jklmnopqrst = (thinfilmlayer2(n_j,n_k) + thinfilmlayer10(n_k,n_l,n_m,n_n,n_o,n_p,n_q,n_r,n_s,n_t,
d_l,d_m,d_n,d_o,d_p,d_q,d_r,d_s,lamda)
.*exp(-2i.*filmphasethickness(lamda,n_k,d_k)))./ (1 +thinfilmlayer2(n_j,n_k)
.*thinfilmlayer10(n_k,n_l,n_m,n_n,n_o,n_p,n_q,n_r,n_s,n_t,
d_l,d_m,d_n,d_o,d_p,d_q,d_r,d_s,lamda)
.*exp(-2i.*filmphasethickness(lamda,n_k,d_k))); 

end
