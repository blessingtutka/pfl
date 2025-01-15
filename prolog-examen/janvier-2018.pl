% QUESTION 3
% Le system unifie la requete avec l'entete de la regle
% Lorsqu'un interprète tente de faire correspondre une requête à une clause du programme, 
% il doit tenir compte des variables. 
% La même variable dans différentes clauses ne doit pas être considérée comme identique, car dans Prolog, 
% chaque clause est indépendante des autres. 
% C'est pourquoi un processus de renommage est nécessaire afin d'éviter les conflits de noms de variables.


% This duplicate all the even index element using 1 base indexing 
% Can also help us to remove duplicate from a list in: out in mode
d_s([],[]).
d_s([X],[X]).
d_s([X,Y|Ys],[X,Y,Y|Zs]) :- d_s(Ys,Zs).


min(List,Min) :- member(Min,List), \+((member(Element,List), Element < Min)).
