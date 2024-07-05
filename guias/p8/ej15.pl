%cuadradoSemiLatino(+N, -XS)
cuadradoSemiLatino(N, XS) :- desde(0, K), length(XS, N), filassuman(N, K, XS).

filassuman(_,_, []).
filassuman(N, K, [X|Xs]) :- sum(N, K, X), filassuman(N, K, Xs).

% sum(+N, +K, -F): Instancia F en todas las filas de largo N que suman K.
% Robado de honi, basado en el generador de sumas que hicimos con arboles en el repaso
sum(0, 0, []).
sum(N, K, [X|Xs]) :-
    N > 0,
    between(0, K, X),
    K2 is K-X,
    N2 is N-1,
    sum(N2, K2, Xs).


% desde(+X, -Y): instancia Y en todos los números naturales >= X.
desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y).


% ii. Definir utilizando Generate & Test el predicado cuadradoMagico(+N, -XS), que instancia XS con cuadrados cuyas filas y columnas suman todas un mismo valor.

cuadradoMagico(N, XS) :- cuadradoSemiLatino(N, XS), nth0(0, XS, X), sum_list(X, K), not((between(1, N, I), columna(I, XS, Col), sum_list(Col, K2), K \== K2)). 

columna(_, [], []).
columna(N, [X|Xs], [Y|Ys]) :- nth1(N, X, Y), columna(N, Xs, Ys).