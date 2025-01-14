
% QUESTION 18
head([H | _], H).
tail([_ | T], T).

lenList([],0).
lenList([_|T],L) :- lenList(T,LP), L is LP + 1. 
take(0,_,[]).
take(_,[],[]).
take(N,[X|L],NL) :- N1 is N-1, take(N1,L,NL2), NL = [X | NL2].
append([],L,L).
append([X|R],L,[X | NL]) :- append(R,L,NL).
% QUESTION 19
sumList([],0).
sumList([H|T],S) :- sumList(T,SP), S is SP + H. 
% QUESTION 20
swap([],[]).
swap([X],[X]).
swap([E1|[E2|L1]],[E2|[E1|L2]]) :- swap(L1,L2).
% QUESTION 21
twice([],[]).
twice([E|L1],[E|[E|L2]]) :- twice(L1,L2).