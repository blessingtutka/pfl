generate([], []).
generate([Set|Rest], [Set|Subsets]) :-
    generate(Rest, Subsets).
generate([_|Rest], Subsets) :-
    generate(Rest, Subsets).

covers(_, []).  % Si l'univers (U) est vide, il est couvert
covers(S, [X|RestU]) :-
    member(Subset, S),  % Trouver un sous-ensemble contenant X
    member(X, Subset),     % Vérifier que X appartient à ce sous-ensemble
    covers(S, RestU).  % Vérifier pour le reste de l'univers

cpe(U, S, Solution) :-
    generate(S, Solution),
    covers(Solution, U),
    length(Solution, L2),
    \+ (generate(S, SmallerSolution),
        covers(SmallerSolution, U),
        length(SmallerSolution, L1),
        L1 < L2).