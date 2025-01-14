% PLAN DE TABLE
% QUESTION 1 - 6
% isAtLeftOf(x,y) <=> x est a gauche de y
% isAtLeftOf est un predicat d'arite 1 = isAtLeftOf\1
isAtLeftOf(jean,mark).
isAtLeftOf(mark,eve).
isAtLeftOf(eve,charline).
isAtLeftOf(charline,romain).
isAtLeftOf(romain,boris).
isAtLeftOf(boris,clea).
isAtLeftOf(clea,ivan).
isAtLeftOf(ivan,lucy).
isAtLeftOf(lucy,anthon).
isAtLeftOf(anthon,jean).

boy(jean).
boy(mark).
boy(romain).
boy(boris).
boy(ivan).
boy(anthon).


girl(eve).
girl(charline).
girl(clea).
girl(lucy).

% A GAUCHE RECURSIVITY 
atLeaftof(X,Y) :- isAtLeftOf(X,Y).   %Base case
atLeaftof(X, Z) :- isAtLeftOf(X, Y), atLeaftof(Y, Z), X \= Z. 

% isAtRight\2
isAtRight(X,Y) :- isAtLeftOf(Y,X).

% Reciprocite
voisin(X,Y) :- isAtLeftOf(X,Y).
voisin(X,Y) :- isAtLeftOf(Y,X).

% wish\1

wish(X) :- girl(X), voisin(X,Y), boy(Y), voisin(X,Z),boy(Z), Y \= Z.
wish(X) :- boy(X), voisin(X,Y), girl(Y), voisin(X,Z),girl(Z), Y \= Z.

% ARBRE GENEALOGIQUE

% QUESTION 7 - 9
moi(luca).

men(aengus).
men(luca).
men(osheen).
men(sloan).
men(pierre).

women(macha).
women(rosheen).
women(seena).

% est parent de parent/2
parent(aengus,luca).
parent(aengus,macha).

parent(luca,rosheen).
parent(luca,osheen).
parent(luca,sloan).

parent(rosheen,pierre).

parent(macha,seena).

% X is the sibling of Y
sibling(X,Y) :- parent(Z,X), parent(Z,Y).

% X is the mother of Y
mother(X,Y) :- women(X), parent(X,Y).

% X is the father of Y
father(X,Y) :- men(X), parent(X,Y).

% X is the brother of Y
brother(X,Y) :- men(X), sibling(X,Y).

% X is the sister of Y
sister(X,Y) :- women(X), sibling(X,Y).

% X is the uncle of Y
uncle(X,Y) :- men(X), sibling(X,Z), parent(Z,Y).

% X is the aunt of Y
aunt(X,Y) :- women(X), sibling(X,Z), parent(Z,Y).

% X is the grandparent of Y
grandparent(X,Y) :- parent(X,Z), parent(Z,Y).

% X is the cousin of Y
cousin(X,Y) :- parent(Z,X), parent(V,Y), sibling(Z,V).
cousin(X,Y) :- oncle(Z,X), parent(Z,Y).
cousin(X,Y) :- aunt(Z,X), parent(Z,Y).


mariable(X, Y) :-
    X \= Y, % X et Y doivent être des personnes différentes
    \+ parent(X, Y), % Pas de lien de parenté en ligne directe
    \+ parent(Y, X),
    \+ grandparent(X, Y), % Pas de lien grand-parent/petit-enfant
    \+ grandparent(Y, X),
    \+ sibling(X, Y), % Pas de frère/sœur
    \+ uncle(X, Y), % Pas d'oncle/nièce ou tante/neveu
    \+ uncle(Y, X),
    \+ aunt(X, Y),
    \+ aunt(Y, X).


% X est directement parent de Y : degré 1
degre(X, Y, 1) :- parent(X, Y).

% X est grand-parent de Y : degré 2
degre(X, Y, 2) :- parent(X, Z), parent(Z, Y).

% X et Y ont un parent commun : degré 2 (frères/sœurs)
degre(X, Y, 2) :- sibling(X, Y).

% X est oncle ou tante de Y : degré 3
degre(X, Y, 3) :- parent(Z, Y), sibling(X, Z).

% X est cousin de Y : degré 4
degre(X, Y, 4) :- cousin(X, Y).

% Relation symétrique
degre(X, Y, D) :- degre(Y, X, D).

mariable(X, Y) :-
    X \= Y,
    \+ (degre(X, Y, D), D =< 3).

