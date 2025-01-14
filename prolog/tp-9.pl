:- encoding(utf8).
:- use_module(musique).
:- use_module(mots).
% GENERATE AND TEST

% Question 1
% chanson/5 chanson(artiste,title, type,country,time)
% artiste(out,out)
artiste(X,Y) :- chanson(X,_,_,Y,_).

% Question 2
% Mc = Minute Courte, Sc: Second Courte
courte(M,Mc,_,_) :- M < Mc.
courte(M,Mc,S,Sc) :- M = Mc, S < Sc.
chanson_courte(Titre,temps(Mc,Sc)) :- chanson(_,Titre,_,_,temps(M,S)), courte(M,Mc,S,Sc).

% Question 3
trio(T1,T2,T3,Tp) :- 
    chanson_courte(T1,Tp), 
    chanson_courte(T2,Tp), 
    chanson_courte(T3,Tp), 
    chanson(_,T1,St1,P1,_),
    chanson(_,T2,St2,P2,_),
    chanson(_,T3,St3,P3,_),
    T1 \= T2,
    T2 \= T3,
    St1 \= St2,
    St2 \= St3,
    P1 \= P2,
    P2 \= P3.

% Question 4
buy([],[],0).
buy([T | Titres],[Mg | Magasins],PrixTotal) :- disponible(T,Mg,PrixUnitaire), 
                                                buy(Titres,Magasins,PrixTotalPartiel), 
                                                PrixTotal is PrixTotalPartiel + PrixUnitaire.

% Question 5
chanson_europe(Magasin,Titre) :- disponible(Titre,Magasin, _), chanson(_,Titre,_,fr,_).
chanson_europe(Magasin,Titre) :- disponible(Titre,Magasin, _), chanson(_,Titre,_,be,_).

% Question 6
% Le not nous permet de transformer une request pour tout en existentielle
% Ici je vais cherche un magasin qui n'a aucun magasin dont le prix est plus petit que lui.
cheap(Titre,Magasin) :-  disponible(Titre,Magasin,Prix), \+((disponible(Titre,_,Prix2), Prix2 < Prix )).

best_sell([], [], 0).
best_sell([Titre|Titres], [Magasin|Magasins], Prix) :-
    cheap(Titre, Magasin),
    disponible(Titre, Magasin, PrixMag), 
    best_sell(Titres, Magasins, PrixRecursif), 
    Prix is PrixMag + PrixRecursif.

% MOTS
% Question 7
% DET1 NOM1 ADJ1 V1 DET2 NOM2 ADJ2
% Faites en sorte que DET1 et NOM1 aient le même genre et nombre, qu'ils s'accordent avec ADJ1 en
% genre et nombre, et avec V1 en nombre. Il faut que DET2, NOM2 et ADJ2 aient aussi le même genre
% et nombre. De plus, faites en sorte qu'il n'y ait pas deux mots identiques dans la phrase.
% verbe(colportera,indicatif,futursimple,singulier,3).

phrase(DET1,NOM1,ADJ1,V1,DET2,NOM2,ADJ2) :- 
                determinant(DET1,G1,N1),
                nom(NOM1,G1,N1), 
                adjectif(ADJ1,G1,N1),
                verbe(V1,_,_,N1,_),                
                determinant(DET2,G2,N2),
                nom(NOM2,G2,N2), 
                adjectif(ADJ2,G2,N2),
                DET1 \= DET2,
                NOM1 \= NOM2,
                ADJ1 \= ADJ2,
                format('~w ~w ~w ~w ~w ~w ~w.', [DET1,NOM1,ADJ1,V1,DET2,NOM2,ADJ2]).

% Question 8
% monnaie/2
sum([],0).
sum([H|T],S) :- sum(T,Sp), S is Sp + H.
monnaie(Pieces,Billets) :- sum(Pieces, S), S =:= Billets.

% Question 9
% Konogan, 30 ans, aime Élisabeth et Charlotte
% Manu, 24 ans, aime Sandrine et Charlotte
% Sandrine, 23 ans, aime Manu et Konogan
% Élisabeth, 21 ans, aime Manu
% Charlotte, 58 ans, aime Manu et Konogan


personne('Konogan',30).
personne('Manu',24).
personne('Sandrine',23).
personne('Charlotte',58).
personne('Élisabeth',21).

aime('Konogan','Élisabeth').
aime('Konogan','Charlotte').
aime('Manu','Sandrine').
aime('Manu','Charlotte').
aime('Sandrine','Manu').
aime('Sandrine','Konogan').
aime('Élisabeth','Manu').
aime('Charlotte','Manu').
aime('Charlotte','Konogan').

match(X,Y) :- aime(X,Y), aime(Y,X).

difference(X,Y,D) :- personne(X,A1), personne(Y,A2), A1 >= A2 ,D is A1 - A2.
difference(X,Y,D) :- personne(X,A1), personne(Y,A2), A2 >= A1 ,D is A2 - A1.
% Qu'il n'y ai pas d'autre match dont la diffrent est plus pettit que le match demander.
bestMatch(X,Y) :- match(X,Y), difference(X,Y,D), \+((match(X1,Y1),difference(X1,Y1,D2), D2 < D)).  