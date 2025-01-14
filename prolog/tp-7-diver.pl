% QUESTION 10
% street from 1 to 2
connected(1,2).
connected(3,4).
connected(5,6).
connected(7,8).
connected(9,10).
connected(12,13).
connected(13,14).
connected(15,16).
connected(17,18).
connected(19,20).
connected(4,1).
connected(6,3).
connected(4,7).
connected(6,11).
connected(14,9).
connected(11,15).
connected(16,12).
connected(14,17).
connected(16,19).

chemin(X,Y) :- connected(X,Y).
chemin(X,Y) :- connected(X,Z), chemin(Z,Y).

% QUESTION 11
naturel(zero).
naturel(successeur(Y)) :- naturel(Y).
% naturel(X) :- X = successeur(Y) , naturel(Y).

greater(X,zero) :- naturel(X).
greater(successeur(X),zero) :- naturel(X).
greater(successeur(X),successeur(Y)) :- greater(X,Y). %recursive reduction

sum(zero,zero,zero).
sum(successeur(X), zero, successeur(X)).
sum(zero,successeur(Y),successeur(Y)).
% somme(successeur(X), Y, successeur(Z)) :- somme(X, Y, Z).
sum(successeur(X),successeur(Y),S) :- naturel(X), naturel(Y), sum(X,Y,S1), S = successeur(successeur(S1)).

product(successeur(_), zero, zero).
product(zero, successeur(_), zero).
product(successeur(X),Y,P) :-  product(X, Y, P1), sum(Y, P1, P).

% Reduice until one of then is Zero 
differenceAbsolue(zero, X, X) :- naturel(X).
differenceAbsolue(X, zero, X) :- naturel(X).
differenceAbsolue(successeur(X), successeur(Y), Z) :- differenceAbsolue(X, Y, Z).

% QUESTION 12

% X est victime du malandrim le Y => malandrin_victime\2
malandrin_victime(macha,mardi,eglise).
malandrin_victime(sloan,mercredi,pub).
malandrin_victime(lucatmel,vendredi,home).
% X est pauvre => pauvre\1
pauvre(aengus).
% X est jaloux de Y => jalousie\2
jalousie(roshen,macha).
% X etais present au pub le Y => present_pub\2
present(aengus,jeudi,pub).
present(pierre,mercredi,pub).
present(roshen,mardi,eglise).

suspect(X) :- malandrin_victime(_,D,P), present(X,D,P), pauvre(X).
suspect(X) :- malandrin_victime(Y,D,P), present(X,D,P), jalousie(X,Y).

