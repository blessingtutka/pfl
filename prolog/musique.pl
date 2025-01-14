:- encoding(utf8).
:- module(musique,[chanson/5,disponible/3]).

chanson('Red Hot Chili Peppers','On mercury',rock,usa,temps(3,28)).
chanson('Lovely Rita','Six o clock',rock,fr,temps(4,21)).
chanson('Jacques Brel','Il neige sur Liège',songwriting,be,temps(.)).
chanson('Beatles','Eleanor Rigby',rock,uk,temps(2,4)).
chanson('Carlos Santana','Black Magic Woman',rock,usa,temps(5,19)).
chanson('The Doors','Light My Fire',rock,usa,temps(7,6)).
chanson('Hubert-Felix Thiefaine','3 poemes pour Annabel Lee',songwriting,fr,temps(5,16)).
chanson('Cat Stevens','Peace Train',songwriting,usa,temps(4,13)).
chanson('Dire Straits','Sultans of Swing',rock,usa,temps(5,50)).
chanson('Bob Dylan','With God on Our Side',songwriting,usa,temps(7,8)).
chanson('Georges Brassens','La Rose, la Bouteille et la Poignee de Main',songwriting,fr,temps(4,59)).
chanson('Hubert-Felix Thiefaine','L\'agence des amants de madame Muller',songwriting,fr,temps(4,46)).
chanson('Jacques Brel','Voici',songwriting,fr,temps(4,47)).
chanson('Béruriers Noirs','Vivre libre ou mourir',rock,fr,temps(3,55)).
chanson('The Clash','Magnificient Seven',rock,uk,temps(5,28)).
chanson('Bill Callahan','Dress Sexy at my Funeral',songwriting,usa,temps(5,30)).
chanson('Jethro Tull','The Whistler',rock,uk,temps(3,31)).
chanson('Jean Ferrat','Les Poètes',songwriting,fr,temps(4,05)).
chanson('Bloodhound Gang','The Balad of Chasey Lane',rock,usa,temps(2,22)).
chanson('Bloodhound Gang','Bad Touch',rock,usa,temps(4,20)).
chanson('Fatals Picard','Mon père était tellement de gauche',songwriting,fr,temps(3,20)).
chanson('Fatals Picard','Et puis merde, je vote à droite !',rock,fr,temps(3,5)).

disponible('Et puis merde, je vote à droite !',virginMega,0.5).
disponible('The Whistler',virginMega,0.6).
disponible('L\'agence des amants de madame Muller',virginMega,0.4).
disponible('Voici',virginMega,0.3).
disponible('With God on Our Side',virginMega,0.7).
disponible('Light My Fire',virginMega,0.6).
disponible('Black Magic Woman',virginMega,0.8).
disponible('3 poemes pour Annabel Lee',virginMega,0.4).

disponible('Et puis merde, je vote à droite !',fnacmusic,0.2).
disponible('The Whistler',fnacmusic,0.7).
disponible('L\'agence des amants de madame Muller',fnacmusic,0.3).
disponible('Voici',fnacmusic,0.3).
disponible('With God on Our Side',fnacmusic,0.7).
disponible('Les Poètes',fnacmusic,0.2).
disponible('Mon père était tellement de gauche',fnacmusic,0.4).
disponible('3 poemes pour Annabel Lee',fnacmusic,0.4).

disponible('La Rose, la Bouteille et la Poignee de Main',musicme,0.3).
disponible('The Whistler',musicme,0.7).
disponible('L\'agence des amants de madame Muller',musicme,0.3).
disponible('Voici',musicme,0.5).
disponible('With God on Our Side',musicme,0.6).
disponible('Peace Train',fnacmusic,0.2).
disponible('Mon père était tellement de gauche',musicme,0.3).
disponible('3 poemes pour Annabel Lee',musicme,0.2).