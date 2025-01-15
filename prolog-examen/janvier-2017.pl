% QUESTION 4

% min1/2 fonctionne correctement
min1(L,M) :- member(M,L) , \+ ((member(M1,L), M1 < M)).

% min1/2 fonctionne correctement
% utilise la recursivite simple
min2([X],X).
min2([X|Xs],X) :- min2(Xs,Y),X < Y.
min2([X|Xs],Y) :- min2(Xs,Y),X >= Y. % on ne change pas si c'est superieur


% min3/2 ne fonctionne pas correctement
% il y a des erreurs 
% il ya des varaibles singleton
% select est mal utiliser 
% min3(L,M) :- select(L,X,Ls), select(Ls,M,Lss), M=<Y . -- False

min3(L,M) :- select(M,L,Ls),\+ ((member(M2,L), M2 < M)).

% min/2 ne fonctionne pas correctement
% in it's first clause is declare as clause with arity 2 while is it use as clause with arity 3

% min4(L,M) :- min4(L,0 ,M ). -- False
% this clause go through the list by updating the current minimal munbre
% so it's second argument is the current minimal number
% utilise la recursivite terminal
min4(L,0,M).
min4([],A,A).
min4([X|Xs],A,AA) :- X < A , min4(Xs,X,AA ).
min4([X|Xs],A, AA) :- X >= A , min4(Xs,A,AA ).