function n_c = cauchy(lamda,A,B,C)

n_c = A + (B./(lamda.^2)) + (C./(lamda.^4));

end
