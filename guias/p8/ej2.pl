vecino(X, Y, [X|[Y|Ls]]).
vecino(X, Y, [W|Ls]) :- vecino(X, Y, Ls).

% 1. robado de honi
/*
?- vecino(5, Y, [5,6,5,3]).
├─ ?- vecino(5, 6, [5|[6|[5,3]]]).          {X := 5, Y := 6, Ls := [5,3]}
│  └─ true.                                 {Y := 6}
└─ ?- vecino(5, Y, [6,5,3]).                {X := 5, W := 5, Ls := [6,5,3]}
   └─ ?- vecino(5, Y, [5,3]).               {X := 5, W := 6, Ls := [5,3]}
      ├─ ?- vecino(5, 3, [5|[3|[]]]).       {X := 5, Y := 3, Ls := []}
      │  └─ true.                           {Y := 3}
      └─ ?- vecino(5, Y, [3]).              {X := 5, W := 5, Ls := [3]}
         └─ ?- vecino(5, Y, []).            {X := 5, W := 3, Ls := []}
            └─ false.
*/

% 2. Si se invierte el orden de las reglas, ¿los resultados son los mismos? ¿Y el orden de los resultados?
% Si, son los mismos pero en orden inverso, porque se encuentran los de atrás primero