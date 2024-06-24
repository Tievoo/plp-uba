padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X,Y) :- padre(X,Z), padre(Z,Y).

% 1. ¿Cuál el resultado de la consulta abuelo(X, manuel)?
% X = juan
% false.

% 2. A partir del predicado binario padre, definir en Prolog los predicados binarios: hijo, hermano y descendiente.

hijo(X,Y) :- padre(Y,X).
hermano(X,Y) :- padre(Z,X), padre(Z,Y), X \= Y.

descendiente(X,Y) :- hijo(X,Y).
descendiente(X,Y) :- hijo(X,Z), descendiente(Z,Y).

% 3. Dibujar el árbol de búsqueda de Prolog para la consulta descendiente(Alguien, juan).
% meh

% 4. ¿Qué consulta habría que hacer para encontrar a los nietos de juan?
% abuelo(juan, X).

% 5. ¿Cómo se puede definir una consulta para conocer a todos los hermanos de pablo?
% hermano(pablo, X). o hermano(X, pablo).

% 6. Considerar el agregado del siguiente hecho y regla: (esto está mal)
% ancestro(X, X).
% ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).

% 7. Explicar la respuesta a la consulta ancestro(juan, X). ¿Qué sucede si se pide más de un resultado?
% El código se cuelga al entrar en un loop infinito. No se identificar exactamente que está mal, probablemente el orden de los
% predicados en la segunda linea?, al hacer ancestro de Z, Y con ancestro de (X,X) siendo true capaz loopea? Ya que despues de unificar
% X = Juan en la linea 32, vuelve a llamarlo como posible candidato y loopea, buscando el padre del padre del padre infinitamente después de encontrar
% a los nietos.

% 8. Sugerir un solución al problema hallado en los puntos anteriores reescribiendo el programa de ancestro.
% Versión arreglada, que evita el loopeo de busquedas de padres, solo cambiando el orden del segundo predicado
ancestro(X, X).
ancestro(X, Y) :- padre(X, Z), ancestro(Z, Y).

