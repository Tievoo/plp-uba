% intersección(+L1, +L2, -L3)
interseccion([], _ , []).
interseccion([X|L1],L2,L3) :- not(member(X, L2)), interseccion(L1, L2, L3).
interseccion([X|L1],L2,[X|L3]) :- member(X, L2), borrar(L1, X, T1), interseccion(T1, L2, L3).


borrar([],_,[]).
borrar([X|XS], X, RS) :- borrar(XS,X,RS).
borrar([X|XS], Y, [X|RS]) :- X \= Y, borrar(XS, Y, RS).