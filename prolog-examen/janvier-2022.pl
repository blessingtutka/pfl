% Question 2
chem([(A,B)],A,B).
chem([(A,Y)|Ls],A,B) :- chem(Ls,Y,B).

% Question 3

example_game(Game) :- Game=[
    room(1,true,[
        puzzle('A',true,'Trouver le bouton cache dans la pièce',
        clue('Regardezenl\'air',puzzle('B'))),
        puzzle('B',false,'Déchiffrer le message inscrit sur le plafond',
        clue('Ecoutez bien', puzzle('C'))),
        puzzle('C',false,'Ouvrir laporte aumoment où un son retentit',
        clue('C\'est ouvert',room(2)))
    ]),
    room(2,false,[
        puzzle('D',true,'Appuyer sur des lettres pour former un mot',
        clue('Bravo, la porte finale est ouverte',room(3)))
    ]),
    room(3,false,fini)
].

verif:- % un jeu est vérifié si
    example_game(Game),
    start_room(Game,S1), % il y a une salle dedépart
    end_room(Game,SEnd), % et une d'arrivée
    solve_game(Game,[],S1,SEnd), % telles qu'on trouve unc hemin entre les deux
    !.

%%%%
%% Utilisez generate & test pour trouver unes allededépart.
%% Ils'agit d'une salle de la forme room(_,true,_)
%%%%
% but d'utilisation:(in,out)
start_room(Game,S):- member(S,Game), S = room(_,true,_). 
...
%%%%
%% Utilisez generate & test pour trouver la salle de fin.
%% Ils'agit de la salle de la forme room(_,_,fin)
%%%%
end_room(Game,S):- member(S,Game), S = room(_,_,fin).
...
% solve_game/4 résout le jeu d'une salle(le troisième argument)
% à une autre (le quatrième argument), si possible
solve_game(_,_,SEnd,SEnd). % Une salle à elle-même -> résolu
solve_game(Game,CurrentClues,S1,SEnd):-
member(S2,Game), % Il faut qu'il existe une salle intermédiaire
S1\=S2, % différente de S1 et telleque les indices de S1 puissent meneràS2
solve_between_rooms(S1,S2,CurrentClues,UpdatedClues),
% et qu'il existe un chemin entre S2 et SEnd
solve_game(Game,UpdatedClues,S2,SEnd).

% Cherche à prouver qu'il existe un chemin qui mène d'une salle à l'autre au travers d'indices successifs
solve_between_rooms(S1,S2,CurrentClues,UpdatedClues):-
% On prend tous les indices qui peuvent être trouvés en résolvant des énigmes accessibles dans S1
accessible_clues(S1,CluesRoom),
% On les ajoute aux indices déjà trouvés parailleurs
append(CurrentClues,CluesRoom,UpdatedClues),
%Et on vérifie si dans ces indices, il y en a un qui mène à S2
clues_lead_to_room(UpdatedClues,S2).
%%%%
%% Utilisez un appel à findall/3 et un appel à follow_clues/4 pour
%%trouver l'ensemble des indices que l'on puisse suivre dans lasalle
%%%%
accessible_clues(room(_,_,Puzzles),CluesRoom):-
% On trouve tous les indices des énigmes directement accessibles dans la salle, au moyen d'unfindall/3
findall(I,member(puzzle(_,true,_,I),Puzzles),Clues),

% Et on appel le follow_clues/4, en passant en argument les indices trouvés par le findall/3
follow_clues(Clues,Puzzles,Clues,CluesRoom).
%% Suit tous les indices en premier argument, c'est-à-dire explore les indices des énigmes auxquels ils mènent, et ainsi de suite,
%% jusqu'à ce qu'il n'y ait plus d'indice à parcourir
%% Le troisième argument représente les indices déjà trouvés
%% Cela empêche d'explorer à l'infini.
follow_clues([],_,CurrentClues,CurrentClues).
follow_clues([clue(_,puzzle(Id))|StartingClues],Puzzles,CurrentClues,
RoomClues):-
select(puzzle(Id,_,_,C),Puzzles,NPuzzles),
not(member(C,CurrentClues)),
!,
follow_clues([C|StartingClues],NPuzzles,[C|CurrentClues],RoomClues).
follow_clues([_|StartingClues],Puzzles,CurrentClues,RoomClues):-
follow_clues(StartingClues,Puzzles,CurrentClues,RoomClues).

%%%%
%% Vérifiez si parmi les indices dans le premier argument,il en existe au moins un qui mène à la salle en deuxième argument
%%%%
clues_lead_to_room(AccessibleClues, Room):-
    Room = room(Id, _, _),
    member(clue(_,room(Id)), AccessibleClues).
