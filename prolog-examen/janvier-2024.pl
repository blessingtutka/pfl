distance(namur, bruxelles, 63.5).
distance(bruxelles, namur, 63.5).
distance(namur, berlin, 746).
distance(berlin, namur, 746).
distance(bruxelles, berlin, 758).
distance(berlin, bruxelles, 758).
distance(berlin, rome, 1503).
distance(rome, berlin, 1503).

% permutation([], []).
% permutation([X|Xs], Ys) :- select(X,Ys,Rest) , permutation(Xs, Rest).
permutation([], []).
permutation(List, [X|Perm]) :-
    select(X, List, Rest),
    permutation(Rest, Perm).

distance_totale([],0).
distance_totale([Ville|Villes],Distance) :- 
    append([Ville|Villes], [Ville], CercleVilles), distance_totale_aux(CercleVilles,Distance,0).

distance_totale_aux([_],Acc,Acc).    
distance_totale_aux([Ville1,Ville2|Villes],Distance,Acc) :- 
        distance(Ville1, Ville2, Espace),
        NewAcc is Acc + Espace,
        distance_totale_aux(Villes,Distance,NewAcc).

distance_tot([_], 0).
distance_tot([City1, City2|Cities], Distance) :-
    distance(City1, City2, Dist),
    distance_tot([City2|Cities], RemainingDist),
    Distance is Dist + RemainingDist.


pvc(Shortest) :- setof(Ville,distance(Ville,_,_),Villes), 
                permutation(Villes,Routes), distance_tot(Routes,ShortestDistance),
                \+((permutation(Villes,AutreRoutes), distance_tot(AutreRoutes,Distance), Distance < ShortestDistance)),
                Shortest = Routes.
