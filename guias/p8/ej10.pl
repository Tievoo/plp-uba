desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

%% i. ¿Cómo deben instanciarse los parámetros para que el predicado funcione? (Es decir, para que no se cuelgue
%% ni produzca un error). ¿Por qué?
/*
    Para que no haya un error, debe estar definido X necesariamente, e Y no definido, ya que de no ser así, desde(X,Y) intenta hacer una
    operación aritmetica con X, lo cual no es posible si X no está definido. La excepción a esto es cuando se llama desde(X,X), pero eso es un solo caso, y 
    despues tira error. Por otro lado, si Y está definido, el prorgrama se cuelga, probrablemente por intentar hacer backtracking con un valor fijo.
*/

%% ii. Dar una nueva versión del predicado que funcione con la instanciación desde2(+X,?Y), tal que si Y está
%% instanciada, sea verdadero si Y es mayor o igual que X, y si no lo está genere todos los Y de X en adelante.

desde2(X,X).
desde2(X,Y) :- var(Y), N is X+1, desde2(N,Y).
desde2(X,Y) :- nonvar(Y), Y >= X.

