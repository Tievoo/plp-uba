natural(0).
natural(suc(X)) :- natural(X).

menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
menorOIgual(X,X) :- natural(X).


% 1. Explicar qué sucede al realizar la consulta menorOIgual(0,X).
/*  Se cuelga instantaneamente, porque la consulta debería ser (entiendo) de la manera menorOIgual(0, suc(X))
    Porque caso contrario, la consulta no sabe donde entrar correctamente. si el orden fuese inverso, devolvería 0 y sus correspondientes sucesores.
    En el primer caso, X intenta unificar con suc(Xn) infinitos
    Entonces, al nunca entrar el suc(suc(suc(suc(.... nunca termina
*/

% 2. Describir las circunstancias en las que puede colgarse un programa en Prolog. Es decir, ejecutarse infinitamente sin arrojar soluciones.
/*
    Al definir los casos de un predicado, el posicionamiento de los predicados es importante, ya que prolog ejecuta de arriba a abajo, de izquierda a derecha

*/

% Versión arreglada.
menorOIgual(X, X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).