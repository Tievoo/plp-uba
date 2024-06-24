% juntar(?L1, ?L2, ?L3)
juntar([],LS,LS) :- true.
juntar([X|XS], Y, [X|XZ]) :- juntar(XS, Y, XZ).