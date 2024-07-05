corteMasParejo(L,L1,L2) :- corte(L,L1,L2,D1), not((corte(L,_,_,D2), D2 < D1)).

corte(L, L1, L2, D) :-
    append(L1, L2, L),
    sum_list(L1, N), sum_list(L2, N2),
    D is abs(N - N2).