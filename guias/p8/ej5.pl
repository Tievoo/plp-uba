% last(?L, ?U)
% last([U|[]], U) :- true.
% last([X|XS], U) :- last(XS, U).

% me pidieron que use append igual?

last(L, U) :- append(_, [U], L).

% reverse(+L, -L1)
reverse([], []).
reverse([X|XS], R) :- reverse(XS, R2), append(R2, [X], R).

% prefijo(?P, +L)
prefijo(P, L) :- append(P, _, L).

%sufijo(?S, +L)
sufijo(S, L) :- append(_, S, L).

%sublista(?S, +L)
sublista([], _).
sublista([X|XS], L) :- prefijo(P, L), sufijo([X|XS], P).

% pertenece(?X, +L)
pertenece(X, L) :- sublista([X], L).