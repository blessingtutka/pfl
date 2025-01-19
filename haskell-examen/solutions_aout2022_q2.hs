import Data.List
import System.IO

--- Q2
carre_magique :: [[Int]] -> Either (Maybe Int) String 
carre_magique carre 
   | non_carre carre = Right "Erreur, ce n'est pas un carré valide"
   | non_chiffres carre = Right "Erreur, ce n'est pas un carré valide"
   | non_magique carre = Left Nothing
   | otherwise = Left (Just (constante_magique carre))

non_carre :: [[Int]] -> Bool
non_carre [] = False
non_carre (ls1:lss) = non_carre_aux (length ls1) (ls1:lss)
   where 
      non_carre_aux _ [] = False
      non_carre_aux l (lst1:lsts) = length lst1 /= l || non_carre_aux l lsts 

non_chiffres :: [[Int]] -> Bool 
non_chiffres [] = False
non_chiffres carre = not $ all (\n -> elem n flattenedList) [1..oc]
   where flattenedList = concat carre 
         oc = (length (head carre))^2

non_magique :: [[Int]] -> Bool
non_magique [] = False
non_magique (ls1:lss) = non_magique_aux (ls1:lss) || non_magique_aux trans || non_magique_diagonale (ls1:lss) || non_magique_diagonale trans 
   where 
      c = sum ls1
      trans = transpose (ls1:lss)
      non_magique_aux [] = False 
      non_magique_aux (lst1:lsts) =  (sum lst1) /= c || non_magique_aux lsts 
      non_magique_diagonale (lst1:lsts) = c /= (sum $ fst $ foldl (\(ls, l) lst -> (ls ++ [lst!!l], l+1)) ([], 0) (lst1:lsts))


constante_magique :: [[Int]] -> Int
constante_magique [] = 0
constante_magique (ls1:_) = sum ls1 