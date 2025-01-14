animal_fermier(chevre).
animal_fermier(vache).
legume(radis).
legume(carotte).
fruit(banane).
fruit(fraise).
femme(carole).
femme(chantal).
femme(huguette).
femme(yvette).
femme(mirta).
femme(vanda).
femme(claudine).
femme(yolanda).
femme(giselle).
femme(hubertine).
femme(berthe).
femme(myriam).
femme(colette).
femme(maurane).
homme(lionel).
homme(eric).
homme(jeanluc).
homme(hugo).
boulanger(hugo).
boulanger(giselle).
boulanger(berthe).
boulangere(X) :- femme(X),boulanger(X).
eleve(colette,chat).
eleve(yolanda,chat).
eleve(eric,chevre).
eleve(jeanluc,vache).
eleve(jeanluc,cheval).
cultive(eric,radis).
cultive(eric,carotte).
cultive(eric,fraise).
cultive(lionel,palmier).
cultive(chantal,arbres_a_chat).
cultive(hugo,fraise).
agriculteur(X) :- cultive(X,Y),legume(Y).
agriculteur(X) :- cultive(X,Y),fruit(Y).
agriculteur(X) :- animal_fermier(Y),eleve(X,Y).
agricultrice1(X) :- agriculteur(X),femme(X).
agricultrice2(X) :- femme(X),agriculteur(X).
lettre(carole,jeanluc).
lettre(huguette,lionel).
lettre(yvette,lionel).
lettre(vanda,lionel).
lettre(chantal,jeanluc).
lettre(claudine,eric).
lettre(yolanda,jeanluc).
lettre(giselle,lionel).
lettre(myriam,hugo).
lettre(hubertine,hugo).
lettre(berthe,jeanluc).
lettre(colette,hugo).
lettre(maurane,hugo).
choisit(eric,claudine).
choisit(lionel,X) :- member(X,[yvette,giselle]).
choisit(jeanluc,X) :- lettre(X,jeanluc),eleve(X,chat).
choisit(jeanluc,X) :- lettre(X,jeanluc),boulangere(X).
amour_pre(X,Y) :- agriculteur(X),choisit(X,Y).