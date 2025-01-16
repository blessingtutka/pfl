addMe :: Integer -> Integer -> Integer
addMe x y = x + y

-- Aout 2024 


data Couleur = Coeur | Carreau | Pique | Trefle deriving (Show, Eq,Enum)
data Valeur = As | Un | Deux | Trois | Quatre | Cinq | Six | Sept | Huit | Neuf | 
    Dix | Valet | Dame | Roi deriving (Show, Eq, Ord,Enum)

 -- Question 1

data Carte = Carte Valeur Couleur  deriving (Show)

 -- Question 2

colors :: [Couleur]
colors = [Coeur .. Trefle]


valeurs :: [Valeur]
valeurs = [As .. Roi]

paquet :: [Carte]
paquet = [Carte x y | x <- valeurs, y <- colors]

 -- Question 3

combine :: ([t],[t]) -> ([t],[t]) -> ([t], [t])
combine (xs1, xs2) (ys1, ys2) = (xs1 ++ ys1, xs2 ++ ys2)

sumPoint :: (Int,Int) -> (Int, Int) -> (Int, Int)
sumPoint (xs1, xs2) (ys1, ys2) = (xs1 + ys1, xs2 + ys2)

-- shuffle :: [Carte] -> [Carte]
-- shuffle

piocheMain :: [Carte] -> Int ->  ([Carte], [Carte])
piocheMain cartes 0 = ([],[])
piocheMain cartes n |length cartes < 2*n = ([],[])
                    |otherwise = ( take n cartes, take n (drop n cartes))

-- Question 4
points :: Carte  -> Carte -> ([Int],[Int]) 
points (Carte v1 c1) (Carte v2 c2) = ([1],[1])


rounds :: Int -> ([Carte], [Carte]) -> ([Int], [Int])
rounds 0 ([], []) = ([], [])
rounds n ((c1:cards1), (c2:cards2)) = combine (points c1 c2) (rounds (n-1) (cards1,cards2))



main :: IO ()
main =  do
putStr "Sum of x + y = "
print(show(rounds 4 (piocheMain paquet 4)))