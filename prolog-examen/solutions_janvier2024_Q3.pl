distance(namur, bruxelles, 63.5).
distance(bruxelles, namur, 63.5).
distance(namur, berlin, 746).
distance(berlin, namur, 746).
distance(bruxelles, berlin, 758).
distance(berlin, bruxelles, 758).
distance(berlin, rome, 1503).
distance(rome, berlin, 1503).
% ... 

permutation([], []).
permutation(List, [X|Perm]) :-
    select(X, List, Rest),
    permutation(Rest, Perm).

distance_tot([_], 0).
distance_tot([City1, City2|Cities], Distance) :-
    distance(City1, City2, Dist),
    distance_tot([City2|Cities], RemainingDist),
    Distance is Dist + RemainingDist.

pvc(ShortestPath) :-
    setof(City, City2^D^distance(City,City2,D), Cities), % Récupérer toutes les villes existantes
    permutation(Cities, Permutation), % Générer une permutation
    distance_tot(Permutation, ShortestDistance), % Calculer la distance pour cette permutation
    not((permutation(Cities, Another), distance_tot(Another, Distance), Distance < ShortestDistance)), % Vérifier qu'il n'existe pas de permutation plus courte
    ShortestPath = Permutation.