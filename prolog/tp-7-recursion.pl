
% QUESTION 13
fact(0,1).
fact(N,_) :- N>0, fail.
fact(N,F) :- N1 is N-1 ,fact(N1,F1), F is N*F1.

% ARGS + INITIAL VALUE OF THE ACCUMULATOR
factTerm(N,F) :- N>0, factAux(N,F,1).
factAux(0,Acc,Acc).
factAux(N,F,Acc) :- N1 is N - 1, AccP is Acc * N ,factAux(N1, F, AccP).

% QUESTION 14
power(B,1,B).
power(B,N,R) :- N1 is N - 1, power(B,N1,R1), R is B*R1.

% Be do the terminal recursivity by adding and accumulator with innitial value to difine it recursivly by updating it and reducing the problem
powerTerm(B,N,R) :- powerAux(B,N,R,1).
powerAux(_,0,R,R).
powerAux(B,N,R,Acc) :- N>0, N1 is N - 1, Acc1 is Acc*B ,powerAux(B,N1,R,Acc1).

% QUESTION 15
% mod(E1,E2,Result) :- Result is E1 - (E1 div E2) * E2.
% diviseur(N,D) :- D>0, mod(N,D,0).

% Using buildin function
diviseurs(N, Diviseurs) :-
    findall(D, (between(1, N, D), diviseur(D, N)), Diviseurs).

divisors(N, Current, []) :- Current > N, !.

divisors(N, Current, [Current|Tail]) :- % si c'est egale a zero on ajouter current au debut
    N mod Current =:= 0,
    Next is Current + 1,
    divisors(N, Next, Tail).
divisors(N, Current, Tail) :- % si c'est different de 0, on fait rien
    N mod Current =\= 0,
    Next is Current + 1,
    divisors(N, Next, Tail).
sumDiv([],0).
sumDiv([H|T],S) :- sumDiv(T,SP), S is SP + H. 
lenDiv([],0).
lenDiv([_|T],L) :- sumDiv(T,LP), L is LP + 1. 

parfais(N) :- divisors(N,1,Divisors), sumDiv(Divisors,S), S =:= N*2.
sublime(X) :- 

% QUESTION 16
decompte(0) :- 
    format('0'). 
decompte(N) :- 
    N > 0, 
    format('~w,', [N]),
    N1 is N - 1, 
    decompte(N1).

% QUESTION 17
sum(N,R) :- sumAux(N,R,N).

sumAux(0,Acc,Acc).
sumAux(N,R,Acc) :-  N1  is N-1, AccR is Acc + N, sumAux(N1,R,AccR).
