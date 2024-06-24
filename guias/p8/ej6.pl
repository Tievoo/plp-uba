% aplanar(+Xs, -Ys)
% aplanar([X|Xs], [X|Xs]).
% aplanar([], Ys).
aplanar([], []).
aplanar([Zs|Xs], Ys) :- aplanar(Zs,As), aplanar(Xs, Rs), append(As, Rs, Ys).  % con el aplanar no solo veo si es una lista sino q tambien la aplano
aplanar([X|Xs], Ys) :- not(aplanar(X, _)), aplanar(Xs, Rs), append([X], Rs, Ys). %si no es lista, no se puede aplanar

%macheteado d honi mostly :p
