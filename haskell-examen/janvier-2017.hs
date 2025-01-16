-- QUESTION 1
-- Simple/Explicite 
zipWiths :: (a->b->c) -> [a] -> [b] -> [c]
zipWiths _ xs [] = [] 
zipWiths _ [] ys = [] 
zipWiths f (x:xs) (y:ys) = (f x y):zipWiths f xs ys

-- Terminal
zipWithTerminal :: (a->b->c) -> [a] -> [b] -> [c]
zipWithTerminal f xs ys = fAux f xs ys []
                where fAux f [] ys acc = acc
                      fAux f xs [] acc = acc
                      fAux f (x:xs) (y:ys) acc = fAux f xs ys (acc ++ [(f x y)])


-- Implicite
zipWithImplicite :: (a->b->c) -> [a] -> [b] -> [c]
zipWithImplicite f xs ys = map (\(x,y) -> f x y) (zip xs ys)

-- QUESTION 2

splitter :: [Char] -> String ->  [String] 
splitter sep str =  fst result ++ (if not (null (snd result)) then [snd result] else [])
        where result = foldl (\(wordList,word) -> \char -> if char `elem` sep then  
                    if not (null word) then (wordList ++ [word],"") else (wordList,"") 
                    else (wordList, word ++ [char] )) ([],"") str


split :: String -> String -> [String]
-- if the world is not null then add
split str sep = if not (null (fst res)) then fst res:snd res else snd res
                where res = foldr (\char (word,phrase)-> if (char `elem` sep) 
                                                  then ("",if null word then phrase else word : phrase) 
                                                  else (char:word,phrase)) ("",[]) str
                                                  
lisibility :: String -> Float
lisibility str = 206.85 - x - y
                where x =  1.015 * ((fromIntegral mots) / (fromIntegral phrases))
                      y =   1.015 * ((fromIntegral (syllabe*100)) / (fromIntegral mots))
                      mots = length (split str " ,;().!?")
                      phrases = length (split str ".!?")
                      syllabe = length (filter (\x -> x `elem` "aeiouAEIOU") str)

-- QUESTION 3

data Utilisateur = Utilisateur Int Int String [Int] [Message] deriving (Show,Eq)
data Message = Private Utilisateur Utilisateur String String | Request Utilisateur Utilisateur String String deriving (Show,Eq)
type Couchsurfing = [Utilisateur]

-- intersect :: Eq a => [a] -> [a] -> [a]
-- intersect [] _ = []
-- intersect (x:xs) ys
--     | x `elem` ys = x : intersect xs ys
--     | otherwise   = intersect xs ys

friends :: Utilisateur -> Couchsurfing -> Couchsurfing
friends (Utilisateur id1 _ _ contacts1 _) members = filter (\(Utilisateur id2 _ _ contacts2 _) -> (id2 `elem` contacts1) && (id1 `elem` contacts2)) members


common :: Utilisateur -> Utilisateur  -> Int 
common (Utilisateur _ _ _ contacts1 _) (Utilisateur _ _ _ contacts2 _) = foldr (\x r -> if x `elem` contacts2 then r+1 else r) 0 contacts1


pertinance :: Message -> Int 
pertinance (Private expe desti _ _) = common expe desti
pertinance (Request expe desti _ _) = common expe desti

-- Exemple d'utilisateurs
utilisateur1 = Utilisateur 1 25 "Aime voyager" [2, 3] []
utilisateur2 = Utilisateur 2 30 "Aime recevoir" [1, 3] []
utilisateur3 = Utilisateur 3 28 "Aime les aventures" [1] []

-- Exemple de base de données
couchsurfingDB = [utilisateur1, utilisateur2, utilisateur3]

-- Exemple de messages
message1 = Private utilisateur1 utilisateur2 "2025-01-10" "Salut, on peut discuter ?"
message2 = Request utilisateur3 utilisateur1 "2025-02-01" "2025-02-05"

non_carre :: [[Int]] -> Bool
-- non_carre  ls = not $ length ((filter (\l -> (length l) /= (length ls)) ls)) > 1
non_carre [] = False
non_carre  ls = not $ any (\l -> (length l) /= (length ls)) ls

main :: IO ()
main =  do
putStr "Sum of x + y = \n"
print(friends utilisateur1 couchsurfingDB)
print(pertinance message1)