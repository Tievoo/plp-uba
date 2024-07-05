% coprimos(-X, -Y)
coprimos(X, Y) :- generarPares(X, Y), sonCoprimos(X, Y).

sonCoprimos(X, Y) :- Z is gcd(X, Y), Z =:= 1.

%robo el generar pares de la practica
% generarPares(-X, -Y): genera todos los pares (X,Y).
generarPares(X, Y) :- desde(2, S), S2 is S-1, between(1, S2, X), Y is S-X.

desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y).