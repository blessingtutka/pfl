-- Question 1

data Arbre a = Feuille a | Noeud a (Arbre a) (Arbre a) deriving (Show,Eq)

hauteurArbre :: Arbre a -> Int
hauteurArbre (Feuille _) = 0
hauteurArbre (Noeud x a1 a2) = 1 + max (hauteurArbre a1) (hauteurArbre a2)

miroirArbre :: Arbre a -> Arbre a
miroirArbre (Feuille x) = Feuille x
miroirArbre (Noeud x a1 a2) = Noeud x (miroirArbre a2) (miroirArbre a1)

arbre1  = Noeud 10 (Noeud 5 (Noeud 2 (Feuille 1) (Feuille 4)) (Feuille 6)) (Noeud 9 (Noeud 11 (Feuille 7) (Feuille 15)) (Feuille 18))

-- Question 2

repeatChar :: Char -> Int -> [Char]
repeatChar c n  = [c | _ <- [1..n]]

decoder :: [(Char, Int)]-> String
decoder [] = ""
decoder ((x,y):cs) = repeatChar x y ++ decoder cs

main :: IO ()
main =  do
putStr "Janvier 2024 \n"
print(show(miroirArbre arbre1))
print(show(hauteurArbre arbre1))