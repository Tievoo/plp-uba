vacio(nil).

raiz(bin(_, V, _), V).

altura(nil, 0).
altura(bin(I, _, D), A) :- altura(I, Ai), altura(D, Ad), A is  1+max(Ai, Ad).

cantidadDeNodos(nil, 0).
cantidadDeNodos(bin(I, _, D), C) :- cantidadDeNodos(I, Ci), cantidadDeNodos(D, Cd), C is Ci + Cd + 1.

% Ej 13

inorder(nil, []).
inorder(bin(I, V, D), L) :- inorder(I, Li), inorder(D, Ld), append(Li, [V|Ld], L).

arbolConInorder([], nil).
arbolConInorder(L, bin(I, V, D)) :- append(Li, [V|Ld], L), arbolConInorder(Li, I), arbolConInorder(Ld, D).

aBB(nil).
aBB(bin(nil, _, nil)).
aBB(bin(bin(_, Vi, _), V, nil)) :- Vi < V, aBB(bin(_, Vi, _)).
aBB(bin(nil, V, bin(_, Vd, _))) :- Vd > V, aBB(bin(_, Vd, _)).
aBB(bin(bin(_, Vi, _), V, bin(_, Vd, _))) :- Vi < V, Vd > V, aBB(bin(_, Vi, _)), aBB(bin(_, Vd, _)).
