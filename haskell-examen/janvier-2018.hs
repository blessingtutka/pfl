-- QUESTION 1
-- Simple
produit_scalaire :: [Float] -> [Float] -> Float
produit_scalaire xs [] =  0
produit_scalaire [] ys = 0 
produit_scalaire (x:xs) (y:ys) = (x*y) + produit_scalaire xs ys

-- Terminal
produit_scalaire_terminale :: [Float] -> [Float] -> Float
produit_scalaire_terminale xs ys = fAux xs ys 0 
    where fAux xs [] acc =  acc
          fAux [] ys acc = acc
          fAux (x:xs) (y:ys) acc = fAux xs ys ((x*y)+acc)

-- Implicite
produit_scalaire_implicite :: [Float] -> [Float] -> Float
produit_scalaire_implicite xs ys = foldr (\(x,y) r -> (x*y)+r) 0 (zip xs ys)

-- QUESTION 2
type Programme = [Clause]
type Clause = (Atome, [Atome])
data Atome = A Nom [Terme]
data Terme = V Variable | F Nom [Terme]
type Variable = String
type Nom = String


removeDuplicate :: Eq a => [a] -> [a]
removeDuplicate = foldl (\r x -> if x `elem` r then r else r ++ [x]) []

extraireVarTerm::Terme->[Variable]
extraireVarTerm (V var) = [var]
-- extraireVarTerm (F _ terms) = concatMap extraireVarTerm terms
extraireVarTerm (F _ terms) = removeDuplicate $ foldl (\vars term -> vars ++ extraireVarTerm term) [] terms

extraireVarAtome::Atome->[Variable]
extraireVarAtome (A _ terms)  = removeDuplicate $ foldl (\vars term -> vars ++ extraireVarTerm term) [] terms
 
term1 = V "x"
term2 = F "f" [V "x", F "g" [V "y", V "x"], V "z"] 
atome  = A "atoma" [F "f" [V "x", F "g" [V "y", V "x"], V "z"]]
 

-- QUESTION 3

type Id = Int
type Date = (String, String,String)
type City = String
type Tools = [String]

data User = User Id Date City Tools 

data GroupMember = Pay User | Free User

type Group = [GroupMember]

type Musica = [Group]

main :: IO ()
main =  do
putStr "Janvier 2018 \n"
print(produit_scalaire [1,2,3] [1,2,3])
print(produit_scalaire_terminale [1,2,3] [1,2,3])
print(produit_scalaire [1,2,3] [1,2,3])
print (extraireVarTerm term1)
print (extraireVarTerm term2)
print (extraireVarAtome atome)